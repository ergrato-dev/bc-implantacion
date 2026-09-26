"""API de referencia del bootcamp: catálogo de libros de una biblioteca.

Deliberadamente pequeña: su objetivo es tener algo real que implantar
(configuración, base de datos, migraciones, healthcheck, versión), no enseñar FastAPI.
"""

import os
from contextlib import asynccontextmanager
from pathlib import Path

import psycopg
from fastapi import FastAPI, HTTPException
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel, Field

DATABASE_URL = os.environ["DATABASE_URL"]
APP_VERSION = os.environ.get("APP_VERSION", "dev")
MIGRATIONS_DIR = Path(__file__).resolve().parent.parent / "migrations"
STATIC_DIR = Path(__file__).resolve().parent.parent / "static"


def conectar():
    return psycopg.connect(DATABASE_URL, connect_timeout=5)


def aplicar_migraciones():
    """Aplica en orden los archivos migrations/NNN_*.sql que aún no se han aplicado."""
    with conectar() as conn:
        # Candado: si arrancan dos instancias a la vez, solo una aplica migraciones.
        conn.execute("SELECT pg_advisory_lock(20260925)")
        # Se consulta antes de crear: así un rol sin permiso CREATE (semana 6) puede arrancar
        # la app cuando las migraciones ya las aplicó el rol dueño.
        if conn.execute("SELECT to_regclass('schema_migrations')").fetchone()[0] is None:
            conn.execute(
                "CREATE TABLE schema_migrations ("
                " version TEXT PRIMARY KEY, aplicada_en TIMESTAMPTZ NOT NULL DEFAULT now())"
            )
        aplicadas = {fila[0] for fila in conn.execute("SELECT version FROM schema_migrations")}
        for archivo in sorted(MIGRATIONS_DIR.glob("*.sql")):
            if archivo.stem in aplicadas:
                continue
            with conn.transaction():
                conn.execute(archivo.read_text())
                conn.execute("INSERT INTO schema_migrations (version) VALUES (%s)", (archivo.stem,))
            print(f"Migración aplicada: {archivo.stem}", flush=True)


@asynccontextmanager
async def ciclo_de_vida(_app: FastAPI):
    aplicar_migraciones()
    yield


app = FastAPI(title="Biblioteca — API de referencia", version=APP_VERSION, lifespan=ciclo_de_vida)


class LibroNuevo(BaseModel):
    isbn: str = Field(min_length=10, max_length=13)
    titulo: str = Field(min_length=1, max_length=200)
    autor: str = Field(min_length=1, max_length=120)
    anio: int = Field(ge=1450, le=2100)


class Libro(LibroNuevo):
    id: int


@app.get("/api/health")
def health():
    """Verifica que la API responde Y que alcanza la base de datos."""
    try:
        with conectar() as conn:
            conn.execute("SELECT 1")
    except psycopg.Error as error:
        raise HTTPException(status_code=503, detail=f"base de datos no disponible: {error.__class__.__name__}")
    return {"status": "ok", "version": APP_VERSION}


@app.get("/api/version")
def version():
    return {"version": APP_VERSION}


@app.get("/api/libros", response_model=list[Libro])
def listar_libros():
    with conectar() as conn:
        filas = conn.execute("SELECT id, isbn, titulo, autor, anio FROM libros ORDER BY id").fetchall()
    return [Libro(id=f[0], isbn=f[1], titulo=f[2], autor=f[3], anio=f[4]) for f in filas]


@app.post("/api/libros", response_model=Libro, status_code=201)
def crear_libro(libro: LibroNuevo):
    try:
        with conectar() as conn:
            fila = conn.execute(
                "INSERT INTO libros (isbn, titulo, autor, anio) VALUES (%s, %s, %s, %s) RETURNING id",
                (libro.isbn, libro.titulo, libro.autor, libro.anio),
            ).fetchone()
    except psycopg.errors.UniqueViolation:
        raise HTTPException(status_code=409, detail="ya existe un libro con ese ISBN")
    return Libro(id=fila[0], **libro.model_dump())


# El frontend React compilado se sirve desde la misma aplicación: una sola imagen,
# un solo servicio que desplegar. Se monta al final para no tapar las rutas /api.
if STATIC_DIR.is_dir():
    app.mount("/", StaticFiles(directory=STATIC_DIR, html=True), name="frontend")


# Migraciones como paso aparte, con el rol dueño de las tablas:
#   docker compose run --rm -e DATABASE_URL=<url del dueño> app python -m app.main
if __name__ == "__main__":
    aplicar_migraciones()
