#!/usr/bin/env bash
# Respaldo lógico de la base del laboratorio con pg_dump, verificación y retención.
#
# Uso (desde la carpeta 2-practicas/laboratorio):
#   bash ../01-respaldo-y-restauracion/respaldar.sh
#   RETENCION=3 bash ../01-respaldo-y-restauracion/respaldar.sh
#
# Deja el archivo en laboratorio/respaldos/ y conserva solo los últimos RETENCION.

set -euo pipefail

SERVICIO="${SERVICIO:-db}"
DB_USER="${DB_USER:-biblioteca}"
DB_NAME="${DB_NAME:-biblioteca}"
DESTINO="${DESTINO:-respaldos}"
RETENCION="${RETENCION:-7}"

mkdir -p "$DESTINO"
archivo="$DESTINO/${DB_NAME}-$(date +%Y%m%d-%H%M%S).dump"

# 1. Respaldo en formato custom (-Fc): comprimido y restaurable por partes.
docker compose exec -T "$SERVICIO" pg_dump -U "$DB_USER" -Fc "$DB_NAME" > "$archivo"

# 2. Verificación mínima: el archivo existe, no está vacío y pg_restore puede leerlo.
if [ ! -s "$archivo" ]; then
  echo "ERROR: respaldo vacío: $archivo" >&2
  rm -f "$archivo"
  exit 1
fi
docker compose exec -T "$SERVICIO" pg_restore --list "/respaldos/$(basename "$archivo")" > /dev/null

# 3. Retención: borrar los respaldos más antiguos que excedan RETENCION.
ls -1t "$DESTINO"/"$DB_NAME"-*.dump | tail -n +"$((RETENCION + 1))" | xargs -r rm --

echo "OK: $archivo ($(du -h "$archivo" | cut -f1))"
echo "Respaldos conservados: $(ls -1 "$DESTINO"/"$DB_NAME"-*.dump | wc -l) de máximo $RETENCION"
