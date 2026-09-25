# 📚 Semana 04 — Despliegue Local y en la Nube

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, el aprendiz será capaz de:

1. Liberar versiones con versionado semántico, etiquetas Git, imágenes con versión y notas de versión
2. Organizar archivos y servicios de una aplicación en un servidor Linux con Docker Compose
3. Desplegar, actualizar y revertir una versión en un servidor sin compilar en él
4. Desplegar en PaaS (Render) con base de datos gestionada (Neon / Supabase)
5. Explicar IaaS, PaaS y SaaS, la responsabilidad compartida y estimar costos con calculadoras oficiales
6. Documentar el procedimiento de despliegue como plan de instalación v1

---

## 🧭 Trazabilidad RAP

| Saberes de conceptos | Saberes de proceso |
|---|---|
| C2, C5 | P1, P5 |

**Criterios de evaluación:**

- **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado
- **CE-5** — Elabora el plan de instalación de acuerdo con las características del software a implantar

Ver [`docs/plan-curricular.md`](../../docs/plan-curricular.md).

---

## 📋 Requisitos Previos

- Semanas 1-3: ficha técnica, planes de migración/respaldo/instalación v0, estrategia de hosting
- Docker Engine + Compose; cuenta de GitHub
- Cuentas gratuitas en Render y Neon (o Supabase) — se crean en la práctica 03
- App de referencia: [`referencia/`](../../referencia/README.md)

---

## 🗂️ Estructura de la Semana

```
week-04-despliegue_local_y_nube/
├── README.md                              ← Estás aquí
├── rubrica-evaluacion.md
├── 0-assets/                              ← 3 diagramas SVG
├── 1-teoria/
│   ├── 01-liberacion-del-software.md
│   ├── 02-despliegue-en-servidor.md
│   ├── 03-cloud-computing.md
│   └── 04-costos-y-free-tier.md
├── 2-practicas/
│   ├── 01-liberacion-versionada/
│   ├── 02-despliegue-en-servidor/
│   ├── 03-despliegue-en-render-y-neon/
│   └── 04-estimacion-de-costos/
├── 3-proyecto/
│   ├── README.md
│   └── starter/entregable-s04-procedimiento-despliegue.md
├── 4-recursos/{ebooks-free,videografia,webgrafia}/
└── 5-glosario/
```

---

## 📝 Contenidos

| # | Tema | Tipo |
|---|---|---|
| 1 | [Procedimientos de liberación del software](1-teoria/01-liberacion-del-software.md) | Teoría |
| 2 | [Organización de archivos y despliegue en un servidor](1-teoria/02-despliegue-en-servidor.md) | Teoría |
| 3 | [Cloud computing: modelos y proveedores](1-teoria/03-cloud-computing.md) | Teoría |
| 4 | [Costos en la nube y límites del free tier](1-teoria/04-costos-y-free-tier.md) | Teoría |
| 5 | [Liberar la versión 1.0.0 y la 1.1.0](2-practicas/01-liberacion-versionada/README.md) | Práctica |
| 6 | [Desplegar, actualizar y revertir en un servidor Linux](2-practicas/02-despliegue-en-servidor/README.md) | Práctica |
| 7 | [Desplegar en Render con PostgreSQL en Neon](2-practicas/03-despliegue-en-render-y-neon/README.md) | Práctica |
| 8 | [Estimación de costos](2-practicas/04-estimacion-de-costos/README.md) | Práctica |
| 9 | [Procedimiento de despliegue (plan de instalación v1)](3-proyecto/README.md) | Proyecto |

---

## ⏱️ Distribución del Tiempo (17 horas)

```
🅰️ Ambiente de Formación     ████████████░░░░░   12h  (70%)
🅱️ Trabajo Autónomo          █████░░░░░░░░░░░░    5h  (30%)
```

### 🅰️ Ambiente de Formación (12h)

| Bloque | Horas | Actividad |
|---|:---:|---|
| 1 | 1h | Teoría 01 — liberación y SemVer |
| 2 | 2h | Práctica 01 — liberar 1.0.0 y 1.1.0 |
| 3 | 1h | Teoría 02 — despliegue en servidor |
| 4 | 3h | Práctica 02 — desplegar, actualizar y revertir |
| 5 | 1h | Teoría 03 — cloud computing |
| 6 | 2,5h | Práctica 03 — Render + Neon |
| 7 | 1,5h | Teoría 04 + práctica 04 — costos |

### 🅱️ Trabajo Autónomo (5h)

- Liberar la versión 1.0.0 del proyecto real y desplegarla en servidor y en la nube
- Completar el plan de instalación v1 (sección 5 del Plan de Implantación)

---

## 📌 Entregable de la Semana

**Procedimiento de despliegue** del proyecto real (local y nube) — plan de instalación v1,
sección 5 de [`docs/plan-implantacion-template.md`](../../docs/plan-implantacion-template.md),
con dos despliegues funcionando. Ver [`3-proyecto/`](3-proyecto/README.md).

---

## 🎓 Conceptos Clave

`Release` · `SemVer` · `Etiqueta inmutable` · `Rollback` · `Expandir y contraer` · `IaaS` ·
`PaaS` · `Responsabilidad compartida` · `Free tier` · `Arranque en frío`

Glosario completo: [`5-glosario/`](5-glosario/README.md).

---

## ✅ Checklist de Verificación

- [ ] Liberé dos versiones con etiqueta, imagen y notas de versión
- [ ] Desplegué, actualicé y revertí en un servidor sin compilar en él
- [ ] Desplegué en Render + Neon sin poner secretos en el repositorio
- [ ] Sé qué migraciones permiten volver atrás y cuáles exigen restaurar un respaldo
- [ ] Estimé costos de al menos dos alternativas con fuente y fecha

---

## 🔗 Navegación

| ← Anterior | → Siguiente |
|-----------|-------------|
| [← Semana 03 — Hosting, Dominio y Transferencia de Archivos](../week-03-hosting_dominio_y_transferencia/README.md) | [Semana 05 — Configuración y Pruebas en Servidor →](../week-05-configuracion_y_pruebas_en_servidor/README.md) |

---

## 💡 Consejos para esta Semana

- **Nunca `latest` en producción.** Si no sabes qué versión corre, no puedes volver atrás.
- **No borres la imagen anterior** hasta confirmar que la nueva funciona.
- **Respaldo antes de cada actualización**, aunque la migración parezca inofensiva.
- **Lee los límites del free tier antes de prometérselo al cliente.**

---

*Cadena de Formación · Implantación del Software · Semana 4 de 9 + 1 opcional*
