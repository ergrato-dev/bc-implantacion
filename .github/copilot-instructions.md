# 🤖 Instrucciones para GitHub Copilot

## 📋 Contexto

Material de la actividad **Implantación del Software** (SENA ADSO, cadena de formación). Es
contenido educativo en Markdown, no una aplicación en producción, salvo `referencia/`.

| Campo | Valor |
|---|---|
| Duración | 9 semanas + 1 opcional |
| Horas | 153h (17h/semana: 12h Ambiente de Formación + 5h Trabajo Autónomo) + 17h opcionales |
| RAP | Planear actividades de implantación del software de acuerdo con las condiciones del sistema |
| Producto final | Plan de Implantación del proyecto real, validado en simulacro cruzado (semana 9) |

Trazabilidad completa en `docs/plan-curricular.md`.

---

## 🎓 Componentes de Cada Semana

```
week-XX-tema/
├── README.md
├── rubrica-evaluacion.md
├── 0-assets/
├── 1-teoria/            # 01-*.md, ≤150 líneas cada uno
├── 2-practicas/         # siempre sobre la app de referencia (referencia/)
├── 3-proyecto/
│   ├── README.md
│   ├── starter/         # plantilla de la sección del Plan de Implantación
│   └── solution/        ← NUNCA se sube al repo (.gitignore)
├── 4-recursos/{ebooks-free,videografia,webgrafia}/
└── 5-glosario/          # tabla Término | Definición breve
```

- `3-proyecto/starter/` usa instrucciones en comentario HTML (`<!-- 📝 Instrucción: ... -->`) y
  al menos un ejemplo parcial con datos sintéticos.
- Todo SVG en `0-assets/` debe estar enlazado desde un `.md`. Tema dark, sin degradés, fuentes
  sans-serif.

---

## 📝 Convenciones

- Archivos kebab-case, sin tildes, sin espacios.
- Documentación en **español**; código, comandos, ramas y commits en **inglés**.
- Conventional Commits: `feat(week-NN): ...`.

---

## 🛠️ Herramientas

Solo open source / free tier: Ubuntu Server LTS, Docker + Compose, PostgreSQL, Caddy, SFTP /
`scp` / `rsync`, Render, Neon / Supabase, DuckDNS, GitHub Actions + GHCR (GitLab CI como
anexo), Uptime Kuma, restic, Dependabot / Renovate, cloud-init, Ansible, OpenTofu.

No usar: Windows Server (solo comparativa conceptual), CMS prehechos, Heroku, FTP plano en
prácticas.

---

## 📊 Evaluación

| Evidencia | % | Instrumento |
|---|---|---|
| 🧠 Conocimiento | 30% | Cuestionario |
| 💪 Desempeño | 40% | Práctica sobre la app de referencia |
| 📦 Producto | 30% | Sección del Plan de Implantación del proyecto real |

Nota mínima por tipo: 70%. Cada rúbrica nombra los criterios CE-N de su semana según
`docs/plan-curricular.md` — no inventes criterios.

---

## 🤖 Límites

- Sin datos reales de aprendices, instructores, proyectos ni infraestructura institucional
  (IPs, hosts, usuarios, credenciales).
- Secretos siempre en variables de entorno / `.env.example`, nunca en el repositorio.

---

## 📖 README de Semana

```markdown
# 📚 Semana XX — [Tema]

## 🎯 Objetivos de Aprendizaje
## 🧭 Trazabilidad RAP
## 📝 Contenidos
## ⏱️ Distribución del Tiempo (17 horas)
## 📌 Entregable de la Semana
## 🎓 Conceptos Clave
## 🔗 Navegación
```
