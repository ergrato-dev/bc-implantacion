# 📚 Semana 10 — (Opcional) IaC y Automatización

> Semana opcional: profundiza el Plan de Implantación convirtiendo la instalación en código. No
> es requisito del gate de la semana 9.

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, el aprendiz será capaz de:

1. Explicar la infraestructura como código: enfoque declarativo, idempotencia y deriva
2. Preparar el primer arranque de un servidor con cloud-init
3. Convertir el plan de instalación en un playbook de Ansible idempotente, con secretos en Vault
4. Crear, cambiar y destruir infraestructura con OpenTofu, leyendo el plan antes de aplicar

---

## 🧭 Trazabilidad RAP

| Saberes de conceptos | Saberes de proceso |
|---|---|
| C2, C3 | P1, P5 |

**Criterios de evaluación:**

- **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado
- **CE-5** — Elabora el plan de instalación de acuerdo con las características del software a implantar

Ver [`docs/plan-curricular.md`](../../docs/plan-curricular.md).

---

## 📋 Requisitos Previos

- Semana 9: Plan de Implantación consolidado (sobre todo las secciones 5 y 7)
- Semana 6: llaves SSH, UFW, secretos
- Docker Engine + Compose
- Opcional: Multipass o la VM Ubuntu del laboratorio, para probar cloud-init en una VM real

---

## 🗂️ Estructura de la Semana

```
week-10-opcional_iac_y_automatizacion/
├── README.md                                  ← Estás aquí
├── rubrica-evaluacion.md
├── 0-assets/                                  ← 3 diagramas SVG
├── 1-teoria/
│   ├── 01-infraestructura-como-codigo.md
│   ├── 02-cloud-init.md
│   ├── 03-ansible.md
│   └── 04-opentofu.md
├── 2-practicas/
│   ├── laboratorio/
│   │   ├── cloud-init/user-data.yaml
│   │   ├── ansible/                           ← playbook que instala la app de referencia
│   │   ├── opentofu/main.tf
│   │   └── compose.yaml                       ← servidor Ubuntu "recién creado" + nodo de control
│   ├── 01-cloud-init/
│   ├── 02-ansible/
│   └── 03-opentofu/
├── 3-proyecto/
│   ├── README.md
│   └── starter/entregable-s10-instalacion-ejecutable.md
├── 4-recursos/{ebooks-free,videografia,webgrafia}/
└── 5-glosario/
```

---

## 📝 Contenidos

| # | Tema | Tipo |
|---|---|---|
| 1 | [Infraestructura como código](1-teoria/01-infraestructura-como-codigo.md) | Teoría |
| 2 | [cloud-init: el primer arranque](1-teoria/02-cloud-init.md) | Teoría |
| 3 | [Ansible: el plan de instalación ejecutable](1-teoria/03-ansible.md) | Teoría |
| 4 | [OpenTofu: aprovisionar infraestructura](1-teoria/04-opentofu.md) | Teoría |
| 5 | [Laboratorio de la semana](2-practicas/laboratorio/README.md) | Preparación |
| 6 | [cloud-init](2-practicas/01-cloud-init/README.md) | Práctica |
| 7 | [Ansible: instalar la app con un playbook](2-practicas/02-ansible/README.md) | Práctica |
| 8 | [OpenTofu: la app como infraestructura](2-practicas/03-opentofu/README.md) | Práctica |
| 9 | [Plan de instalación ejecutable del proyecto real](3-proyecto/README.md) | Proyecto |

---

## ⏱️ Distribución del Tiempo (17 horas)

```
🅰️ Ambiente de Formación     ████████████░░░░░   12h  (70%)
🅱️ Trabajo Autónomo          █████░░░░░░░░░░░░    5h  (30%)
```

### 🅰️ Ambiente de Formación (12h)

| Bloque | Horas | Actividad |
|---|:---:|---|
| 1 | 1h | Teoría 01 y 02 — IaC y cloud-init |
| 2 | 1,5h | Práctica 01 — cloud-init |
| 3 | 1h | Teoría 03 — Ansible |
| 4 | 3h | Práctica 02 — Ansible |
| 5 | 1h | Teoría 04 — OpenTofu |
| 6 | 2h | Práctica 03 — OpenTofu |
| 7 | 2,5h | Arranque del entregable: playbook del proyecto real |

### 🅱️ Trabajo Autónomo (5h)

- Completar el playbook del proyecto real hasta `changed=0` en la segunda ejecución
- Actualizar la sección 5 del Plan de Implantación con la instalación automatizada

---

## 📌 Entregable de la Semana

**Plan de instalación ejecutable** (playbook) del proyecto real — nueva subsección de la sección 5
de [`docs/plan-implantacion-template.md`](../../docs/plan-implantacion-template.md). Ver
[`3-proyecto/`](3-proyecto/README.md).

---

## 🎓 Conceptos Clave

`IaC` · `Declarativo` · `Idempotencia` · `Deriva` · `cloud-init` · `user-data` · `Inventario` ·
`Playbook` · `Handler` · `Ansible Vault` · `Proveedor` · `Estado` · `plan / apply` · `prevent_destroy`

Glosario completo: [`5-glosario/`](5-glosario/README.md).

---

## ✅ Checklist de Verificación

- [ ] Mi `user-data` pasa la validación y deja el servidor listo para Ansible
- [ ] Mi playbook instala el proyecto en un servidor limpio y la segunda ejecución da `changed=0`
- [ ] Ningún secreto está en texto plano en el repositorio (Vault, variables de entorno)
- [ ] Leo el plan de OpenTofu antes de aplicar y sé qué cambios reemplazan recursos con datos

---

## 🔗 Navegación

| ← Anterior | → Siguiente |
|-----------|-------------|
| [← Semana 09 — Aceptación y Entrega Formal](../week-09-aceptacion_y_entrega_formal/README.md) | [Inicio →](../../README.md) |

---

*Cadena de Formación · Implantación del Software · Semana 10 de opcional*
