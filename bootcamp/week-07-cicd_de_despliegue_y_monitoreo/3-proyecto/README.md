# Proyecto Semana 7 — Pipeline de Despliegue y Monitoreo

## 📋 Instrucciones

Completa la sección 8 del Plan de Implantación de tu proyecto real usando
[`starter/entregable-s07-pipeline-y-monitoreo.md`](starter/entregable-s07-pipeline-y-monitoreo.md).

En el repositorio del proyecto:

- Workflow de CI que construye y ejecuta la prueba de humo (y las pruebas del proyecto, si las
  tiene) en cada *push* y *pull request*
- Regla en `main` que exige ese check
- Workflow de liberación: una etiqueta `vX.Y.Z` construye, prueba y publica la imagen en GHCR
  con esa versión, y despliega en la nube con verificación
- Rollback posible sin reconstruir (`workflow_dispatch` con la versión)
- Secretos solo en el ambiente `produccion`; ninguno en los workflows

Para el servidor (VM del laboratorio o el simulado de la semana 4): `desplegar.sh` adaptado, con
respaldo, migraciones, verificación y rollback automático.

Y monitoreo: Uptime Kuma (en una máquina distinta de la que vigila) con monitores de salud,
versión y latido del respaldo, y un canal de alertas que el equipo lea.

Si tu institución usa GitLab, puedes entregar el pipeline equivalente en `.gitlab-ci.yml`
(anexo).

## ❓ Preguntas Guía

- ¿Cuánto tarda tu proyecto desde `git push` de una etiqueta hasta estar verificado en
  producción?
- ¿Qué pasa si alguien etiqueta un commit que no pasó por `main`?
- Si el despliegue de las 3 a. m. falla, ¿quién se entera, por qué canal y qué hace?
- ¿Alguna de tus migraciones impediría volver a la versión anterior?

## ✅ Checklist de Cierre

- [ ] CI en verde y regla de `main` activa, con un *pull request* rechazado como evidencia
- [ ] Una versión liberada solo con una etiqueta, publicada y verificada en producción
- [ ] Rollback ejecutado y cronometrado
- [ ] Despliegue en el servidor con `desplegar.sh`, incluido un fallo detenido
- [ ] Monitores y canal de alertas, con una alerta real recibida y su recuperación
- [ ] Ningún secreto en el repositorio, los workflows ni el entregable
