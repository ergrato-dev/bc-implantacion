#!/usr/bin/env bash
# Revisión rutinaria de mantenimiento del servidor. Pensada para cron (diaria) y para
# ejecutarla a mano antes de una ventana de mantenimiento.
#
# Uso: revisar-servidor
# Variables opcionales:
#   UMBRAL_DISCO=80                porcentaje de uso de disco que se considera problema
#   CARPETA_RESPALDOS=/var/respaldos  y  MAX_HORAS_RESPALDO=26   antigüedad máxima del último respaldo
#   URL_LATIDO=<url push de Uptime Kuma>   se llama solo si no hay problemas (semana 7)
#
# Sale con 0 si todo está bien y con 1 si encontró algún problema.

set -uo pipefail
UMBRAL_DISCO="${UMBRAL_DISCO:-80}"
CARPETA_RESPALDOS="${CARPETA_RESPALDOS:-/var/respaldos}"
MAX_HORAS_RESPALDO="${MAX_HORAS_RESPALDO:-26}"
problemas=0

ok()        { echo "OK        $*"; }
problema()  { echo "PROBLEMA  $*"; problemas=$((problemas + 1)); }
info()      { echo "INFO      $*"; }

echo "Revisión de $(hostname) — $(date -Is)"

# 1. Disco
uso=$(df --output=pcent / | tail -1 | tr -dc 0-9)
if [ "$uso" -lt "$UMBRAL_DISCO" ]; then ok "disco / al $uso %"; else problema "disco / al $uso % (umbral $UMBRAL_DISCO %)"; fi

# 2. Actualizaciones pendientes (la lista de paquetes se refresca con apt-get update)
pendientes=$(apt list --upgradable 2>/dev/null | grep -c upgradable)
seguridad=$(apt list --upgradable 2>/dev/null | grep -c -- "-security")
if [ "$seguridad" -eq 0 ]; then ok "sin actualizaciones de seguridad pendientes ($pendientes en total)"
else problema "$seguridad actualizaciones de seguridad pendientes ($pendientes en total)"; fi

# 3. Reinicio pendiente (lo deja un kernel o una biblioteca base actualizados)
if [ -f /var/run/reboot-required ]; then problema "requiere reinicio (existe /var/run/reboot-required)"; else ok "no requiere reinicio"; fi

# 4. Actualizaciones automáticas activadas
#    Se guarda la salida antes de buscar: con pipefail, "grep -q" cortaría la tubería y
#    apt-config terminaría con error aunque el texto sí estuviera.
conf=$(apt-config dump)
if grep -q 'APT::Periodic::Unattended-Upgrade "1"' <<< "$conf" && ! grep -q 'APT::Periodic::Enable "0"' <<< "$conf"; then
  ok "actualizaciones automáticas activadas"
else problema "actualizaciones automáticas desactivadas"; fi

# 5. Antigüedad del último respaldo
ultimo=$(find "$CARPETA_RESPALDOS" -type f -printf '%T@\n' 2>/dev/null | sort -n | tail -1)
if [ -z "$ultimo" ]; then problema "no hay respaldos en $CARPETA_RESPALDOS"
else
  horas=$(( ($(date +%s) - ${ultimo%.*}) / 3600 ))
  if [ "$horas" -le "$MAX_HORAS_RESPALDO" ]; then ok "último respaldo hace $horas h"; else problema "último respaldo hace $horas h (máximo $MAX_HORAS_RESPALDO h)"; fi
fi

# 6. Tiempo encendido (informativo)
info "encendido desde $(uptime -s 2>/dev/null || echo 'desconocido')"

echo
if [ "$problemas" -eq 0 ]; then
  echo "RESULTADO: sin problemas."
  if [ -n "${URL_LATIDO:-}" ]; then curl -fsS -m 10 --retry 3 "$URL_LATIDO" > /dev/null || echo "aviso: no se pudo enviar el latido"; fi
else
  echo "RESULTADO: $problemas problema(s)."
fi
[ "$problemas" -eq 0 ]
