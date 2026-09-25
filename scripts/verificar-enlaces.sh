#!/usr/bin/env bash
# Verifica integridad estructural del bootcamp:
#   1. Nombres de carpeta week-NN-slug bien formados (sin split de etapas,
#      a diferencia de bc-aidev — este repo es single-track, 9 semanas + 1 opcional).
#   2. Enlaces relativos en markdown que resuelven a una ruta real.
#
# Uso: scripts/verificar-enlaces.sh
# Salida: lista de problemas encontrados; exit code 1 si hay al menos uno.

set -u
cd "$(git rev-parse --show-toplevel)" || exit 1

fail=0

echo "== 1. Nombres de carpeta =="
while IFS= read -r d; do
  name=$(basename "$d")
  if ! [[ "$name" =~ ^week-[0-9]{2}-[a-z0-9_]+$ ]]; then
    echo "NOMBRE INVALIDO (week): $d"
    fail=1
  fi
done < <(find bootcamp -mindepth 1 -maxdepth 1 -type d -iname "week-*")

echo "== 2. Enlaces relativos en markdown =="
# ponytail: no parsea markdown de verdad, solo strip de fences ``` y luego
# grep de enlaces "](...)" . Falsos positivos conocidos: URLs con paréntesis
# anidados (ej. wikipedia "(book)"). Si el script reporta algo distinto a
# eso, es un enlace roto real.
while IFS= read -r f; do
  content=$(awk '/^```/{c=!c; next} !c' "$f")
  while IFS= read -r link; do
    [ -z "$link" ] && continue
    clean="${link%%#*}"
    [ -z "$clean" ] && continue
    case "$clean" in http*|\<http*|mailto:*|\#*|/*) continue ;; esac
    dir=$(dirname "$f")
    resolved=$(realpath -m "$dir/$clean")
    if [ ! -e "$resolved" ]; then
      echo "ENLACE ROTO: $f -> $link"
      fail=1
    fi
  done < <(printf '%s\n' "$content" | grep -oE '\]\([^)]+\)' | sed -E 's/^\]\(//;s/\)$//')
done < <(find . -iname "*.md" -not -path "./.git/*" -not -path "./.claude/*" -not -path "*/node_modules/*")

echo "== 3. Navegación anterior/siguiente en README de cada semana =="
while IFS= read -r rm; do
  if ! grep -q "Navegación" "$rm"; then
    echo "SIN NAVEGACION: $rm"
    fail=1
  fi
done < <(find bootcamp -mindepth 2 -maxdepth 2 -iname "README.md")

if [ "$fail" -eq 0 ]; then
  echo "OK: sin problemas detectados."
fi
exit "$fail"
