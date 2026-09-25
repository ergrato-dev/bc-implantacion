# 📚 Semana 02 — Plan de Instalación, Migración y Respaldo

> 🚧 Esqueleto — contenido de teoría, prácticas y proyecto pendiente.

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, el aprendiz será capaz de:

1. Definir objetivos, etapas, riesgos y plan de rollback de una migración de datos
2. Aplicar la estrategia de respaldo 3-2-1 y definir RPO/RTO
3. Respaldar y restaurar PostgreSQL con `pg_dump` / `pg_restore`
4. Probar que un respaldo realmente restaura (respaldo no probado = sin respaldo)
5. Redactar la versión 0 del plan de instalación del proyecto real

---

## 🧭 Trazabilidad RAP

| Saberes de conceptos | Saberes de proceso |
|---|---|
| C4 | P3, P4, P5 |

**Criterios de evaluación:**

- **CE-3** — Diseña el plan de migración de datos de acuerdo con las condiciones de implementación
- **CE-4** — Diseña el plan de respaldo de los datos para mitigar riesgos
- **CE-5** — Elabora el plan de instalación de acuerdo con las características del software a implantar

Ver [`docs/plan-curricular.md`](../../docs/plan-curricular.md).

---

## 📝 Contenidos

- Migración de datos: concepto, tipos, etapas, mapeo, validación (conteos, checksums)
- Copias de seguridad: completa, incremental, diferencial; regla 3-2-1; RPO/RTO
- Procesos de restauración y simulacro
- Estructura de un plan de instalación
- Práctica: respaldo y restauración de la base de datos de la app de referencia

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

Plan de migración + plan de respaldo v0 + plan de instalación v0 del proyecto real — sección de [`docs/plan-implantacion-template.md`](../../docs/plan-implantacion-template.md).

---

## 🎓 Conceptos Clave

`RPO`, `RTO`, `Regla 3-2-1`, `Rollback`, `ETL`, `Restauración`

---

## 🔗 Navegación

| ← Anterior | → Siguiente |
|-----------|-------------|
| [← Semana 01 — Plataforma Tecnológica y Hardware](../week-01-plataforma_tecnologica_y_hardware/README.md) | [Semana 03 — Hosting, Dominio y Transferencia de Archivos →](../week-03-hosting_dominio_y_transferencia/README.md) |

---

*Cadena de Formación · Implantación del Software · Semana 2 de 9 + 1 opcional*
