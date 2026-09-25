# 🧪 Laboratorio de la Semana 3

Un "servidor de hosting" completo en contenedores: reverse proxy con HTTPS, un sitio estático,
una API y un servidor SFTP para publicar archivos. Lo usan las prácticas
[02](../02-sitio-y-reverse-proxy/README.md) y [03](../03-transferencia-sftp/README.md).

## Arquitectura

| Servicio | Imagen | Función | Puerto en tu equipo |
|---|---|---|---|
| `proxy` | `caddy:2-alpine` | Reverse proxy, HTTPS, sirve el sitio estático | 8080 (HTTP), 8443 (HTTPS) |
| `api` | `traefik/whoami` | API de ejemplo: responde con los datos de la petición | — (solo por el proxy) |
| `sftp` | `atmoz/sftp:alpine` | Recibe archivos del usuario `deploy` | 2222 |

El volumen `sitio` está montado en `sftp` (escritura) y en `proxy` (solo lectura): lo que subes
por SFTP queda publicado de inmediato.

```
laboratorio/
├── compose.yaml
├── caddy/Caddyfile      ← configuración de los dos sitios
├── sftp-permisos.sh     ← da permiso de escritura a deploy sobre el volumen
├── llaves/              ← aquí va tu llave pública SSH (ignorada por Git)
└── publicar/index.html  ← archivo que subirás en la práctica 03
```

## Comandos

Desde esta carpeta:

```bash
docker compose up -d --wait     # levantar
docker compose ps               # estado
docker compose logs proxy       # ver registros del proxy
docker compose down -v          # detener y borrar volúmenes
```

## Nombres de dominio de laboratorio

Los dominios `sitio.lab.test` y `api.lab.test` no existen en Internet (`.test` está reservado
para pruebas). Para llegar a ellos sin tocar la configuración de tu equipo, `curl` los resuelve
a mano con `--resolve`:

```bash
curl -k --resolve sitio.lab.test:8443:127.0.0.1 https://sitio.lab.test:8443/
```

`-k` acepta el certificado de la CA interna de Caddy (ver práctica 02).

> Credenciales del usuario `deploy` (`deploy-lab`): **solo de laboratorio**. En un servidor real
> el acceso es con llave SSH y sin contraseña.
