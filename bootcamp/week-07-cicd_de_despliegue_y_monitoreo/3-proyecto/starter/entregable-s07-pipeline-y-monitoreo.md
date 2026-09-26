# Entregable S07 — Pipeline de Despliegue y Monitoreo

<!-- 📝 Instrucción: completa cada sección con datos de TU proyecto real. Los valores en cursiva
son ejemplos parciales de la app de referencia; reemplázalos. Nunca pegues deploy hooks, tokens,
llaves ni URLs de notificación con credenciales: son secretos. -->

| Campo | Valor |
|---|---|
| Proyecto | |
| Equipo | |
| Versión del software | |
| Fecha | |

---

## 8.1 Pipeline

<!-- 📝 Diagrama del pipeline (puede ser una imagen enlazada o un bloque de texto) con sus
etapas, qué produce cada una y qué pasa si falla. -->

| Workflow | Evento | Etapas | Resultado |
|---|---|---|---|
| *`ci.yml`* | *push a main, pull request* | *construir → levantar → prueba de humo* | *check `prueba-de-humo`* |
| *`release.yml`* | *etiqueta `vX.Y.Z`* | *construir → probar → publicar → desplegar → verificar* | *imagen `ghcr.io/<usuario>/<proyecto>:X.Y.Z` en producción* |
| | | | |

Enlaces a los workflows en el repositorio: <!-- rutas -->

Reglas de protección:

| Regla | Configuración |
|---|---|
| Rama `main` | *Pull request obligatorio, check `prueba-de-humo` obligatorio* |
| Ambiente `produccion` | *Revisores:* |
| Etiquetas | |

## 8.2 Secretos y variables del pipeline

| Nombre | Tipo | Ámbito | Para qué | Quién lo rota |
|---|---|---|---|---|
| *`RENDER_DEPLOY_HOOK_URL`* | *Secreto* | *Ambiente `produccion`* | *Pedir el despliegue a Render* | |
| | | | | |

## 8.3 Evidencia de ejecución

| Evento | Enlace a la ejecución | Duración | Resultado |
|---|---|---|---|
| *Pull request con regresión* | | | *Rechazado: `FALLA ...`* |
| *Liberación `vX.Y.Z`* | | | |
| *Rollback a `vX.Y.Z`* | | | |

## 8.4 Procedimiento de despliegue y rollback

### En la nube

1.
2.

### En el servidor

<!-- 📝 Pasos con desplegar.sh adaptado a tu proyecto: dónde vive, quién lo ejecuta y con qué
permisos, cómo se entera de una versión nueva. Pega el fragmento de despliegues.log de un
despliegue exitoso y de uno detenido. -->

```
<!-- despliegues.log -->
```

### Migraciones compatibles hacia atrás

¿Qué regla sigue tu equipo? ¿Alguna migración existente impide el rollback?

## 8.5 Monitoreo

| Monitor | Tipo | Objetivo | Intervalo | Reintentos | Qué hace quien recibe la alerta |
|---|---|---|---|---|---|
| *Salud* | *HTTP* | *`/api/health`* | *60 s* | *2* | *Revisar logs, `desplegar.sh` a la versión anterior si es el último cambio* |
| *Respaldo diario* | *Push* | *Latido de `respaldar.sh`* | *25 h* | *0* | |
| | | | | | |

| Campo | Valor |
|---|---|
| Dónde corre Uptime Kuma | |
| Canal de alertas y quién lo lee | |
| Horario de atención de alertas | |

Evidencia de una alerta y su recuperación (captura o texto):

```
<!-- pega aquí -->
```
