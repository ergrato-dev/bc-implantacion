#!/usr/bin/env bash
# Prepara lo que el equipo que entrega le da al equipo que instala en el simulacro:
#   entrega/restic/      repositorio restic con un respaldo cifrado de la base actual
#   entrega/huella.txt   huella de la base, para comparar después de restaurar
#   entrega/version.txt  versión en producción
# La contraseña de restic se muestra en pantalla: se entrega por OTRO canal, nunca en la carpeta.
#
# Uso (en esta carpeta, con el laboratorio arriba): bash preparar-entrega.sh

set -euo pipefail
cd "$(dirname "$0")"
REFERENCIA=../../../../referencia

if [ -e entrega ]; then echo "Ya existe entrega/: bórrala si quieres generar otra." >&2; exit 1; fi
umask 077
mkdir -p entrega/restic
clave=$(head -c 24 /dev/urandom | base64 | tr -d '/+=')
volcado=$(mktemp)
trap 'rm -f "$volcado"' EXIT

restic_() {   # restic en un contenedor, con los permisos de tu usuario sobre entrega/restic
  docker run --rm -i --user "$(id -u):$(id -g)" -e RESTIC_PASSWORD="$clave" \
    -v "$PWD/entrega/restic:/repo" restic/restic -r /repo --no-cache "$@"
}

docker compose exec -T db pg_dump -U biblioteca -Fc biblioteca > "$volcado"
restic_ init --quiet
restic_ backup --quiet --tag db --stdin --stdin-filename biblioteca.dump < "$volcado"
docker compose exec -T db psql -U biblioteca -d biblioteca -tA < "$REFERENCIA/scripts/huella.sql" > entrega/huella.txt
curl -fsS http://localhost:8000/api/version > entrega/version.txt

echo "Paquete listo en entrega/:"
ls entrega
echo
echo "Contraseña de restic (entrégala por otro canal y NO la guardes en entrega/):"
echo "$clave"
