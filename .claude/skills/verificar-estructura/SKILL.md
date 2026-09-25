---
name: verificar-estructura
description: Verifica que la estructura del bootcamp (nombres week-NN-slug, enlaces relativos, navegación anterior/siguiente, trazabilidad RAP en rúbricas) sea consistente. Usar antes de commitear cambios que muevan, renombren o creen carpetas de semana, o ante sospecha de enlace roto.
allowed-tools: Bash(scripts/verificar-enlaces.sh) Bash(bash scripts/verificar-enlaces.sh) Read Grep
---

# Verificar estructura del bootcamp

9 semanas + 1 opcional (`bootcamp/week-01-...` a `week-10-...`). Desde un README de semana la
raíz es `../../README.md`; cada subcarpeta de profundidad suma un `../`.

1. Correr:

   ```bash
   bash scripts/verificar-enlaces.sh
   ```

   Revisa nombres de carpeta, enlaces relativos en `.md` y sección "Navegación" en cada README
   de semana. Repetir hasta `OK: sin problemas detectados.`

2. A mano (juicio de contenido):
   - Rúbricas vs [`docs/plan-curricular.md`](../../../docs/plan-curricular.md) — usar el agente
     `rap-trazabilidad-reviewer`.
   - Tabla "Contenido por Semana" del `README.md` raíz sincronizada con cada README de semana.
   - Sin menciones a Windows Server, CMS prehechos o Heroku como herramienta de práctica.
