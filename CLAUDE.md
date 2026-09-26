# bc-implantacion — Implantación del Software

Contexto operativo para Claude Code en este repo. Las convenciones de contenido pedagógico
(estructura de semana, formato de teoría/prácticas/proyecto, SVG, idioma) están en
[`.github/copilot-instructions.md`](.github/copilot-instructions.md) — léelo antes de crear o
editar contenido de una semana.

## Qué hace único a este repo frente a los demás `bc-*`

- **9 semanas + 1 opcional, 17h/semana (12h AF + 5h TA).** No 10h como `bc-asesoria-proyecto`.
  `bootcamp/week-XX-slug/` cuelga directo de `bootcamp/` — un README de semana enlaza a la raíz
  con `../../README.md`.
- **Hilo conductor dual.** `2-practicas/` usa siempre la app de referencia común
  (`referencia/`, FastAPI + React + PostgreSQL). `3-proyecto/` se aplica siempre al proyecto real
  del equipo y produce una sección de `docs/plan-implantacion-template.md`. No mezclar.
- **Solo open source / free tier.** Ubuntu Server LTS, Docker, PostgreSQL, Caddy, Render,
  Neon/Supabase, GitHub Actions (GitLab CI como anexo), Uptime Kuma, restic, Ansible.
  **No** Windows Server (solo comparativa conceptual), **no** CMS prehechos (WordPress y
  similares), **no** Heroku. FTP solo conceptual; la práctica es SFTP/`scp`/`rsync`.
- **Gate semana 9**: otro equipo instala el proyecto desde cero siguiendo solo el Plan de
  Implantación y restaura un respaldo. Condición de aprobación del Producto, no nota opcional.
- La semana de documentación técnica (manuales, ICONTEC/APA) se eliminó a propósito — no la
  reintroduzcas.

## Trazabilidad RAP

`docs/plan-curricular.md` es la fuente de verdad: saberes C1-C6, P1-P5 y criterios CE-1 a CE-5
por semana. Los textos del RAP son oficiales — no los reescribas. Toda rúbrica debe alinearse con
esa tabla; verifícalo con el agente `rap-trazabilidad-reviewer`.

## Reglas que rompen fácil

- **Laboratorios**: cada `compose.yaml` de laboratorio lleva `name: lab-sNN` para que las semanas no compartan proyecto de Compose (todas las carpetas se llaman `laboratorio`).
- **Scope de commit**: `feat(week-NN)` / `fix(week-NN)`, nunca el slug completo.
- **Datos reales**: nunca IPs, hosts, usuarios o credenciales del laboratorio institucional, ni
  datos de aprendices/instructores. Al servidor del laboratorio se le llama "VM Ubuntu del
  laboratorio".
- Antes de commitear cambios que muevan/renombren/creen carpetas de semana: correr
  `bash scripts/verificar-enlaces.sh` (o la skill `verificar-estructura`).

## Estado

Semanas 1-9 completas. Semana 10 (opcional): README y rúbrica con `🚧`, subcarpetas vacías con `.gitkeep`.

`referencia/` es la app de referencia (FastAPI + React + PostgreSQL en una sola imagen). Las
prácticas desde la semana 4 dependen de ella: si cambias endpoints, migraciones o
`scripts/smoke-test.sh`, revisa las prácticas que los usan. Los workflows (`.github/workflows/`) y
`deploy/desplegar.sh` los usa la semana 7; `dependabot.yml` e `ISSUE_TEMPLATE/`, la semana 8. Verifícala con
`cp .env.example .env && docker compose up -d --build --wait && bash scripts/smoke-test.sh`.
