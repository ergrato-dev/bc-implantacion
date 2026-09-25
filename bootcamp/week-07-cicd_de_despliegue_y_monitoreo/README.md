# 📚 Semana 07 — CI/CD de Despliegue y Monitoreo

> 🚧 Esqueleto — contenido de teoría, prácticas y proyecto pendiente.

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, el aprendiz será capaz de:

1. Construir un pipeline que publique la imagen en GHCR y despliegue en Render
2. Hacer rollback a una versión anterior por tag
3. Conocer el equivalente del pipeline en GitLab CI
4. Monitorear disponibilidad con Uptime Kuma y revisar logs de contenedores

---

## 🧭 Trazabilidad RAP

| Saberes de conceptos | Saberes de proceso |
|---|---|
| C5 | P1, P5 |

**Criterios de evaluación:**

- **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado
- **CE-5** — Elabora el plan de instalación de acuerdo con las características del software a implantar

Ver [`docs/plan-curricular.md`](../../docs/plan-curricular.md).

---

## 📝 Contenidos

- Integración y entrega continua orientada a despliegue
- GitHub Actions: build, push a GHCR, deploy hook (principal)
- Anexo: GitLab CI con runner institucional
- Rollback y versionado de imágenes
- Monitoreo básico: healthchecks, Uptime Kuma, logs
- Práctica: pipeline completo de la app de referencia

---

## ⏱️ Distribución del Tiempo (17 horas)

```
🅰️ Ambiente de Formación     ████████████░░░░░   12h  (70%)
🅱️ Trabajo Autónomo          █████░░░░░░░░░░░░    5h  (30%)
```

- **🅰️ Ambiente de Formación (12h)**: teoría guiada + práctica sobre la app de referencia ([`referencia/`](../../referencia/README.md)).
- **🅱️ Trabajo Autónomo (5h)**: aplicar la práctica al proyecto real y completar la sección del Plan de Implantación.

---

## 📌 Entregable de la Semana

Pipeline de despliegue + monitoreo del proyecto real — sección de [`docs/plan-implantacion-template.md`](../../docs/plan-implantacion-template.md).

---

## 🎓 Conceptos Clave

`CI/CD`, `GHCR`, `Deploy hook`, `Rollback`, `Uptime`, `Log`

---

## 🔗 Navegación

| ← Anterior | → Siguiente |
|-----------|-------------|
| [← Semana 06 — Seguridad, Usuarios y Permisos](../week-06-seguridad_usuarios_y_permisos/README.md) | [Semana 08 — Mantenimiento, Soporte y Capacitación →](../week-08-mantenimiento_soporte_y_capacitacion/README.md) |

---

*Cadena de Formación · Implantación del Software · Semana 7 de 9 + 1 opcional*
