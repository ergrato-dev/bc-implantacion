# 🧪 Laboratorio de la Semana 7

Un servidor de producción en miniatura: la app de referencia tomada de un **registro de
imágenes** (como GHCR, pero local), su base de datos, Uptime Kuma para vigilarla y un receptor de
alertas. Lo usan las prácticas [03](../03-despliegue-en-servidor-con-rollback/README.md) y
[04](../04-monitoreo-con-uptime-kuma/README.md). Las prácticas 01 y 02 se hacen en GitHub.

| Servicio | Imagen | Papel | En tu equipo |
|---|---|---|---|
| `registro` | `registry:3` | Registro de imágenes: hace el papel de GHCR | `localhost:5000` |
| `db` | `postgres:17-alpine` | Base de la app | — |
| `app` | `${IMAGEN}:${APP_VERSION}` del registro | App de referencia en la versión de `.env` | <http://localhost:8000> |
| `kuma` | `louislam/uptime-kuma:2` | Monitoreo y alertas | <http://localhost:3001> |
| `alertas` | `mendhak/http-https-echo` | Recibe los webhooks de Uptime Kuma y los imprime en su log | — |

```
laboratorio/
├── compose.yaml
├── .env.example      ← IMAGEN, APP_VERSION, credenciales de la base, URL_APP
└── .gitignore        ← ignora las copias de trabajo de desplegar.sh y lo que generan
```

## Comandos

Desde esta carpeta:

```bash
cp .env.example .env
docker compose up -d --wait registro db kuma alertas    # la app necesita su imagen en el registro
docker compose logs alertas                               # alertas recibidas
docker compose down -v                                    # borrar todo al terminar
```

La app no arranca hasta que la versión de `APP_VERSION` esté publicada en el registro (práctica
03, parte 1).

El registro escucha solo en `localhost`, así que Docker acepta publicar en él sin HTTPS. Un
registro real (GHCR, el de GitLab) siempre usa HTTPS y autenticación.

Las contraseñas de este laboratorio son de ejemplo.
