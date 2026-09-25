#!/usr/bin/env bash
# Prueba de humo: verifica que una instalación de la app de referencia funciona.
#
# Uso:
#   bash scripts/smoke-test.sh                          # contra http://localhost:8000
#   bash scripts/smoke-test.sh https://midominio.com    # contra otra URL
#   CURL_OPTS=-k bash scripts/smoke-test.sh https://...  # aceptar certificado de laboratorio
#
# Sale con 0 si todo pasa y 1 si algo falla. No deja datos basura: el libro de
# prueba usa un ISBN aleatorio y queda identificado con el título "smoke-test".

set -u
BASE="${1:-http://localhost:8000}"
CURL_OPTS="${CURL_OPTS:-}"
fallos=0

revisar() { # $1 descripción, $2 esperado, $3 obtenido
  if [ "$2" = "$3" ]; then echo "OK    $1"; else echo "FALLA $1 (esperado $2, obtenido $3)"; fallos=$((fallos + 1)); fi
}

codigo() { curl -s $CURL_OPTS -o /dev/null -w '%{http_code}' "$@"; }

revisar "health responde 200"          200 "$(codigo "$BASE/api/health")"
revisar "frontend responde 200"        200 "$(codigo "$BASE/")"
revisar "listado de libros responde"   200 "$(codigo "$BASE/api/libros")"

isbn="979$(date +%s%N | tail -c 11)"
libro="{\"isbn\":\"$isbn\",\"titulo\":\"smoke-test\",\"autor\":\"smoke-test\",\"anio\":2024}"
revisar "crear libro devuelve 201"     201 "$(codigo -X POST -H 'Content-Type: application/json' -d "$libro" "$BASE/api/libros")"
revisar "ISBN duplicado devuelve 409"  409 "$(codigo -X POST -H 'Content-Type: application/json' -d "$libro" "$BASE/api/libros")"
revisar "datos inválidos devuelven 422" 422 "$(codigo -X POST -H 'Content-Type: application/json' -d '{"isbn":"1"}' "$BASE/api/libros")"

version=$(curl -s $CURL_OPTS "$BASE/api/version" | sed -E 's/.*"version":"([^"]*)".*/\1/')
echo "INFO  versión desplegada: $version"

echo
if [ "$fallos" -eq 0 ]; then echo "RESULTADO: todas las pruebas pasaron."; else echo "RESULTADO: $fallos prueba(s) fallaron."; fi
[ "$fallos" -eq 0 ]
