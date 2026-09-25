# 📚 Semana 01 — Plataforma Tecnológica y Hardware

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, el aprendiz será capaz de:

1. Diferenciar servidores rack, blade y torre, y los niveles RAID 0/1/5/6/10
2. Dimensionar CPU, RAM, disco e IOPS a partir de las características del software
3. Clasificar el software de servidor (web, aplicación, base de datos, proxy) y su licenciamiento (permisivo, copyleft, *source-available*, comercial)
4. Comparar hipervisores tipo 1 y tipo 2 (VMware, Proxmox, KVM, VirtualBox) frente a contenedores
5. Seleccionar el sistema operativo de servidor (Ubuntu Server LTS / Debian) y consultar sus requisitos mínimos
6. Verificar con un script los requisitos mínimos de hardware y software del proyecto real

---

## 🧭 Trazabilidad RAP

| Saberes de conceptos | Saberes de proceso |
|---|---|
| C1, C2, C3 | P1, P2 |

**Criterios de evaluación:**

- **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado
- **CE-2** — Verifica el cumplimiento de las características mínimas de hardware requeridas para el software desarrollado

Ver [`docs/plan-curricular.md`](../../docs/plan-curricular.md).

---

## 📋 Requisitos Previos

- Proyecto real del equipo construido (o en construcción) y en un repositorio Git
- Docker instalado en el portátil (Linux o WSL2) — ver [`docs/setup-entorno.md`](../../docs/setup-entorno.md)
- Acceso por SSH a la VM Ubuntu del laboratorio, si está disponible

---

## 🗂️ Estructura de la Semana

```
week-01-plataforma_tecnologica_y_hardware/
├── README.md                                   ← Estás aquí
├── rubrica-evaluacion.md
├── 0-assets/                                   ← 3 diagramas SVG
├── 1-teoria/
│   ├── 01-hardware-de-servidores.md
│   ├── 02-arreglos-de-discos-raid.md
│   ├── 03-dimensionamiento-y-requisitos-minimos.md
│   ├── 04-software-de-servidor-y-licenciamiento.md
│   ├── 05-virtualizacion-y-contenedores.md
│   └── 06-sistemas-operativos-de-servidor.md
├── 2-practicas/
│   ├── 01-inspeccion-de-servidor-linux/
│   └── 02-script-verificacion-requisitos/      ← incluye verificar-requisitos.sh
├── 3-proyecto/
│   ├── README.md
│   └── starter/entregable-s01-ficha-tecnica.md
├── 4-recursos/{ebooks-free,videografia,webgrafia}/
└── 5-glosario/
```

---

## 📝 Contenidos

| # | Tema | Tipo |
|---|---|---|
| 1 | [Hardware de servidores: torre, rack y blade](1-teoria/01-hardware-de-servidores.md) | Teoría |
| 2 | [Arreglos de discos (RAID)](1-teoria/02-arreglos-de-discos-raid.md) | Teoría |
| 3 | [Dimensionamiento y requisitos mínimos](1-teoria/03-dimensionamiento-y-requisitos-minimos.md) | Teoría |
| 4 | [Software de servidor y licenciamiento](1-teoria/04-software-de-servidor-y-licenciamiento.md) | Teoría |
| 5 | [Máquinas virtuales y contenedores](1-teoria/05-virtualizacion-y-contenedores.md) | Teoría |
| 6 | [Sistemas operativos de servidor](1-teoria/06-sistemas-operativos-de-servidor.md) | Teoría |
| 7 | [Inspección de un servidor Linux](2-practicas/01-inspeccion-de-servidor-linux/README.md) | Práctica |
| 8 | [Script de verificación de requisitos](2-practicas/02-script-verificacion-requisitos/README.md) | Práctica |
| 9 | [Ficha técnica y matriz de requisitos](3-proyecto/README.md) | Proyecto |

---

## ⏱️ Distribución del Tiempo (17 horas)

```
🅰️ Ambiente de Formación     ████████████░░░░░   12h  (70%)
🅱️ Trabajo Autónomo          █████░░░░░░░░░░░░    5h  (30%)
```

### 🅰️ Ambiente de Formación (12h)

| Bloque | Horas | Actividad |
|---|:---:|---|
| 1 | 2h | Teoría 01 y 02 — hardware y RAID |
| 2 | 2h | Teoría 04 y 05 — software, licencias, virtualización |
| 3 | 1,5h | Teoría 06 — sistemas operativos |
| 4 | 1,5h | Práctica 01 — inspección de servidor Linux |
| 5 | 1,5h | Teoría 03 — dimensionamiento |
| 6 | 2h | Práctica 02 — script de verificación |
| 7 | 1,5h | Arranque del entregable: medición del proyecto real con acompañamiento |

### 🅱️ Trabajo Autónomo (5h)

- Adaptar el script de verificación al proyecto real y ejecutarlo en un servidor Linux
- Completar la ficha técnica (sección 1 del Plan de Implantación)
- Repasar el glosario y la webgrafía

---

## 📌 Entregable de la Semana

**Ficha técnica y matriz de requisitos mínimos** del proyecto real — sección 1 de
[`docs/plan-implantacion-template.md`](../../docs/plan-implantacion-template.md), más
`scripts/verificar-requisitos.sh` adaptado en el repositorio del proyecto. Ver
[`3-proyecto/`](3-proyecto/README.md).

---

## 🎓 Conceptos Clave

`Rack / Blade` · `RAID` · `IOPS` · `Requisito mínimo vs recomendado` · `Licencia copyleft` ·
`Hipervisor` · `Contenedor` · `LTS`

Glosario completo: [`5-glosario/`](5-glosario/README.md).

---

## ✅ Checklist de Verificación

- [ ] Sé explicar por qué RAID no reemplaza un respaldo
- [ ] Mi matriz tiene requisitos mínimos **y** recomendados, con el margen calculado
- [ ] Conozco la licencia de cada componente de mi proyecto
- [ ] Sé la fecha de fin de soporte del sistema operativo elegido
- [ ] El script de verificación detecta fallos provocados a propósito
- [ ] La ficha técnica no contiene IPs, hosts ni credenciales reales

---

## 🔗 Navegación

| ← Anterior | → Siguiente |
|-----------|-------------|
| [← Inicio](../../README.md) | [Semana 02 — Plan de Instalación, Migración y Respaldo →](../week-02-plan_de_instalacion_migracion_y_respaldo/README.md) |

---

## 💡 Consejos para esta Semana

- **Mide, no adivines.** Un requisito sin medición es una opinión. `docker stats` toma 30 segundos.
- **Mínimo ≠ producción.** Si tu ficha solo tiene mínimos, está incompleta.
- **Revisa la licencia de la versión exacta.** Las licencias cambian entre versiones.
- **Un script que nunca falla no prueba nada.** Provoca fallos para confiar en él.

---

*Cadena de Formación · Implantación del Software · Semana 1 de 9 + 1 opcional*
