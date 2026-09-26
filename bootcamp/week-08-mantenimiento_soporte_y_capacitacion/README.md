# 📚 Semana 08 — Mantenimiento, Soporte y Capacitación

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, el aprendiz será capaz de:

1. Diseñar un plan de mantenimiento: parches, imágenes, dependencias y fin de soporte de cada componente
2. Automatizar la detección de actualizaciones con Dependabot y auditar vulnerabilidades
3. Definir un modelo de soporte por niveles (N0-N3) con prioridades, tiempos y runbooks
4. Diseñar un plan de capacitación con objetivos observables y dictar una sesión
5. Elaborar ayudas en línea: guía rápida y preguntas frecuentes en Markdown

---

## 🧭 Trazabilidad RAP

| Saberes de conceptos | Saberes de proceso |
|---|---|
| — | P5 |

**Criterios de evaluación:**

- **CE-5** — Elabora el plan de instalación de acuerdo con las características del software a implantar

Ver [`docs/plan-curricular.md`](../../docs/plan-curricular.md).

---

## 📋 Requisitos Previos

- Semana 4: repositorio `~/biblioteca` en GitHub
- Semana 6: respaldos y manejo de secretos
- Semana 7: CI con regla en `main`, pipeline de liberación y monitoreo
- Docker Engine + Compose

---

## 🗂️ Estructura de la Semana

```
week-08-mantenimiento_soporte_y_capacitacion/
├── README.md                                  ← Estás aquí
├── rubrica-evaluacion.md
├── 0-assets/                                  ← 4 diagramas SVG
├── 1-teoria/
│   ├── 01-plan-de-mantenimiento.md
│   ├── 02-actualizaciones-y-dependencias.md
│   ├── 03-soporte-por-niveles.md
│   ├── 04-plan-de-capacitacion.md
│   └── 05-ayudas-en-linea.md
├── 2-practicas/
│   ├── laboratorio/                           ← servidor Ubuntu sin actualizar + dependencias heredadas
│   ├── 01-dependencias-y-vulnerabilidades/
│   ├── 02-mantenimiento-del-servidor/
│   ├── 03-soporte-y-runbooks/
│   └── 04-capacitacion-y-ayudas/
├── 3-proyecto/
│   ├── README.md
│   └── starter/entregable-s08-mantenimiento-soporte-y-capacitacion.md
├── 4-recursos/{ebooks-free,videografia,webgrafia}/
└── 5-glosario/
```

La configuración de Dependabot y los formularios de reporte de la app de referencia están en
[`referencia/.github/`](../../referencia/.github/dependabot.yml).

---

## 📝 Contenidos

| # | Tema | Tipo |
|---|---|---|
| 1 | [Plan de mantenimiento](1-teoria/01-plan-de-mantenimiento.md) | Teoría |
| 2 | [Actualizaciones de dependencias, imágenes y sistema operativo](1-teoria/02-actualizaciones-y-dependencias.md) | Teoría |
| 3 | [Soporte por niveles](1-teoria/03-soporte-por-niveles.md) | Teoría |
| 4 | [Plan de capacitación](1-teoria/04-plan-de-capacitacion.md) | Teoría |
| 5 | [Ayudas en línea](1-teoria/05-ayudas-en-linea.md) | Teoría |
| 6 | [Laboratorio de la semana](2-practicas/laboratorio/README.md) | Preparación |
| 7 | [Dependencias y vulnerabilidades](2-practicas/01-dependencias-y-vulnerabilidades/README.md) | Práctica |
| 8 | [Mantenimiento del servidor](2-practicas/02-mantenimiento-del-servidor/README.md) | Práctica |
| 9 | [Soporte, runbooks y análisis de incidentes](2-practicas/03-soporte-y-runbooks/README.md) | Práctica |
| 10 | [Capacitación y ayudas en línea](2-practicas/04-capacitacion-y-ayudas/README.md) | Práctica |
| 11 | [Mantenimiento, soporte y capacitación del proyecto real](3-proyecto/README.md) | Proyecto |

---

## ⏱️ Distribución del Tiempo (17 horas)

```
🅰️ Ambiente de Formación     ████████████░░░░░   12h  (70%)
🅱️ Trabajo Autónomo          █████░░░░░░░░░░░░    5h  (30%)
```

### 🅰️ Ambiente de Formación (12h)

| Bloque | Horas | Actividad |
|---|:---:|---|
| 1 | 1h | Teoría 01 y 02 — mantenimiento y actualizaciones |
| 2 | 2,5h | Práctica 01 — dependencias y vulnerabilidades |
| 3 | 2h | Práctica 02 — mantenimiento del servidor |
| 4 | 0,5h | Teoría 03 — soporte por niveles |
| 5 | 2h | Práctica 03 — soporte, runbooks e incidentes |
| 6 | 1h | Teoría 04 y 05 — capacitación y ayudas en línea |
| 7 | 2,5h | Práctica 04 — capacitación y ayudas en línea |
| 8 | 0,5h | Arranque del entregable |

### 🅱️ Trabajo Autónomo (5h)

- Configurar Dependabot y auditar el proyecto real
- Escribir los runbooks, la guía rápida y las preguntas frecuentes del proyecto real
- Completar la sección 9 del Plan de Implantación

---

## 📌 Entregable de la Semana

**Mantenimiento, soporte y capacitación** del proyecto real — sección 9 de
[`docs/plan-implantacion-template.md`](../../docs/plan-implantacion-template.md). Ver
[`3-proyecto/`](3-proyecto/README.md).

---

## 🎓 Conceptos Clave

`Correctivo / preventivo / adaptativo / perfectivo` · `EOL` · `Dependabot` · `CVE` · `Trivy` ·
`unattended-upgrades` · `N0-N3` · `Impacto × urgencia` · `SLA` · `Runbook` · `Análisis sin culpables` ·
`Objetivo observable` · `Guía rápida` · `FAQ`

Glosario completo: [`5-glosario/`](5-glosario/README.md).

---

## ✅ Checklist de Verificación

- [ ] Mi proyecto recibe pull requests de actualización y sé cuáles fusionar y cuándo
- [ ] Sé qué vulnerabilidades tiene mi imagen y de dónde vienen
- [ ] Mi servidor instala solo los parches de seguridad y alguien revisa el resto
- [ ] Cualquier reporte llega por un canal, se prioriza y tiene un runbook o un nivel que lo atiende
- [ ] Otra persona usó mi guía rápida sin preguntarme nada

---

## 🔗 Navegación

| ← Anterior | → Siguiente |
|-----------|-------------|
| [← Semana 07 — CI/CD de Despliegue y Monitoreo](../week-07-cicd_de_despliegue_y_monitoreo/README.md) | [Semana 09 — Aceptación y Entrega Formal →](../week-09-aceptacion_y_entrega_formal/README.md) |

---

*Cadena de Formación · Implantación del Software · Semana 8 de 9 + 1 opcional*
