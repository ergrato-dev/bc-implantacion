#!/usr/bin/env bash
# Descarga de una vez todas las imágenes de Docker que usan los laboratorios del bootcamp, para
# no saturar la red del aula el día de cada práctica.
#
# Uso:
#   bash scripts/precargar-imagenes.sh                       # descargar en este equipo
#   bash scripts/precargar-imagenes.sh --guardar imagenes.tar # además, guardarlas en un archivo
#
# Con --guardar, el instructor descarga una vez y reparte el archivo (carpeta compartida, USB).
# Cada aprendiz lo carga sin Internet con:  docker load -i imagenes.tar
#
# Las imágenes que construyen los laboratorios (servidor:lab-sNN, biblioteca:...) no están aquí:
# se construyen en clase y descargan paquetes de apt/pip/npm.
# Si agregas una imagen a un laboratorio o a una práctica, agrégala a esta lista.

set -euo pipefail

IMAGENES=(
  ubuntu:24.04                          # semanas 1, 6, 8, 10 (base del "servidor")
  postgres:17-alpine                    # semanas 2, 4-7, 9, 10
  postgres:16-alpine                    # semana 5 (origen de la migración)
  caddy:2-alpine                        # semanas 3, 4, 9
  traefik/whoami                        # semana 3
  atmoz/sftp:alpine                     # semana 3
  node:22-alpine                        # construcción de la app (todas desde la 4)
  python:3.13-slim                      # construcción de la app; pip-audit y Ansible (8, 10)
  registry:3                            # semana 7
  louislam/uptime-kuma:2                # semana 7
  mendhak/http-https-echo:latest        # semana 7
  restic/rest-server:latest             # semana 6
  restic/restic:latest                  # semana 9
  aquasec/trivy:latest                  # semana 8
  ghcr.io/opentofu/opentofu:latest      # semana 10
)

guardar=""
if [ "${1:-}" = "--guardar" ]; then
  guardar="${2:?Uso: $0 --guardar <archivo.tar>}"
fi

fallidas=()
for imagen in "${IMAGENES[@]}"; do
  echo "==> $imagen"
  docker pull --quiet "$imagen" || fallidas+=("$imagen")
done

if [ "${#fallidas[@]}" -gt 0 ]; then
  echo "No se pudieron descargar: ${fallidas[*]}" >&2
  exit 1
fi

if [ -n "$guardar" ]; then
  echo "Guardando ${#IMAGENES[@]} imágenes en $guardar ..."
  docker save -o "$guardar" "${IMAGENES[@]}"
  echo "Listo: $(du -h "$guardar" | cut -f1). Cargar con: docker load -i $guardar"
fi

echo "Listo: ${#IMAGENES[@]} imágenes disponibles."
