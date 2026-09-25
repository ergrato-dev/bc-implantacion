# Proyecto Semana 2 — Planes de Migración, Respaldo e Instalación (v0)

## 📋 Instrucciones

Esta semana completas tres secciones del Plan de Implantación de tu proyecto real
(`docs/plan-implantacion.md`, copiado de
[`docs/plan-implantacion-template.md`](../../../docs/plan-implantacion-template.md)):

| Sección | Versión esta semana | Se completa en |
|---|---|---|
| 2. Plan de migración de datos | Diseño completo | Semana 5 (ejecución real) |
| 3. Plan de respaldo | v0 | Semana 6 (automatizado y cifrado) |
| 5. Plan de instalación | v0 | Semana 4 (comandos reales) |

Usa [`starter/entregable-s02-planes.md`](starter/entregable-s02-planes.md) como guía detallada.

Además, en el repositorio del proyecto:

- Agrega `scripts/respaldar.sh` adaptado de la práctica 01 a tu base de datos.
- Ejecuta un respaldo y una **restauración en base aparte** de tu proyecto y pega los conteos
  antes y después en el entregable.

## ❓ Preguntas Guía

- ¿De dónde vienen los datos iniciales de tu proyecto? ¿Quién los tiene hoy y en qué formato?
- ¿Qué pasaría si mañana se borra tu base de datos? ¿Cuántas horas de trabajo del cliente se
  perderían?
- ¿Qué archivos, además de la base de datos, perdería el cliente si se daña el servidor?
- ¿Podría otro equipo instalar tu proyecto hoy con lo que tienes escrito?

## ✅ Checklist de Cierre

- [ ] Plan de migración con origen real identificado, tabla de mapeo, reglas de rechazo,
      validaciones, rollback y matriz de riesgos
- [ ] Plan de respaldo con qué se respalda, RPO/RTO, frecuencia, retención, 3-2-1 y
      procedimiento de restauración de 8 pasos
- [ ] Evidencia de restauración real de la base del proyecto (conteos antes y después)
- [ ] Plan de instalación v0 con las 10 secciones, ninguna vacía
- [ ] `scripts/respaldar.sh` en el repositorio del proyecto
- [ ] Sin IPs, hosts, usuarios ni contraseñas reales
