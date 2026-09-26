#!/usr/bin/env bash
# Despliegue "pull" en el servidor: trae una versión publicada del registro, respalda la base,
# aplica las migraciones, cambia la app y la verifica. Si la verificación falla, vuelve sola
# a la versión anterior.
#
# Uso (en la carpeta del despliegue, junto a compose.yaml, .env y smoke-test.sh):
#   bash desplegar.sh 1.2.0          # desplegar una versión
#   bash desplegar.sh 1.1.0          # rollback manual = desplegar la versión anterior
#
# Lee de .env: APP_VERSION (la versión actual, la reescribe), POSTGRES_USER, POSTGRES_DB,
# URL_APP (dónde correr la prueba de humo) y, opcional, MIGRACIONES_URL (rol dueño, semana 6).

set -euo pipefail
cd "$(dirname "$0")"

NUEVA="${1:?Uso: bash desplegar.sh <versión>}"
# Sin exportar: Compose lee .env por su cuenta. Exportar APP_VERSION aquí la fijaría en la
# versión anterior aunque el script cambie el archivo.
. ./.env
ANTERIOR="$APP_VERSION"

registrar() { echo "$(date -Is) $*" | tee -a despliegues.log; }
usar_version() { sed -i "s/^APP_VERSION=.*/APP_VERSION=$1/" .env; }

registrar "inicio: $ANTERIOR -> $NUEVA"
trap 'registrar "FALLO antes del cambio: $ANTERIOR sigue en servicio"' ERR

# 1. Traer la imagen. Si la versión no existe en el registro, se detiene aquí sin tocar nada.
APP_VERSION="$NUEVA" docker compose pull app

# 2. Respaldo antes de cambiar nada.
mkdir -p respaldos
docker compose exec -T db pg_dump -U "$POSTGRES_USER" -Fc "$POSTGRES_DB" \
  > "respaldos/antes-de-$NUEVA-$(date +%Y%m%d-%H%M%S).dump"

# 3. Migraciones con la versión nueva, mientras la anterior sigue atendiendo.
#    Si fallan, el script se detiene y la versión anterior sigue en servicio.
rol_duenio=()
if [ -n "${MIGRACIONES_URL:-}" ]; then rol_duenio=(-e "DATABASE_URL=$MIGRACIONES_URL"); fi
APP_VERSION="$NUEVA" docker compose run --rm --no-deps "${rol_duenio[@]}" app python -m app.main

# 4. Cambiar la app y verificar. Si algo falla, rollback automático.
trap - ERR
usar_version "$NUEVA"
if docker compose up -d --wait app && bash smoke-test.sh "$URL_APP" \
   && curl -fsS "$URL_APP/api/version" | grep -q "\"$NUEVA\""; then
  registrar "OK: $NUEVA en servicio"
else
  registrar "FALLO: $NUEVA no pasó la verificación, volviendo a $ANTERIOR"
  usar_version "$ANTERIOR"
  docker compose up -d --wait app
  registrar "ROLLBACK: $ANTERIOR en servicio"
  exit 1
fi
