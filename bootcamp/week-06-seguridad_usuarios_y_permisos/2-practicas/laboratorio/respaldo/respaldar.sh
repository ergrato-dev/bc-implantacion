#!/usr/bin/env bash
# Respaldo cifrado de la base con restic: una copia local y una fuera del sitio.
#
# Lo ejecuta el usuario de sistema "respaldo" (por cron). Lee:
#   ~/.pgpass              credenciales del rol biblioteca_respaldo (permisos 600)
#   /etc/restic/password   contraseña de cifrado de los repositorios (permisos 600)
#
# Uso manual:  sudo -u respaldo /opt/respaldo/respaldar.sh

set -euo pipefail

export RESTIC_PASSWORD_FILE=/etc/restic/password
REPO_LOCAL="${REPO_LOCAL:-/var/respaldos/restic}"
REPO_EXTERNO="${REPO_EXTERNO:-rest:http://externo:8000/biblioteca}"
DB_HOST="${DB_HOST:-db}"
DB_USER="${DB_USER:-biblioteca_respaldo}"
DB_NAME="${DB_NAME:-biblioteca}"

# El volcado vive solo mientras corre el script, en una carpeta que nadie más puede leer.
umask 077
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
volcado="$tmp/$DB_NAME.dump"

echo "$(date -Is) inicio"

# 1. Volcado lógico (formato custom) con el rol de solo lectura.
pg_dump -h "$DB_HOST" -U "$DB_USER" -Fc "$DB_NAME" -f "$volcado"
pg_restore --list "$volcado" > /dev/null          # el archivo es legible

# 2. Copia cifrada en los dos repositorios. Se entrega por la entrada estándar con un nombre
#    fijo: así todas las instantáneas son "del mismo archivo" y la retención las agrupa.
for repo in "$REPO_LOCAL" "$REPO_EXTERNO"; do
  restic -r "$repo" backup --quiet --tag db --stdin --stdin-filename "$DB_NAME.dump" < "$volcado"
done

# 3. Retención en el repositorio local: 7 diarios, 4 semanales, 12 mensuales.
#    El externo es solo-agregar: allí la retención la aplica su administrador.
restic -r "$REPO_LOCAL" forget --quiet --tag db --keep-daily 7 --keep-weekly 4 --keep-monthly 12 --prune

# 4. Verificación de la estructura del repositorio local.
restic -r "$REPO_LOCAL" check --quiet

echo "$(date -Is) fin OK"
