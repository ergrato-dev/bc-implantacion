#!/usr/bin/env bash
# Verifica que el servidor actual cumple los requisitos mínimos de un software.
#
# Uso:
#   bash verificar-requisitos.sh
#   MIN_RAM_MB=4096 bash verificar-requisitos.sh      # cambiar un umbral
#
# Los umbrales por defecto corresponden a la app de referencia del bootcamp.
# Sale con código 0 si todo cumple y 1 si algún requisito falla.

set -u

MIN_CPUS="${MIN_CPUS:-1}"
MIN_RAM_MB="${MIN_RAM_MB:-1024}"
MIN_DISK_GB="${MIN_DISK_GB:-10}"
DISK_PATH="${DISK_PATH:-/}"
OS_ID="${OS_ID:-ubuntu}"
MIN_OS_VERSION="${MIN_OS_VERSION:-22.04}"
ARCHS="${ARCHS:-x86_64 aarch64}"
MIN_DOCKER_VERSION="${MIN_DOCKER_VERSION:-24.0}"
PORTS="${PORTS:-80 443}"

fallos=0

resultado() { # $1 requisito, $2 esperado, $3 encontrado, $4 0=cumple
  local estado="CUMPLE"
  if [ "$4" -ne 0 ]; then estado="NO CUMPLE"; fallos=$((fallos + 1)); fi
  printf "%-18s %-22s %-22s %s\n" "$1" "$2" "$3" "$estado"
}

# version_ge A B -> verdadero si A >= B (compara versiones tipo 24.04 o 27.3.1)
version_ge() { [ "$(printf '%s\n%s\n' "$2" "$1" | sort -V | head -n1)" = "$2" ]; }

printf "%-18s %-22s %-22s %s\n" "REQUISITO" "ESPERADO" "ENCONTRADO" "ESTADO"
printf '%.0s-' {1..72}; echo

cpus=$(nproc)
[ "$cpus" -ge "$MIN_CPUS" ]; resultado "Procesadores" ">= $MIN_CPUS" "$cpus" $?

ram_mb=$(awk '/MemTotal/ {print int($2 / 1024)}' /proc/meminfo)
[ "$ram_mb" -ge "$MIN_RAM_MB" ]; resultado "RAM (MB)" ">= $MIN_RAM_MB" "$ram_mb" $?

disk_gb=$(df -BG --output=avail "$DISK_PATH" | tail -n1 | tr -dc '0-9')
[ "$disk_gb" -ge "$MIN_DISK_GB" ]; resultado "Disco libre (GB)" ">= $MIN_DISK_GB en $DISK_PATH" "$disk_gb" $?

arch=$(uname -m)
[[ " $ARCHS " == *" $arch "* ]]; resultado "Arquitectura" "$ARCHS" "$arch" $?

# shellcheck disable=SC1091
os_id=$(. /etc/os-release && echo "$ID")
os_version=$(. /etc/os-release && echo "${VERSION_ID:-0}")
[ "$os_id" = "$OS_ID" ] && version_ge "$os_version" "$MIN_OS_VERSION"
resultado "Sistema operativo" "$OS_ID >= $MIN_OS_VERSION" "$os_id $os_version" $?

if command -v docker >/dev/null 2>&1; then
  docker_version=$(docker version --format '{{.Server.Version}}' 2>/dev/null \
    || docker --version | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -n1)
  version_ge "$docker_version" "$MIN_DOCKER_VERSION"
  resultado "Docker" ">= $MIN_DOCKER_VERSION" "$docker_version" $?
else
  resultado "Docker" ">= $MIN_DOCKER_VERSION" "no instalado" 1
fi

for port in $PORTS; do
  # Puertos TCP en estado LISTEN (0A), leídos de /proc para no depender de `ss`
  port_hex=$(printf '%04X' "$port")
  if awk 'FNR > 1 && $4 == "0A" {split($2, a, ":"); print a[2]}' /proc/net/tcp /proc/net/tcp6 2>/dev/null \
      | grep -qx "$port_hex"; then
    resultado "Puerto $port" "libre" "en uso" 1
  else
    resultado "Puerto $port" "libre" "libre" 0
  fi
done

echo
if [ "$fallos" -eq 0 ]; then
  echo "RESULTADO: el servidor cumple todos los requisitos mínimos."
else
  echo "RESULTADO: $fallos requisito(s) no se cumplen."
fi
[ "$fallos" -eq 0 ]
