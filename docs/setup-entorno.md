# 🛠️ Preparación del Entorno

## Local

| Herramienta | Uso |
|---|---|
| Git | Control de versiones |
| Docker Engine + Compose | App de referencia y servicios de práctica |
| Cliente SSH (`ssh`, `scp`, `rsync`) | Acceso al servidor y transferencia de archivos |
| Editor (VS Code o similar) | Edición de archivos y planes |

En Windows se trabaja dentro de WSL2 (Ubuntu).

## Servidor

Una de estas dos opciones, según disponibilidad del ambiente de formación:

1. **VM Ubuntu Server LTS del laboratorio** — el instructor entrega usuario y acceso SSH por llave.
2. **Contenedor `ubuntu:24.04`** con Docker, cuando no hay VM disponible.

> Nunca publicar en el repositorio IPs, nombres de host ni credenciales del laboratorio.

## Cuentas free tier

| Servicio | Uso | Tarjeta |
|---|---|:---:|
| GitHub | Repositorio, Actions, GHCR | No |
| Render | Despliegue PaaS | No |
| Neon o Supabase | PostgreSQL gestionado | No |
| DuckDNS | Subdominio gratuito | No |

Las cuentas se crean en la semana 4; no se requieren antes.
