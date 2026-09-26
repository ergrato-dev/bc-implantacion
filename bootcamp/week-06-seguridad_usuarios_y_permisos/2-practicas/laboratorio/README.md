# 🧪 Laboratorio de la Semana 6

Un servidor Ubuntu para endurecer, la app de referencia con su base y un segundo servidor que
guarda la copia de respaldo fuera del sitio. Lo usan las tres prácticas de la semana.

| Servicio | Imagen | Papel |
|---|---|---|
| `servidor` | Construida desde [`servidor/`](servidor/Dockerfile) (Ubuntu 24.04) | Simula la VM Ubuntu del laboratorio: usuarios, SSH, sudo, UFW, cron, restic, cliente de PostgreSQL 17 |
| `db` | `postgres:17-alpine` | Base de la app; superusuario `postgres` |
| `app` | Construida desde [`referencia/`](../../../../referencia/README.md) | Se conecta con el rol que diga `DATABASE_URL` |
| `externo` | `restic/rest-server` | Copia fuera del sitio, en modo solo-agregar |

```
laboratorio/
├── compose.yaml
├── .env.example              ← contraseña de postgres y DATABASE_URL de la app
├── servidor/                 ← imagen del servidor Ubuntu
├── sql/
│   ├── 01-roles.sql          ← roles de mínimo privilegio (práctica 02)
│   ├── 02-permisos.sql       ← dueños y privilegios (práctica 02)
│   └── validar.sql           ← huella de la base (semana 5)
├── migraciones/002_prestamos.sql   ← migración nueva para probar permisos futuros
└── respaldo/respaldar.sh     ← script de respaldo cifrado (práctica 03)
```

## Comandos

Desde esta carpeta:

```bash
cp .env.example .env
docker compose up -d --build --wait
bash ../../../../referencia/scripts/smoke-test.sh     # la app en http://localhost:8000
docker compose down -v                                 # borrar todo al terminar
```

Consolas:

```bash
docker compose exec servidor bash                      # root en el servidor
docker compose exec db psql -U postgres -d biblioteca  # superusuario de la base
```

El servidor publica SSH en `127.0.0.1:2226`. Si recreas el contenedor, su llave de host cambia y
SSH lo advierte; borra la entrada vieja con `ssh-keygen -R "[127.0.0.1]:2226"`.

## Diferencias con la VM real

| En el laboratorio | En la VM Ubuntu del laboratorio |
|---|---|
| Entras como `root` con `docker compose exec` | Entras con tu usuario por SSH y usas `sudo` |
| Recargar SSH: `kill -HUP 1` | `sudo systemctl reload ssh` |
| Las reglas de UFW se pierden al recrear el contenedor | UFW las carga al arrancar |
| El script de reinicio de la app es simulado | Ejecuta `docker compose restart app` |

Todas las contraseñas de este laboratorio son de ejemplo. Ninguna se usa fuera de él.
