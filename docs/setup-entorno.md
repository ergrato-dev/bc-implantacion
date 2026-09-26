# 🛠️ Preparación del Entorno

## Equipo del aprendiz

| Recurso | Recomendado | Por qué |
|---|---|---|
| RAM | 8 GB o más | Varios laboratorios levantan 3 a 5 contenedores y construyen la imagen de la app |
| Disco libre | 25 GB | Imágenes de Docker de las 10 semanas; se liberan con `docker system prune` |
| Sistema | Linux o Windows con WSL2 (Ubuntu) | Todos los laboratorios se probaron en Ubuntu sobre WSL2 |
| Red | Salida a Internet | Descarga de imágenes, paquetes y dependencias |

> En macOS con Docker Desktop funcionan casi todos los laboratorios; el de la semana 10 (systemd
> y Docker dentro de un contenedor privilegiado) puede no funcionar: en ese caso usa la VM del
> laboratorio o Multipass.

## Herramientas locales

| Herramienta | Uso | Semanas |
|---|---|---|
| Git | Control de versiones | Todas |
| Docker Engine + Compose v2 | Laboratorios y app de referencia | Todas |
| `bash`, `curl`, `openssl` | Scripts, pruebas de humo, generación de secretos | Todas |
| Cliente SSH (`ssh`, `scp`, `sftp`, `rsync`) | Acceso al servidor y transferencia de archivos | 3, 6, 9 |
| `dig` (paquete `dnsutils` / `bind9-dnsutils`) | Consultas DNS | 3 |
| Editor (VS Code o similar) | Edición de archivos y planes | Todas |
| CLI de GitHub (`gh`) — opcional | Ver ejecuciones de Actions y pull requests | 7, 8 |
| `cloud-init` — opcional | Validar `user-data` (también se puede usar desde un contenedor) | 10 |

Herramientas que **no** hace falta instalar porque corren en contenedores: restic, Ansible,
OpenTofu, Trivy, `pip-audit`, Uptime Kuma.

## Servidor

Una de estas dos opciones, según disponibilidad del ambiente de formación:

1. **VM Ubuntu Server LTS del laboratorio** — el instructor entrega usuario y acceso SSH por llave.
2. **Contenedores** del laboratorio de cada semana (un "servidor" Ubuntu o una carpeta que
   simula `/opt/biblioteca`), cuando no hay VM disponible.

> Nunca publicar en el repositorio IPs, nombres de host ni credenciales del laboratorio.

## Cuentas free tier

| Servicio | Uso | Tarjeta | Semana |
|---|---|:---:|:---:|
| GitHub | Repositorio, Actions, GHCR, Dependabot | No | 4 |
| Render | Despliegue PaaS | No | 4 |
| Neon o Supabase | PostgreSQL gestionado | No | 4 |

Las condiciones de los planes gratuitos cambian: el instructor las verifica al inicio de cada
curso (semana 4, teoría de costos). Las cuentas se crean en la semana 4; no se requieren antes.
