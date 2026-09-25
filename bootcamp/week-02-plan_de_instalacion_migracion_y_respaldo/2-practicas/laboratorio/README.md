# 🧪 Laboratorio de la Semana 2

PostgreSQL 17 con la base de datos sintética de una biblioteca. Lo usan las prácticas
[01](../01-respaldo-y-restauracion/README.md) y [02](../02-migracion-de-datos/README.md).

## Contenido

```
laboratorio/
├── compose.yaml
├── initdb/
│   ├── 01-esquema.sql            ← tablas socios, libros, prestamos
│   └── 02-datos-sinteticos.sql   ← 200 socios, 100 libros, 500 préstamos
├── datos-legados/
│   └── clientes_legado.csv       ← exportación del "sistema viejo" (práctica 02)
└── respaldos/                    ← aquí quedan los .dump (ignorados por Git)
```

Los datos son sintéticos y deterministas: todos los aprendices obtienen los mismos conteos.

## Comandos

Ejecuta todo **desde esta carpeta**:

```bash
docker compose up -d --wait          # levantar (la primera vez crea y llena la base)
docker compose exec db psql -U biblioteca -d biblioteca    # consola SQL
docker compose down                  # detener conservando los datos
docker compose down -v               # detener y BORRAR los datos (vuelve al estado inicial)
```

Comprobación rápida:

```bash
docker compose exec -T db psql -U biblioteca -d biblioteca -c \
  "SELECT (SELECT count(*) FROM socios) AS socios, (SELECT count(*) FROM libros) AS libros, (SELECT count(*) FROM prestamos) AS prestamos;"
```

Resultado esperado: `200 | 100 | 500`.

> El contenedor no publica el puerto 5432 en el equipo: así no choca con otro PostgreSQL que
> tengas instalado. Todas las prácticas usan `docker compose exec`.
