# 🧪 App de Referencia — Biblioteca

Aplicación común sobre la que se hacen las prácticas de despliegue (semanas 4 a 10). Su objetivo
no es enseñar a programar sino tener un software realista que implantar: imagen de contenedor,
base de datos con migraciones, configuración por variables de entorno, healthcheck y versión.

| Componente | Tecnología |
|---|---|
| Backend | FastAPI (Python 3.13) |
| Frontend | React 19 + Vite, compilado y servido por el backend |
| Base de datos | PostgreSQL 17 |
| Empaquetado | Una sola imagen Docker (multi-etapa) |

## Estructura

```
referencia/
├── Dockerfile                ← etapa 1 compila React, etapa 2 API + frontend
├── compose.yaml              ← desarrollo local: db + app (construye la imagen)
├── .env.example
├── api/
│   ├── app/main.py           ← endpoints, migraciones al arrancar, archivos estáticos
│   ├── migrations/           ← 001_libros.sql, 002_..., se aplican en orden una sola vez
│   ├── requirements.in       ← dependencias directas
│   └── requirements.txt      ← versiones fijadas (pip-compile)
├── web/                      ← React: src/App.jsx, package.json, package-lock.json
├── scripts/smoke-test.sh     ← prueba de humo contra cualquier URL
└── deploy/
    ├── compose.prod.yaml     ← servidor Linux: proxy Caddy + app (imagen liberada) + db
    ├── Caddyfile
    ├── env.prod.example
    └── render.yaml           ← Blueprint para Render (plan gratuito)
```

## Endpoints

| Método | Ruta | Respuesta |
|---|---|---|
| GET | `/api/health` | `200 {"status":"ok"}` si la API alcanza la base; `503` si no |
| GET | `/api/version` | Versión desplegada (`APP_VERSION`) |
| GET | `/api/libros` | Lista de libros |
| POST | `/api/libros` | `201` creado · `409` ISBN duplicado · `422` datos inválidos |
| GET | `/` | Frontend React |

## Configuración

| Variable | Obligatoria | Uso |
|---|:---:|---|
| `DATABASE_URL` | ✅ | Cadena de conexión PostgreSQL (`postgresql://usuario:clave@host:5432/base`) |
| `APP_VERSION` | — | Versión que muestra la app (por defecto la fijada al construir la imagen) |
| `PORT` | — | Puerto de escucha (por defecto 8000; lo define el PaaS) |

## Ejecutar en local

```bash
cp .env.example .env
docker compose up -d --build --wait
bash scripts/smoke-test.sh
```

Abrir <http://localhost:8000>.

## Requisitos mínimos

| Recurso | Mínimo |
|---|---|
| CPU | 1 núcleo |
| RAM | 1024 MB |
| Disco libre | 10 GB |
| Sistema operativo | Ubuntu 22.04 o superior, x86_64 o aarch64 |
| Docker Engine | 24.0 o superior |
| Puertos libres | 80, 443 (despliegue con `deploy/compose.prod.yaml`) |

Son los umbrales del script de verificación de la
[semana 1](../bootcamp/week-01-plataforma_tecnologica_y_hardware/2-practicas/02-script-verificacion-requisitos/README.md).

Todos los datos son sintéticos.
