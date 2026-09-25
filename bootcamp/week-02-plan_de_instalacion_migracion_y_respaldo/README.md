# 📚 Semana 02 — Plan de Instalación, Migración y Respaldo

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, el aprendiz será capaz de:

1. Definir objetivos, etapas, mapeo, validaciones, riesgos y rollback de una migración de datos
2. Ejecutar una migración con staging, reglas de rechazo y conciliación verificable
3. Diferenciar tipos de respaldo y aplicar la regla 3-2-1, RPO y RTO
4. Respaldar y restaurar PostgreSQL con `pg_dump` / `pg_restore`, con retención automatizada
5. Probar que un respaldo realmente restaura (respaldo no probado = sin respaldo)
6. Redactar la versión 0 del plan de instalación del proyecto real

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

## 📋 Requisitos Previos

- Semana 1: ficha técnica y matriz de requisitos del proyecto real
- Docker Engine + Compose funcionando (bash o zsh, en Linux o WSL2)
- Proyecto real con su base de datos levantable localmente

---

## 🗂️ Estructura de la Semana

```
week-02-plan_de_instalacion_migracion_y_respaldo/
├── README.md                                ← Estás aquí
├── rubrica-evaluacion.md
├── 0-assets/                                ← 4 diagramas SVG
├── 1-teoria/
│   ├── 01-migracion-de-datos.md
│   ├── 02-plan-de-migracion.md
│   ├── 03-copias-de-seguridad.md
│   ├── 04-restauracion-y-pruebas.md
│   └── 05-plan-de-instalacion.md
├── 2-practicas/
│   ├── laboratorio/                         ← PostgreSQL + datos sintéticos + CSV legado
│   ├── 01-respaldo-y-restauracion/          ← incluye respaldar.sh
│   └── 02-migracion-de-datos/sql/           ← staging, transformar, validar, rollback
├── 3-proyecto/
│   ├── README.md
│   └── starter/entregable-s02-planes.md
├── 4-recursos/{ebooks-free,videografia,webgrafia}/
└── 5-glosario/
```

---

## 📝 Contenidos

| # | Tema | Tipo |
|---|---|---|
| 1 | [Migración de datos: concepto y estrategias](1-teoria/01-migracion-de-datos.md) | Teoría |
| 2 | [Diseño del plan de migración](1-teoria/02-plan-de-migracion.md) | Teoría |
| 3 | [Copias de seguridad](1-teoria/03-copias-de-seguridad.md) | Teoría |
| 4 | [Procesos de restauración y pruebas](1-teoria/04-restauracion-y-pruebas.md) | Teoría |
| 5 | [Diseño del plan de instalación](1-teoria/05-plan-de-instalacion.md) | Teoría |
| 6 | [Laboratorio de la semana](2-practicas/laboratorio/README.md) | Preparación |
| 7 | [Respaldo y restauración de PostgreSQL](2-practicas/01-respaldo-y-restauracion/README.md) | Práctica |
| 8 | [Migración de datos desde un sistema legado](2-practicas/02-migracion-de-datos/README.md) | Práctica |
| 9 | [Planes de migración, respaldo e instalación v0](3-proyecto/README.md) | Proyecto |

---

## ⏱️ Distribución del Tiempo (17 horas)

```
🅰️ Ambiente de Formación     ████████████░░░░░   12h  (70%)
🅱️ Trabajo Autónomo          █████░░░░░░░░░░░░    5h  (30%)
```

### 🅰️ Ambiente de Formación (12h)

| Bloque | Horas | Actividad |
|---|:---:|---|
| 1 | 1,5h | Teoría 03 y 04 — respaldos, RPO/RTO, restauración |
| 2 | 2,5h | Práctica 01 — respaldo, restauración y simulacro de desastre |
| 3 | 2h | Teoría 01 y 02 — migración y plan de migración |
| 4 | 3h | Práctica 02 — migración desde sistema legado |
| 5 | 1h | Teoría 05 — plan de instalación |
| 6 | 2h | Arranque del entregable: origen de datos y respaldo del proyecto real |

### 🅱️ Trabajo Autónomo (5h)

- Adaptar `respaldar.sh` al proyecto real y probar una restauración en base aparte
- Completar las secciones 2, 3 y 5 del Plan de Implantación
- Repasar el glosario

---

## 📌 Entregable de la Semana

**Plan de migración + plan de respaldo v0 + plan de instalación v0** del proyecto real —
secciones 2, 3 y 5 de [`docs/plan-implantacion-template.md`](../../docs/plan-implantacion-template.md),
con evidencia de restauración real. Ver [`3-proyecto/`](3-proyecto/README.md).

---

## 🎓 Conceptos Clave

`Staging` · `Tabla de mapeo` · `Conciliación` · `Rollback` · `RPO` · `RTO` · `Regla 3-2-1` ·
`Retención` · `Paso verificable`

Glosario completo: [`5-glosario/`](5-glosario/README.md).

---

## ✅ Checklist de Verificación

- [ ] Restauré un respaldo en una base aparte y comparé conteos
- [ ] Recuperé la base tras borrar una tabla, con restricciones intactas
- [ ] Ejecuté la migración con las 4 validaciones en `OK` y probé el rollback
- [ ] Mi plan de migración tiene objetivo medible, mapeo, validaciones, rollback y riesgos
- [ ] Mi plan de respaldo tiene RPO/RTO, 3-2-1 y procedimiento de restauración de 8 pasos
- [ ] Mi plan de instalación v0 tiene las 10 secciones, ninguna vacía

---

## 🔗 Navegación

| ← Anterior | → Siguiente |
|-----------|-------------|
| [← Semana 01 — Plataforma Tecnológica y Hardware](../week-01-plataforma_tecnologica_y_hardware/README.md) | [Semana 03 — Hosting, Dominio y Transferencia de Archivos →](../week-03-hosting_dominio_y_transferencia/README.md) |

---

## 💡 Consejos para esta Semana

- **Primero el respaldo, después todo lo demás.** Ninguna migración ni instalación empieza sin
  un respaldo verificado.
- **Restaura para creer.** El tamaño del archivo `.dump` no prueba nada.
- **Las reglas de rechazo las aprueba el cliente**, no el desarrollador.
- **Escribe el plan de instalación para un desconocido.** Si necesita preguntarte algo, falta un paso.

---

*Cadena de Formación · Implantación del Software · Semana 2 de 9 + 1 opcional*
