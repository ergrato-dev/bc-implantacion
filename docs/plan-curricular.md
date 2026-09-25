# 📐 Plan Curricular y Trazabilidad RAP

## Ficha del RAP

| Campo | Valor |
|---|---|
| **RAP** | Planear actividades de implantación del software de acuerdo con las condiciones del sistema |
| **Duración** | 9 semanas · 153 horas (17h/semana: 12h Ambiente de Formación + 5h Trabajo Autónomo) + 1 semana opcional (17h) |
| **Población** | Cadena de formación — Tecnólogo ADSO |
| **Hilo conductor** | Dual: prácticas sobre la app de referencia común (`referencia/`), entregable semanal sobre el proyecto real del equipo |
| **Meta de cierre** | Plan de Implantación del proyecto real consolidado y validado por otro equipo (gate semana 9) |

---

## Saberes de Conceptos y Principios

| # | Saber | Semana(s) |
|---|---|---|
| C1 | Hardware de servidores: rack, blade, arreglos de discos | 1 |
| C2 | Software de servidores: tipos, características, licenciamiento, máquinas virtuales (VMware), servidores de bases de datos | 1, 4, 5, 6, 10 |
| C3 | Sistemas operativos de servidores: concepto, características, tipos (Linux, Windows Server), licenciamiento, requisitos mínimos de instalación | 1, 6, 10 |
| C4 | Migración de datos: concepto, planes, copias de seguridad, procesos de restauración | 2, 5 |
| C5 | Hosting y dominio: tipos, configuraciones, gestores de contenidos | 3, 4, 7 |
| C6 | FTP: concepto, transferencia de archivos | 3 |

> C3 — Windows Server se trata solo como comparativa conceptual (licenciamiento, ediciones). La
> práctica es 100% Linux (Ubuntu Server LTS en el laboratorio o en contenedores).
> C5 — "gestores de contenidos" se aborda como concepto dentro de los tipos de hosting; no se
> instala ningún CMS prehecho.

---

## Saberes de Proceso

| # | Saber | Semana de introducción | Reforzado en |
|---|---|:---:|---|
| P1 | Preparar la plataforma tecnológica | 1 | 3, 4, 5, 6, 7, 9 |
| P2 | Verificar el cumplimiento de las características mínimas de hardware requeridas para el software desarrollado | 1 | 9 |
| P3 | Diseñar el plan de migración de datos | 2 | 5, 9 |
| P4 | Diseñar el plan de respaldo de los datos | 2 | 6, 9 |
| P5 | Elaborar el plan de instalación | 2 | 4, 7, 8, 9 |

---

## Criterios de Evaluación

| # | Criterio | Instrumento principal |
|---|---|---|
| CE-1 | Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado | Servidor Ubuntu / stack Compose preparado y verificado (semanas 1, 3-7) |
| CE-2 | Verifica el cumplimiento de las características mínimas de hardware requeridas para el software desarrollado | Ficha técnica + matriz de requisitos + script de verificación (semana 1) |
| CE-3 | Diseña el plan de migración de datos de acuerdo con las condiciones de implementación | Plan de migración (semana 2) ejecutado local → nube (semana 5) |
| CE-4 | Diseña el plan de respaldo de los datos para mitigar riesgos | Plan de respaldo v0 (semana 2) + restauración probada y cifrada (semana 6) |
| CE-5 | Elabora el plan de instalación de acuerdo con las características del software a implantar | Plan de instalación v0 (semana 2) → procedimiento de despliegue, pipeline, mantenimiento (4, 7, 8) |

---

## Tabla de Trazabilidad: Semana × Saberes × Criterios

| Semana | Tema | Saberes C | Saberes P | Criterios | Sección del Plan de Implantación |
|---|---|---|---|:---:|---|
| 1 | Plataforma tecnológica y hardware | C1, C2, C3 | P1, P2 | CE-1, CE-2 | Ficha técnica y matriz de requisitos |
| 2 | Plan de instalación, migración y respaldo | C4 | P3, P4, P5 | CE-3, CE-4, CE-5 | Plan de migración + plan de respaldo v0 + plan de instalación v0 |
| 3 | Hosting, dominio y transferencia de archivos | C5, C6 | P1 | CE-1 | Estrategia de hosting y dominio |
| 4 | Despliegue local y en la nube | C2, C5 | P1, P5 | CE-1, CE-5 | Procedimiento de despliegue |
| 5 | Configuración y pruebas en servidor | C2, C4 | P1, P3 | CE-1, CE-3 | Checklist de configuración y verificación + migración ejecutada |
| 6 | Seguridad, usuarios y permisos | C2, C3 | P1, P4 | CE-1, CE-4 | Matriz de usuarios/roles + plan de respaldo final |
| 7 | CI/CD de despliegue y monitoreo | C5 | P1, P5 | CE-1, CE-5 | Pipeline de despliegue + monitoreo |
| 8 | Mantenimiento, soporte y capacitación | — | P5 | CE-5 | Mantenimiento, soporte y capacitación |
| 9 | Aceptación y entrega formal | C1-C6 | P1-P5 | CE-1 a CE-5 | **Plan de Implantación consolidado** (gate) |
| 10 *(opcional)* | IaC y automatización | C2, C3 | P1, P5 | CE-1, CE-5 | Plan de instalación ejecutable |

> **Gate semana 9**: otro equipo instala el proyecto desde cero siguiendo **solo** el Plan de
> Implantación y restaura un respaldo. Si el simulacro falla, el Producto no se acepta.

---

## Plataforma y Herramientas (open source / free tier)

| Necesidad | Herramienta | Semana |
|---|---|:---:|
| Servidor | Ubuntu Server LTS (VM del laboratorio) o contenedor `ubuntu` | 1 |
| Contenedores | Docker Engine + Compose | 1-10 |
| Base de datos | PostgreSQL | 2-6 |
| Respaldo | `pg_dump` / `pg_restore`, cron, restic | 2, 6 |
| Reverse proxy + HTTPS | Caddy | 3 |
| DNS / dominio gratis | DuckDNS, subdominio de Render | 3 |
| Transferencia de archivos | SFTP, `scp`, `rsync` (FTP solo conceptual) | 3 |
| PaaS | Render (sin tarjeta) | 4, 7 |
| DB gestionada | Neon o Supabase (free tier) | 4, 5 |
| Seguridad | UFW, SSH por llave, roles PostgreSQL | 6 |
| CI/CD | GitHub Actions + GHCR (principal), GitLab CI (anexo) | 7 |
| Monitoreo | Healthchecks, Uptime Kuma, logs de Docker | 7 |
| Mantenimiento | Dependabot / Renovate | 8 |
| IaC | cloud-init, Ansible, OpenTofu | 10 |

Excluidos a propósito: Windows Server (licencias), CMS prehechos (WordPress y similares),
Heroku (sin free tier).

---

## Distribución Horaria (17h/semana)

| Bloque | Horas | Uso |
|---|:---:|---|
| 🅰️ Ambiente de Formación | 12h | Teoría guiada + práctica sobre la app de referencia + arranque del entregable |
| 🅱️ Trabajo Autónomo | 5h | Aplicar la práctica al proyecto real y completar la sección del Plan de Implantación |
