# 📚 Semana 05 — Configuración y Pruebas en Servidor

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, el aprendiz será capaz de:

1. Separar código, configuración y secretos, y configurar el software por ambiente con variables de entorno
2. Configurar los servicios requeridos: servidor de aplicaciones, base de datos, orden de arranque, reinicio y logs
3. Diseñar healthchecks e interpretar los estados de salud de un contenedor
4. Ejecutar pruebas de humo y casos funcionales posteriores al despliegue
5. Ejecutar una migración de datos a una base gestionada con validación por huellas, corte y rollback

---

## 🧭 Trazabilidad RAP

| Saberes de conceptos | Saberes de proceso |
|---|---|
| C2, C4 | P1, P3 |

**Criterios de evaluación:**

- **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado
- **CE-3** — Diseña el plan de migración de datos de acuerdo con las condiciones de implementación

Ver [`docs/plan-curricular.md`](../../docs/plan-curricular.md).

---

## 📋 Requisitos Previos

- Semana 2: plan de migración del proyecto real
- Semana 4: copia de la app de referencia en `~/biblioteca` y despliegues en servidor y nube
- Docker Engine + Compose

---

## 🗂️ Estructura de la Semana

```
week-05-configuracion_y_pruebas_en_servidor/
├── README.md                                  ← Estás aquí
├── rubrica-evaluacion.md
├── 0-assets/                                  ← 3 diagramas SVG
├── 1-teoria/
│   ├── 01-configuracion-por-ambientes.md
│   ├── 02-servicios-requeridos.md
│   ├── 03-healthchecks-y-pruebas.md
│   └── 04-ejecutar-la-migracion.md
├── 2-practicas/
│   ├── laboratorio/                           ← app + PostgreSQL origen (16) y destino (17)
│   ├── 01-configuracion-por-ambiente/
│   ├── 02-healthchecks-y-pruebas/
│   └── 03-migracion-a-base-gestionada/
├── 3-proyecto/
│   ├── README.md
│   └── starter/entregable-s05-configuracion-y-verificacion.md
├── 4-recursos/{ebooks-free,videografia,webgrafia}/
└── 5-glosario/
```

---

## 📝 Contenidos

| # | Tema | Tipo |
|---|---|---|
| 1 | [Configuración del software por ambientes](1-teoria/01-configuracion-por-ambientes.md) | Teoría |
| 2 | [Configuración de los servicios requeridos](1-teoria/02-servicios-requeridos.md) | Teoría |
| 3 | [Healthchecks y pruebas posteriores al despliegue](1-teoria/03-healthchecks-y-pruebas.md) | Teoría |
| 4 | [Ejecutar una migración a una base gestionada](1-teoria/04-ejecutar-la-migracion.md) | Teoría |
| 5 | [Laboratorio de la semana](2-practicas/laboratorio/README.md) | Preparación |
| 6 | [Configuración por ambiente](2-practicas/01-configuracion-por-ambiente/README.md) | Práctica |
| 7 | [Healthchecks y pruebas posteriores al despliegue](2-practicas/02-healthchecks-y-pruebas/README.md) | Práctica |
| 8 | [Migrar la base a un servidor gestionado](2-practicas/03-migracion-a-base-gestionada/README.md) | Práctica |
| 9 | [Configuración, verificación y migración ejecutada](3-proyecto/README.md) | Proyecto |

---

## ⏱️ Distribución del Tiempo (17 horas)

```
🅰️ Ambiente de Formación     ████████████░░░░░   12h  (70%)
🅱️ Trabajo Autónomo          █████░░░░░░░░░░░░    5h  (30%)
```

### 🅰️ Ambiente de Formación (12h)

| Bloque | Horas | Actividad |
|---|:---:|---|
| 1 | 1,5h | Teoría 01 y 02 — configuración y servicios |
| 2 | 2h | Práctica 01 — configuración por ambiente |
| 3 | 1h | Teoría 03 — healthchecks y pruebas |
| 4 | 2h | Práctica 02 — healthchecks y pruebas |
| 5 | 1h | Teoría 04 — ejecutar la migración |
| 6 | 2,5h | Práctica 03 — migración con ventana de mantenimiento |
| 7 | 2h | Arranque del entregable: configuración y prueba de humo del proyecto real |

### 🅱️ Trabajo Autónomo (5h)

- Ejecutar la migración del proyecto real hacia la base en la nube
- Completar la sección 6 y la evidencia de migración del Plan de Implantación

---

## 📌 Entregable de la Semana

**Checklist de configuración y verificación + evidencia de migración ejecutada** del proyecto
real — sección 6 y evidencia de la sección 2 de
[`docs/plan-implantacion-template.md`](../../docs/plan-implantacion-template.md). Ver
[`3-proyecto/`](3-proyecto/README.md).

---

## 🎓 Conceptos Clave

`12-factor` · `Secreto` · `Paridad entre ambientes` · `Fallar rápido` · `service_healthy` ·
`Rotación de logs` · `Readiness` · `Prueba de humo` · `--no-owner` · `Huella` · `Corte`

Glosario completo: [`5-glosario/`](5-glosario/README.md).

---

## ✅ Checklist de Verificación

- [ ] Toda la configuración de mi proyecto está en variables de entorno, con `.env.example` completo
- [ ] Mi proyecto no arranca si falta configuración obligatoria, y lo dice claramente
- [ ] Sé por qué Docker no reinicia un contenedor `unhealthy`
- [ ] Mis logs tienen rotación en producción
- [ ] Migré datos con huellas idénticas y prueba de humo después del corte

---

## 🔗 Navegación

| ← Anterior | → Siguiente |
|-----------|-------------|
| [← Semana 04 — Despliegue Local y en la Nube](../week-04-despliegue_local_y_nube/README.md) | [Semana 06 — Seguridad, Usuarios y Permisos →](../week-06-seguridad_usuarios_y_permisos/README.md) |

---

## 💡 Consejos para esta Semana

- **`docker compose config` antes de desplegar**, pero nunca pegues su salida: tiene secretos.
- **Congela antes de volcar.** Una migración con la app escribiendo pierde datos en silencio.
- **Compara huellas, no impresiones.** "Se ve igual" no es una validación.
- **La prueba de humo va después de cada cambio**: despliegue, actualización, rollback y corte.

---

*Cadena de Formación · Implantación del Software · Semana 5 de 9 + 1 opcional*
