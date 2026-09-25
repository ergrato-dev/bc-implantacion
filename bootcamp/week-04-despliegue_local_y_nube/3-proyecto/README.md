# Proyecto Semana 4 — Procedimiento de Despliegue (Plan de Instalación v1)

## 📋 Instrucciones

Esta semana el plan de instalación v0 (semana 2) pasa a **v1**: comandos reales, probados, para
desplegar tu proyecto real en un servidor Linux **y** en la nube. Actualiza la sección 5 del Plan
de Implantación (`docs/plan-implantacion.md`) usando
[`starter/entregable-s04-procedimiento-despliegue.md`](starter/entregable-s04-procedimiento-despliegue.md).

En el repositorio del proyecto:

- Etiqueta `v1.0.0` publicada y `CHANGELOG.md`
- Carpeta `deploy/` con `compose.prod.yaml`, configuración del proxy, `env.prod.example` y, si
  aplica, el Blueprint o configuración del PaaS
- `scripts/smoke-test.sh` adaptado a los endpoints de tu proyecto

Y dos despliegues funcionando:

1. **Servidor Linux** (VM del laboratorio u opción simulada) con estructura `/opt/<proyecto>`
2. **Nube** (Render + Neon/Supabase u otra combinación gratuita justificada)

## ❓ Preguntas Guía

- ¿Tu proyecto se puede empaquetar en una sola imagen o necesita varias? ¿Por qué?
- ¿Qué valores cambian entre tu equipo, el servidor y la nube? ¿Están todos en variables de entorno?
- ¿Alguna de tus migraciones impide volver a la versión anterior?
- ¿Qué pasa con tus usuarios cuando el servicio gratuito se suspende por inactividad?

## ✅ Checklist de Cierre

- [ ] Versión `1.0.0` liberada: etiqueta, imagen y notas de versión
- [ ] Procedimiento de despliegue en servidor con comandos exactos y resultado esperado
- [ ] Procedimiento de actualización y de rollback, probados
- [ ] Despliegue en la nube funcionando, con la URL y la salida de la prueba de humo
- [ ] Estimación de costos con dos alternativas y recomendación
- [ ] Ningún secreto en el repositorio (`.env`, cadenas de conexión)
