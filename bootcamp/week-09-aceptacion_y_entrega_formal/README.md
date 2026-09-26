# 📚 Semana 09 — Aceptación y Entrega Formal

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, el aprendiz será capaz de:

1. Ejecutar pruebas de aceptación con el cliente a partir de sus requisitos y documentar la decisión
2. Consolidar el Plan de Implantación y validarlo en un simulacro de instalación limpia realizado por otro equipo
3. Elaborar el acta de entrega con niveles de servicio que el equipo pueda cumplir
4. Socializar los resultados de la implantación y recibir retroalimentación

---

## 🧭 Trazabilidad RAP

| Saberes de conceptos | Saberes de proceso |
|---|---|
| C1-C6 | P1-P5 |

**Criterios de evaluación:**

- **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado
- **CE-2** — Verifica el cumplimiento de las características mínimas de hardware requeridas para el software desarrollado
- **CE-3** — Diseña el plan de migración de datos de acuerdo con las condiciones de implementación
- **CE-4** — Diseña el plan de respaldo de los datos para mitigar riesgos
- **CE-5** — Elabora el plan de instalación de acuerdo con las características del software a implantar

Ver [`docs/plan-curricular.md`](../../docs/plan-curricular.md).

---

## 📋 Requisitos Previos

- Secciones 1 a 9 del Plan de Implantación del proyecto real (semanas 1 a 8)
- Respaldo cifrado del proyecto real (semana 6)
- Docker Engine + Compose

---

## 🗂️ Estructura de la Semana

```
week-09-aceptacion_y_entrega_formal/
├── README.md                                  ← Estás aquí
├── rubrica-evaluacion.md
├── 0-assets/                                  ← 3 diagramas SVG
├── 1-teoria/
│   ├── 01-pruebas-de-aceptacion.md
│   ├── 02-simulacro-cruzado.md
│   ├── 03-acta-de-entrega.md
│   └── 04-consolidacion-y-socializacion.md
├── 2-practicas/
│   ├── laboratorio/                           ← "producción" + preparar-entrega.sh
│   ├── 01-pruebas-de-aceptacion/
│   ├── 02-simulacro-con-la-app-de-referencia/
│   └── 03-acta-y-socializacion/
├── 3-proyecto/
│   ├── README.md                              ← protocolo del gate
│   └── starter/
│       ├── entregable-s09-aceptacion-y-entrega.md
│       ├── registro-del-simulacro.md
│       └── acta-de-entrega.md
├── 4-recursos/{ebooks-free,videografia,webgrafia}/
└── 5-glosario/
```

El Plan de Implantación consolidado de la app de referencia, modelo para esta semana y documento
del simulacro de práctica:
[`referencia/docs/plan-implantacion.md`](../../referencia/docs/plan-implantacion.md).

---

## 📝 Contenidos

| # | Tema | Tipo |
|---|---|---|
| 1 | [Pruebas de aceptación](1-teoria/01-pruebas-de-aceptacion.md) | Teoría |
| 2 | [Simulacro cruzado: el gate del Plan de Implantación](1-teoria/02-simulacro-cruzado.md) | Teoría |
| 3 | [Acta de entrega y niveles de servicio](1-teoria/03-acta-de-entrega.md) | Teoría |
| 4 | [Consolidación del plan y socialización](1-teoria/04-consolidacion-y-socializacion.md) | Teoría |
| 5 | [Laboratorio de la semana](2-practicas/laboratorio/README.md) | Preparación |
| 6 | [Pruebas de aceptación](2-practicas/01-pruebas-de-aceptacion/README.md) | Práctica |
| 7 | [Simulacro cruzado con la app de referencia](2-practicas/02-simulacro-con-la-app-de-referencia/README.md) | Práctica |
| 8 | [Acta de entrega y socialización](2-practicas/03-acta-y-socializacion/README.md) | Práctica |
| 9 | [Plan de Implantación consolidado y gate](3-proyecto/README.md) | Proyecto |

---

## ⏱️ Distribución del Tiempo (17 horas)

```
🅰️ Ambiente de Formación     ████████████░░░░░   12h  (70%)
🅱️ Trabajo Autónomo          █████░░░░░░░░░░░░    5h  (30%)
```

### 🅰️ Ambiente de Formación (12h)

| Bloque | Horas | Actividad |
|---|:---:|---|
| 1 | 0,5h | Teoría 01 — pruebas de aceptación |
| 2 | 2h | Práctica 01 — pruebas de aceptación |
| 3 | 0,5h | Teoría 02 — simulacro cruzado |
| 4 | 3h | Práctica 02 — simulacro con la app de referencia (ensayo del gate) |
| 5 | 0,5h | Teoría 03 y 04 — acta, consolidación y socialización |
| 6 | 1,5h | Práctica 03 — acta y ensayo de la socialización |
| 7 | 3h | **Gate**: simulacro cruzado del proyecto real |
| 8 | 1h | Socialización de resultados |

### 🅱️ Trabajo Autónomo (5h)

- Consolidar el Plan de Implantación del proyecto real (antes del gate)
- Pruebas de aceptación del proyecto real
- Corregir el plan con las desviaciones del simulacro
- Acta de entrega y sección 10 del plan

---

## 📌 Entregable de la Semana

**Plan de Implantación consolidado** del proyecto real, validado en simulacro cruzado, con acta
de entrega — sección 10 de
[`docs/plan-implantacion-template.md`](../../docs/plan-implantacion-template.md). Ver
[`3-proyecto/`](3-proyecto/README.md).

> 🚦 **Gate de entrega**: otro equipo instala el proyecto desde cero siguiendo solo el Plan de
> Implantación y restaura un respaldo. Si falla, el Producto no se acepta.

---

## 🎓 Conceptos Clave

`UAT` · `Caso de aceptación` · `Criterio de salida` · `Severidad` · `Simulacro cruzado` ·
`Desviación` · `Acta de entrega` · `SLA` · `Transferencia de accesos` · `Garantía` · `Lecciones aprendidas`

Glosario completo: [`5-glosario/`](5-glosario/README.md).

---

## ✅ Checklist de Verificación

- [ ] El cliente ejecutó los casos de aceptación y la decisión está firmada
- [ ] Otro equipo instaló mi proyecto desde cero y restauró sus datos solo con el plan
- [ ] Corregí el plan con cada desviación del simulacro
- [ ] El acta tiene niveles de servicio que mi equipo puede cumplir y ningún secreto
- [ ] Presenté los resultados con evidencia en 10 minutos

---

## 🔗 Navegación

| ← Anterior | → Siguiente |
|-----------|-------------|
| [← Semana 08 — Mantenimiento, Soporte y Capacitación](../week-08-mantenimiento_soporte_y_capacitacion/README.md) | [Semana 10 — (Opcional) IaC y Automatización →](../week-10-opcional_iac_y_automatizacion/README.md) |

---

*Cadena de Formación · Implantación del Software · Semana 9 de 9 + 1 opcional*
