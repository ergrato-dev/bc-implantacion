# Gestión de Secretos

## 🎯 Objetivos

- Inventariar los secretos de un software implantado
- Decidir dónde vive cada secreto en cada ambiente y quién puede leerlo
- Actuar ante un secreto filtrado: rotar primero, limpiar después
- Evitar que los secretos lleguen al repositorio

## 📋 Contenido

### 1. Inventario

Un secreto es cualquier dato que da acceso. En la app de referencia hay más de los que parece:

| Secreto | Da acceso a | Dónde vive (servidor) | Quién lo lee |
|---|---|---|---|
| Contraseña de `postgres` | Administrar la base | Gestor de contraseñas del equipo | Administradores |
| Contraseña de `biblioteca_app` | Datos de la app | `/opt/biblioteca/.env` (`640 root:despliegue`) | El proceso de la app |
| Contraseña de `biblioteca_respaldo` | Leer toda la base | `~respaldo/.pgpass` (`600`) | El usuario `respaldo` |
| Contraseña de restic | Descifrar **todos** los respaldos | `/etc/restic/password` (`600`) **y** fuera del servidor | `respaldo` y administradores |
| Llaves privadas SSH | Entrar al servidor | El equipo de cada persona | Solo su dueño |
| Tokens de Render / Neon / GitHub | Desplegar, borrar bases | Paneles de cada servicio, secretos de GitHub (semana 7) | El pipeline |

### 2. Reglas

1. **Nunca en el repositorio**: ni en el código, ni en `compose.yaml`, ni en un `.env` que se
   suba "solo por esta vez". `.env.example` lleva nombres y valores ficticios.
2. **Uno por propósito**: cada rol, servicio y ambiente con su propio secreto. Compartirlos
   impide saber qué se filtró y obliga a cambiar todo a la vez.
3. **Permisos de archivo mínimos**: `600` o `640`, dueño correcto.
4. **Generados, no inventados**: `openssl rand -base64 32`; si el secreto va dentro de una URL
   (como `DATABASE_URL`), `openssl rand -hex 24`, porque `/` y `+` rompen la URL.
5. **Fuera de los logs**: no se imprimen, no se pegan en chats ni en issues (semana 5).
6. **Con copia fuera del servidor** los que no se pueden reconstruir: sin la contraseña de
   restic, los respaldos son ruido cifrado.

### 3. Dónde guardar secretos

| Opción | Ejemplo | Apto para |
|---|---|---|
| Archivo `.env` con permisos | `/opt/biblioteca/.env` (`640`) | Servidor propio, equipo pequeño |
| Archivo montado como secreto | Compose `secrets:` + variables `*_FILE` | El secreto no aparece en `docker inspect` |
| Panel del proveedor | Variables de entorno de Render | PaaS |
| Secretos del CI | *GitHub Actions secrets* | Pipeline (semana 7) |
| Gestor de contraseñas | Bitwarden, KeePassXC | Personas: contraseñas de administración, restic |
| Gestor de secretos | HashiCorp Vault, OpenBao, SOPS | Muchos servicios y ambientes |

Las variables de entorno se ven con `docker inspect` (quien lo ejecute ya es administrador) y en
`/proc/<pid>/environ`. La imagen oficial de PostgreSQL acepta `POSTGRES_PASSWORD_FILE` para leer
la contraseña de un archivo en lugar de una variable.

### 4. Si un secreto se filtra

Un secreto que llegó a GitHub se considera **comprometido**, aunque se borre el *commit* un minuto
después: hay bots que leen los repositorios públicos en tiempo real.

1. **Rotar**: generar uno nuevo y aplicarlo (`ALTER ROLE biblioteca_app PASSWORD '...'`, nueva
   llave, nuevo token).
2. **Revocar** el anterior y comprobar que ya no funciona.
3. **Revisar** los registros de acceso del periodo expuesto.
4. **Limpiar** el historial (opcional y posterior: no reemplaza a la rotación).
5. **Documentar** el incidente y la causa.

Rotar debe ser un procedimiento conocido y ensayado, no una emergencia: por eso la práctica 02
lo ejecuta.

### 5. Prevenir

- `.gitignore` con `.env` desde el primer *commit* (este repositorio ya lo tiene).
- Revisar antes de subir: `git diff --staged`.
- Escáner de secretos: *push protection* de GitHub (activo en repositorios públicos) o
  `gitleaks` en el equipo y en el pipeline.
- Buscar en el historial: `git log -p | grep -iE "password|secret|token"`.

### 6. Aplicación al proyecto real

Haz el inventario de secretos de tu proyecto con la tabla de la sección 1: qué da acceso, dónde
vive en cada ambiente, quién lo lee y cómo se rota.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
