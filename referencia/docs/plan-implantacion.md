# 📘 Plan de Implantación — Biblioteca (app de referencia)

> Ejemplo consolidado del Plan de Implantación, escrito para la app de referencia del bootcamp.
> Es el modelo de la semana 9 y el documento que se sigue en el simulacro de práctica. Todos los
> datos son sintéticos: no hay IPs, usuarios ni contraseñas reales.

| Campo | Valor |
|---|---|
| Proyecto | Biblioteca — catálogo de libros |
| Equipo | Equipo de la app de referencia |
| Versión del plan | 1.0 |
| Versión del software | 1.0.0 |
| Fecha | 2026-10 |

## Índice

1. [Ficha técnica y requisitos mínimos](#1-ficha-técnica-y-requisitos-mínimos)
2. [Plan de migración de datos](#2-plan-de-migración-de-datos)
3. [Plan de respaldo y restauración](#3-plan-de-respaldo-y-restauración)
4. [Hosting y dominio](#4-hosting-y-dominio)
5. [Plan de instalación](#5-plan-de-instalación)
6. [Configuración y verificación](#6-configuración-y-verificación)
7. [Seguridad, usuarios y permisos](#7-seguridad-usuarios-y-permisos)
8. [Pipeline de despliegue y monitoreo](#8-pipeline-de-despliegue-y-monitoreo)
9. [Mantenimiento, soporte y capacitación](#9-mantenimiento-soporte-y-capacitación)
10. [Aceptación y entrega](#10-aceptación-y-entrega)

---

## 1. Ficha técnica y requisitos mínimos

| Componente | Tecnología | Versión |
|---|---|---|
| API + frontend | FastAPI (Python) + React, en **una** imagen | Python 3.13, imagen `biblioteca:<versión>` |
| Base de datos | PostgreSQL | 17 |
| Proxy y HTTPS | Caddy | 2 |
| Sistema operativo del servidor | Ubuntu Server LTS | 22.04 o superior |
| Contenedores | Docker Engine + Compose v2 | Engine 24 o superior |

| Recurso | Mínimo |
|---|---|
| CPU | 1 núcleo |
| RAM | 1024 MB |
| Disco libre | 10 GB |
| Puertos libres | 80 y 443 (o los de `PUERTO_HTTP` y `PUERTO_HTTPS`) |

Verificación: script de la semana 1
([`verificar-requisitos.sh`](../../bootcamp/week-01-plataforma_tecnologica_y_hardware/2-practicas/02-script-verificacion-requisitos/verificar-requisitos.sh)),
debe terminar con código `0`.

## 2. Plan de migración de datos

| Campo | Valor |
|---|---|
| Origen | Base PostgreSQL de la instalación anterior |
| Destino | PostgreSQL 17 del servidor nuevo (o base gestionada en la nube) |
| Método | `pg_dump -Fc` → `pg_restore --no-owner` |
| Validación | Huella por tabla ([`scripts/huella.sql`](../scripts/huella.sql)) idéntica en origen y destino |
| Ventana | Escrituras detenidas (`docker compose stop app`) desde el volcado hasta el corte |
| Rollback | Volver a apuntar la app al origen, que no se modifica |

El procedimiento es el mismo de la restauración (sección 3.3), con el volcado tomado del origen
en lugar de un respaldo.

## 3. Plan de respaldo y restauración

| Campo | Valor |
|---|---|
| Qué se respalda | Base de datos (volcado lógico). El código y la imagen se reconstruyen desde Git |
| RPO / RTO | 24 h / 4 h |
| Herramienta | `pg_dump` + restic (cifrado AES-256) |
| Horario | Diario, 02:15 (cron del usuario de sistema `respaldo`) |
| Retención | 7 diarios, 4 semanales, 12 mensuales |
| Copias (3-2-1) | Producción · repositorio restic local · repositorio restic externo solo-agregar |
| Contraseña de restic | En el servidor (`/etc/restic/password`, `600`) **y** en el gestor de contraseñas del equipo |
| Verificación | `restic check` en cada ejecución; restauración de prueba mensual; latido a Uptime Kuma |

Script: [`respaldar.sh`](../../bootcamp/week-06-seguridad_usuarios_y_permisos/2-practicas/laboratorio/respaldo/respaldar.sh).

### 3.1 Qué se necesita para restaurar

- Acceso de lectura al repositorio restic (carpeta, SFTP o `rest-server`) y su **contraseña**
- La huella de la base tomada junto con el respaldo, si existe
- La instalación de la sección 5 hecha hasta el paso 5.5

### 3.2 Si los roles de la base son de mínimo privilegio

Si la instalación usa los roles de la sección 7, créalos **antes** de restaurar: el volcado no
los trae. En la instalación básica de este plan no hace falta.

### 3.3 Procedimiento

En la carpeta de la instalación (`$DESTINO`), con `ENTREGA` apuntando a la carpeta que contiene
el repositorio `restic/` y `huella.txt`:

1. Levantar **solo** la base, sin la app:

   ```bash
   docker compose up -d --wait db
   ```

2. Cargar la contraseña de restic sin que quede en el historial ni en pantalla:

   ```bash
   read -rs RESTIC_PASSWORD && export RESTIC_PASSWORD
   ```

3. Ver la instantánea más reciente y extraer el volcado:

   ```bash
   docker run --rm -e RESTIC_PASSWORD -v "$ENTREGA/restic:/repo:ro" restic/restic \
     -r /repo --no-cache --no-lock snapshots --latest 1
   docker run --rm -e RESTIC_PASSWORD -v "$ENTREGA/restic:/repo:ro" restic/restic \
     -r /repo --no-cache --no-lock dump latest biblioteca.dump > biblioteca.dump
   ```

4. Restaurar y comprobar la huella:

   ```bash
   docker compose exec -T db sh -c 'pg_restore -U "$POSTGRES_USER" -d "$POSTGRES_DB" --no-owner' < biblioteca.dump
   docker compose exec -T db sh -c 'psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -tA' < huella.sql > huella-restaurada.txt
   diff "$ENTREGA/huella.txt" huella-restaurada.txt && echo "HUELLAS IDÉNTICAS"
   ```

5. Levantar el resto y verificar (sección 5.7). Al terminar:

   ```bash
   rm biblioteca.dump && unset RESTIC_PASSWORD
   ```

Si las huellas no coinciden: **no** poner en servicio; revisar qué tabla difiere y si la
instantánea es la esperada.

## 4. Hosting y dominio

| Campo | Valor |
|---|---|
| Servidor propio | VM Ubuntu del laboratorio, Docker + Compose |
| Nube | Render (servicio web desde imagen de GHCR) + Neon (PostgreSQL gestionado) |
| Dominio | Subdominio del proveedor en la nube; en el laboratorio, `biblioteca.lab.test` (resolución manual) |
| HTTPS | Caddy: Let's Encrypt con dominio público; CA interna (`tls internal`) en el laboratorio |
| Transferencia de archivos | SFTP / `rsync` sobre SSH con llave |

## 5. Plan de instalación

Instalación en un servidor Linux con Docker. Cada paso termina con una verificación.

### 5.1 Prerrequisitos

- Requisitos de la sección 1 verificados
- Código fuente de la versión a instalar (etiqueta `v1.0.0` del repositorio) **o** acceso a la
  imagen en GHCR
- Para restaurar datos: el repositorio restic, su contraseña y la huella (sección 3.1)

### 5.2 Variables de trabajo

Definir en la terminal (ajustar las rutas):

```bash
DESTINO=/opt/biblioteca          # carpeta de la instalación; en un equipo de prueba: ~/simulacro/biblioteca
FUENTE=~/bc-implantacion/referencia   # carpeta del código en la etiqueta a instalar (la que contiene el Dockerfile)
```

### 5.3 Carpeta de la instalación

En `/opt` la carpeta la crea un administrador: `sudo install -d -o "$USER" -m 750 "$DESTINO"`.

```bash
mkdir -p "$DESTINO" && cd "$DESTINO"
cp "$FUENTE/deploy/compose.prod.yaml" compose.yaml
cp "$FUENTE/deploy/Caddyfile" "$FUENTE/deploy/desplegar.sh" .
cp "$FUENTE/scripts/smoke-test.sh" "$FUENTE/scripts/huella.sql" .
cp "$FUENTE/deploy/env.prod.example" .env && chmod 600 .env
ls -la
```

Verificación: seis archivos, `.env` con permisos `-rw-------`.

### 5.4 Configuración

Editar `.env`:

| Variable | Valor en el servidor | Valor en un equipo de prueba |
|---|---|---|
| `DOMINIO` | El dominio público | `biblioteca.lab.test` |
| `PUERTO_HTTP` / `PUERTO_HTTPS` | `80` / `443` | `8080` / `8443` |
| `IMAGEN` | `ghcr.io/<usuario>/biblioteca` | `biblioteca` |
| `APP_VERSION` | `1.0.0` | `1.0.0` |
| `POSTGRES_PASSWORD` | Generada: `openssl rand -hex 24` | Igual |
| `URL_APP` | `https://<dominio>` | `https://biblioteca.lab.test:8443` |

Solo en un equipo de prueba (dominio `.test`, sin certificado público):

```bash
sed -i 's/# tls internal/tls internal/' Caddyfile
```

Verificación: `docker compose config --quiet` no muestra errores.

### 5.5 Imagen

Desde GHCR (servidor con salida a Internet):

```bash
docker compose pull app
```

O construida desde el código de la etiqueta:

```bash
docker build -t biblioteca:1.0.0 --build-arg APP_VERSION=1.0.0 "$FUENTE"
```

Verificación: `docker image ls` muestra la imagen con la etiqueta `1.0.0`.

### 5.6 Arranque

- **Instalación limpia** (sin datos previos): `docker compose up -d --wait`
- **Con datos de un respaldo**: seguir la sección 3.3 y luego `docker compose up -d --wait`

Verificación: `docker compose ps` muestra `proxy`, `app` y `db` en ejecución y `app` y `db`
como `healthy`.

### 5.7 Verificación final

En el servidor:

```bash
bash smoke-test.sh "https://<dominio>"
```

En un equipo de prueba:

```bash
CURL_OPTS="-k --resolve biblioteca.lab.test:8443:127.0.0.1" bash smoke-test.sh https://biblioteca.lab.test:8443
```

Criterio: `RESULTADO: todas las pruebas pasaron.` y la versión esperada.

### 5.8 Actualizaciones y rollback

`bash desplegar.sh <versión>` (sección 8). Rollback: `bash desplegar.sh <versión anterior>`.
Requiere que `IMAGEN` apunte a un registro (GHCR): `desplegar.sh` descarga cada versión con
`docker compose pull`.

### 5.9 Nube (Render + Neon)

Servicio web desde la imagen `ghcr.io/<usuario>/biblioteca:<versión>`, `DATABASE_URL` de Neon en
el panel, *health check path* `/api/health`. Procedimiento completo en la práctica 02 de la
semana 7.

## 6. Configuración y verificación

| Variable | ¿Secreto? | Servidor | Nube | Si falta |
|---|:---:|---|---|---|
| `DATABASE_URL` (armada desde `POSTGRES_*`) | Sí | `.env` (`600`) | Panel de Render | La app no arranca |
| `APP_VERSION` | No | `.env` | Imagen | Muestra la versión de la imagen |
| `DOMINIO`, `PUERTO_*`, `URL_APP` | No | `.env` | — | Compose no arranca el proxy |

| Servicio | Depende de | Reinicio | Healthcheck | Logs |
|---|---|---|---|---|
| `proxy` | `app` sana | `unless-stopped` | — | 3 × 10 MB |
| `app` | `db` sana | `unless-stopped` | `/api/health` (verifica la base) | 3 × 10 MB |
| `db` | — | `unless-stopped` | `pg_isready` | 3 × 10 MB |

Pruebas después de cada despliegue: `smoke-test.sh` (6 verificaciones) + versión reportada.

## 7. Seguridad, usuarios y permisos

| Capa | Medida |
|---|---|
| Firewall | UFW: solo 22, 80, 443 |
| SSH | Solo llave, sin `root`, `AllowGroups sudo despliegue` |
| Usuarios | Una cuenta por persona; `despliegue` con `sudo` limitado a un script |
| Base de datos | Roles `biblioteca_owner` (migraciones), `biblioteca_app` (datos), `biblioteca_respaldo` (lectura) |
| Secretos | `.env` `600`; contraseña de restic también fuera del servidor |

Scripts de roles: [`01-roles.sql`](../../bootcamp/week-06-seguridad_usuarios_y_permisos/2-practicas/laboratorio/sql/01-roles.sql)
y [`02-permisos.sql`](../../bootcamp/week-06-seguridad_usuarios_y_permisos/2-practicas/laboratorio/sql/02-permisos.sql).

**Pendiente conocido:** `compose.prod.yaml` conecta la app con el usuario creado por la imagen de
PostgreSQL (superusuario). Aplicar los roles exige cambiar `DATABASE_URL` y agregar
`MIGRACIONES_URL` en `.env`; está planeado para la versión 1.1.

## 8. Pipeline de despliegue y monitoreo

| Workflow | Evento | Resultado |
|---|---|---|
| [`ci.yml`](../.github/workflows/ci.yml) | *push* a `main`, *pull request* | Check `prueba-de-humo` (obligatorio en `main`) |
| [`release.yml`](../.github/workflows/release.yml) | Etiqueta `vX.Y.Z` | Imagen en GHCR, despliegue en Render y verificación |
| (mismo) | A mano con una versión | Rollback sin reconstruir |

Servidor: [`desplegar.sh`](../deploy/desplegar.sh) trae la versión, respalda, migra, cambia y
verifica; si falla, vuelve solo a la anterior.

Monitoreo (Uptime Kuma, fuera del servidor): salud `/api/health` cada 60 s, versión esperada en
`/api/version`, latido del respaldo diario, certificado HTTPS. Alertas al canal del equipo.

## 9. Mantenimiento, soporte y capacitación

| Tarea | Frecuencia |
|---|---|
| Parches de seguridad del SO (`unattended-upgrades`) | Diaria, automática |
| `revisar-servidor` con latido | Diaria, automática |
| Pull requests de Dependabot | Semanal |
| Reinicio por parches del kernel | Mensual, domingo 06:00-07:00 |
| Restauración de prueba | Mensual |
| Revisión de cuentas, llaves y secretos | Trimestral |

| Nivel | Quién | Canal |
|---|---|---|
| N0 | Guía rápida y preguntas frecuentes (`docs/ayuda/`) | — |
| N1 | Mesa de ayuda | Formulario de reporte (issues) |
| N2 | Administrador del servidor | Escalamiento desde N1 |
| N3 | Equipo de desarrollo | Escalamiento desde N2 |

Tiempos propuestos: P1 1 h / 4 h; P2 4 h / 2 días; P3 1 día / 5 días; P4 2 días / próxima versión.

Capacitación: bibliotecarios (60 min, registrar y consultar libros), mesa de ayuda (60 min,
clasificar y escalar), administrador (120 min, este plan: instalar, desplegar, respaldar y
restaurar).

## 10. Aceptación y entrega

| Campo | Resultado |
|---|---|
| Pruebas de aceptación | <!-- casos, resultado, decisión --> |
| Simulacro cruzado | <!-- equipo que instaló, duración, desviaciones, huellas --> |
| Acta de entrega | <!-- enlace --> |
