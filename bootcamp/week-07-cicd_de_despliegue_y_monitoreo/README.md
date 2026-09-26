# 📚 Semana 07 — CI/CD de Despliegue y Monitoreo

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, el aprendiz será capaz de:

1. Construir un pipeline que pruebe cada cambio, publique la imagen versionada en GHCR y la despliegue en Render
2. Hacer rollback a una versión anterior por etiqueta, sin reconstruir
3. Desplegar en un servidor por arrastre, con verificación y rollback automático
4. Conocer el equivalente del pipeline en GitLab CI
5. Monitorear disponibilidad, versión y respaldos con Uptime Kuma, y diagnosticar con logs

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

## 📋 Requisitos Previos

- Semana 4: repositorio `~/biblioteca` en GitHub, versiones etiquetadas y servicio en Render con Neon
- Semana 5: healthcheck y prueba de humo
- Semana 6: script de respaldo y manejo de secretos
- Docker Engine + Compose; opcional, la CLI de GitHub (`gh`)

---

## 🗂️ Estructura de la Semana

```
week-07-cicd_de_despliegue_y_monitoreo/
├── README.md                                  ← Estás aquí
├── rubrica-evaluacion.md
├── 0-assets/                                  ← 4 diagramas SVG
├── 1-teoria/
│   ├── 01-ci-cd-orientado-a-despliegue.md
│   ├── 02-github-actions-y-ghcr.md
│   ├── 03-despliegue-y-rollback.md
│   ├── 04-monitoreo-basico.md
│   └── 05-anexo-gitlab-ci.md
├── 2-practicas/
│   ├── laboratorio/                           ← registro local + app + PostgreSQL + Uptime Kuma
│   ├── 01-integracion-continua/
│   ├── 02-entrega-continua-ghcr-y-render/
│   ├── 03-despliegue-en-servidor-con-rollback/
│   ├── 04-monitoreo-con-uptime-kuma/
│   └── anexo-gitlab-ci/
├── 3-proyecto/
│   ├── README.md
│   └── starter/entregable-s07-pipeline-y-monitoreo.md
├── 4-recursos/{ebooks-free,videografia,webgrafia}/
└── 5-glosario/
```

Los workflows de la app de referencia están en
[`referencia/.github/workflows/`](../../referencia/.github/workflows/ci.yml) y el script de
despliegue en [`referencia/deploy/desplegar.sh`](../../referencia/deploy/desplegar.sh).

---

## 📝 Contenidos

| # | Tema | Tipo |
|---|---|---|
| 1 | [CI/CD orientado al despliegue](1-teoria/01-ci-cd-orientado-a-despliegue.md) | Teoría |
| 2 | [GitHub Actions y GHCR](1-teoria/02-github-actions-y-ghcr.md) | Teoría |
| 3 | [Estrategias de despliegue y rollback](1-teoria/03-despliegue-y-rollback.md) | Teoría |
| 4 | [Monitoreo básico](1-teoria/04-monitoreo-basico.md) | Teoría |
| 5 | [Anexo — el mismo pipeline en GitLab CI](1-teoria/05-anexo-gitlab-ci.md) | Teoría |
| 6 | [Laboratorio de la semana](2-practicas/laboratorio/README.md) | Preparación |
| 7 | [Integración continua con GitHub Actions](2-practicas/01-integracion-continua/README.md) | Práctica |
| 8 | [Entrega continua: GHCR y Render](2-practicas/02-entrega-continua-ghcr-y-render/README.md) | Práctica |
| 9 | [Despliegue en servidor con rollback automático](2-practicas/03-despliegue-en-servidor-con-rollback/README.md) | Práctica |
| 10 | [Monitoreo con Uptime Kuma](2-practicas/04-monitoreo-con-uptime-kuma/README.md) | Práctica |
| 11 | [Anexo — pipeline en GitLab CI](2-practicas/anexo-gitlab-ci/README.md) | Lectura guiada |
| 12 | [Pipeline de despliegue y monitoreo](3-proyecto/README.md) | Proyecto |

---

## ⏱️ Distribución del Tiempo (17 horas)

```
🅰️ Ambiente de Formación     ████████████░░░░░   12h  (70%)
🅱️ Trabajo Autónomo          █████░░░░░░░░░░░░    5h  (30%)
```

### 🅰️ Ambiente de Formación (12h)

| Bloque | Horas | Actividad |
|---|:---:|---|
| 1 | 1h | Teoría 01 y 02 — CI/CD, GitHub Actions y GHCR |
| 2 | 2,5h | Práctica 01 — integración continua |
| 3 | 2,5h | Práctica 02 — entrega continua con GHCR y Render |
| 4 | 0,5h | Teoría 03 — despliegue y rollback |
| 5 | 2h | Práctica 03 — despliegue en servidor con rollback automático |
| 6 | 0,5h | Teoría 04 — monitoreo básico |
| 7 | 2h | Práctica 04 — monitoreo con Uptime Kuma |
| 8 | 1h | Arranque del entregable: workflows del proyecto real |

### 🅱️ Trabajo Autónomo (5h)

- Adaptar los workflows y `desplegar.sh` al proyecto real y liberar una versión con ellos
- Configurar el monitoreo del proyecto real
- Leer el anexo de GitLab CI
- Completar la sección 8 del Plan de Implantación

---

## 📌 Entregable de la Semana

**Pipeline de despliegue + monitoreo** del proyecto real — sección 8 de
[`docs/plan-implantacion-template.md`](../../docs/plan-implantacion-template.md). Ver
[`3-proyecto/`](3-proyecto/README.md).

---

## 🎓 Conceptos Clave

`CI` · `Entrega continua` · `Workflow` · `Runner` · `GHCR` · `Ambiente` · `Deploy hook` ·
`Empuje / arrastre` · `Rollback` · `Expand/contract` · `Uptime Kuma` · `Latido` · `Fatiga de alertas`

Glosario completo: [`5-glosario/`](5-glosario/README.md).

---

## ✅ Checklist de Verificación

- [ ] Un cambio que rompe la prueba de humo no puede llegar a `main`
- [ ] Libero una versión solo con `git tag` + `git push`, y queda verificada en producción
- [ ] Vuelvo a la versión anterior sin reconstruir nada
- [ ] Un despliegue fallido en el servidor vuelve solo a la versión anterior
- [ ] Me entero por una alerta si la app se cae o el respaldo no corre

---

## 🔗 Navegación

| ← Anterior | → Siguiente |
|-----------|-------------|
| [← Semana 06 — Seguridad, Usuarios y Permisos](../week-06-seguridad_usuarios_y_permisos/README.md) | [Semana 08 — Mantenimiento, Soporte y Capacitación →](../week-08-mantenimiento_soporte_y_capacitacion/README.md) |

---

*Cadena de Formación · Implantación del Software · Semana 7 de 9 + 1 opcional*
