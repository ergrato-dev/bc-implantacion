# 🧪 Laboratorio de la Semana 5

La app de referencia con **dos** servidores PostgreSQL: el `origen` (donde vive hoy) y un
`destino` que simula una base gestionada en la nube, con otra versión, otro usuario dueño y otro
nombre de base. Lo usan las tres prácticas de la semana.

| Servicio | Imagen | Usuario / base | Papel |
|---|---|---|---|
| `origen` | `postgres:16-alpine` | `biblioteca` / `biblioteca` | Base actual del servidor |
| `destino` | `postgres:17-alpine` | `propietario_nube` / `nubedb` | Base "gestionada" |
| `app` | Construida desde [`referencia/`](../../../../referencia/README.md) | — | Apunta a la base que diga `DATABASE_URL` |

```
laboratorio/
├── compose.yaml
├── .env.example      ← DATABASE_URL de origen (activa) y de destino (comentada)
├── sql/validar.sql   ← huella: filas y checksum por tabla
└── respaldos/        ← volcados .dump (ignorados por Git)
```

## Comandos

Desde esta carpeta:

```bash
cp .env.example .env
docker compose up -d --build --wait
bash ../../../../referencia/scripts/smoke-test.sh      # la app en http://localhost:8000
docker compose down -v                                  # borrar todo al terminar
```

Consola SQL de cada base:

```bash
docker compose exec origen psql -U biblioteca -d biblioteca
docker compose exec destino psql -U propietario_nube -d nubedb
```

Las contraseñas del `compose.yaml` son solo de laboratorio.
