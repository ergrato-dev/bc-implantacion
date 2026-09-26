<p align="center">
  <img src="assets/bootcamp-header.svg" alt="Bootcamp Implantación del Software" width="800">
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License MIT"></a>
  <a href="#"><img src="https://img.shields.io/badge/semanas-9%2B1-yellow.svg" alt="9 + 1 Semanas"></a>
  <a href="#"><img src="https://img.shields.io/badge/horas-153-orange.svg" alt="153 Horas"></a>
  <a href="#"><img src="https://img.shields.io/badge/SENA-ADSO-1565C0?logo=graduation-cap&logoColor=white" alt="SENA ADSO"></a>
  <a href="CONTRIBUTING.md"><img src="https://img.shields.io/badge/PRs-Welcome-brightgreen?style=flat-square" alt="PRs Welcome"></a>
</p>

<p align="center">
  <a href="README_EN.md"><img src="https://img.shields.io/badge/🇺🇸_English-0969DA?style=for-the-badge&logoColor=white" alt="English Version"></a>
</p>

---

## 📋 Descripción

Bootcamp de **9 semanas + 1 opcional** para el RAP *"Planear actividades de implantación del
software de acuerdo con las condiciones del sistema"*, dirigido a aprendices de **cadena de
formación ADSO** que ya tienen su proyecto construido (continuidad de
[bc-asesoria-proyecto](https://github.com/ergrato-dev/bc-asesoria-proyecto)).

Al final, cada equipo entrega el **Plan de Implantación** de su proyecto real — plataforma,
requisitos de hardware, migración, respaldo, instalación, despliegue, seguridad, mantenimiento —
validado por otro equipo que lo instala desde cero siguiendo solo el documento.

> 📐 Ver [`docs/plan-curricular.md`](docs/plan-curricular.md) para la trazabilidad completa de
> Saberes de Conceptos, Saberes de Proceso y Criterios de Evaluación del RAP.

### 🎯 Objetivos

- ✅ Preparar la plataforma tecnológica según el sistema operativo seleccionado
- ✅ Verificar los requisitos mínimos de hardware del software desarrollado
- ✅ Diseñar el plan de migración de datos
- ✅ Diseñar el plan de respaldo de los datos
- ✅ Elaborar el plan de instalación
- ✅ Desplegar en servidor Linux local y en la nube con CI/CD y monitoreo básico

### 💡 Enfoque

- **Hilo conductor dual**: las prácticas se hacen sobre una **app de referencia común**
  ([`referencia/`](referencia/README.md), FastAPI + React + PostgreSQL); el entregable semanal
  se aplica al **proyecto real del equipo**.
- **Solo open source y free tier**: Ubuntu Server, Docker, PostgreSQL, Caddy, Render,
  Neon/Supabase, GitHub Actions, Uptime Kuma. Sin Windows Server, sin CMS prehechos.

---

## 🗓️ Contenido por Semana

| Semana | Tema | Criterios |
|:---:|---|:---:|
| [1](bootcamp/week-01-plataforma_tecnologica_y_hardware/README.md) | Plataforma tecnológica y hardware | CE-1, CE-2 |
| [2](bootcamp/week-02-plan_de_instalacion_migracion_y_respaldo/README.md) | Plan de instalación, migración y respaldo | CE-3, CE-4, CE-5 |
| [3](bootcamp/week-03-hosting_dominio_y_transferencia/README.md) | Hosting, dominio y transferencia de archivos | CE-1 |
| [4](bootcamp/week-04-despliegue_local_y_nube/README.md) | Despliegue local y en la nube | CE-1, CE-5 |
| [5](bootcamp/week-05-configuracion_y_pruebas_en_servidor/README.md) | Configuración y pruebas en servidor | CE-1, CE-3 |
| [6](bootcamp/week-06-seguridad_usuarios_y_permisos/README.md) | Seguridad, usuarios y permisos | CE-1, CE-4 |
| [7](bootcamp/week-07-cicd_de_despliegue_y_monitoreo/README.md) | CI/CD de despliegue y monitoreo | CE-1, CE-5 |
| [8](bootcamp/week-08-mantenimiento_soporte_y_capacitacion/README.md) | Mantenimiento, soporte y capacitación | CE-5 |
| [9](bootcamp/week-09-aceptacion_y_entrega_formal/README.md) | Aceptación y entrega formal — **gate** | CE-1 a CE-5 |
| [10](bootcamp/week-10-opcional_iac_y_automatizacion/README.md) | *(Opcional)* IaC y automatización | CE-1, CE-5 |

**Total: 153 horas** (17h/semana: 12h Ambiente de Formación + 5h Trabajo Autónomo) + 17h opcionales.

Cada semana sigue la estructura:

```
week-XX-tema/
├── README.md
├── rubrica-evaluacion.md    # 30% conocimiento · 40% desempeño · 30% producto
├── 0-assets/
├── 1-teoria/
├── 2-practicas/             # sobre la app de referencia
├── 3-proyecto/              # sección del Plan de Implantación del proyecto real
├── 4-recursos/{ebooks-free,videografia,webgrafia}/
└── 5-glosario/
```

---

## 🛠️ Preparación

Ver [`docs/setup-entorno.md`](docs/setup-entorno.md). Instructores: antes de cada curso, revisar
[`docs/checklist-instructor.md`](docs/checklist-instructor.md) y precargar las imágenes de Docker
con `bash scripts/precargar-imagenes.sh`.

---

## 📄 Licencia

[MIT](LICENSE)
