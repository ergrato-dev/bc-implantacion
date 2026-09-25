# Entregable S04 — Procedimiento de Despliegue (Plan de Instalación v1)

<!-- 📝 Instrucción: completa cada sección con datos de TU proyecto real. Los valores en cursiva
son ejemplos parciales de la app de referencia; reemplázalos. Usa marcadores (<dominio>,
<ip-servidor>) en lugar de valores reales, y nunca pegues contraseñas ni cadenas de conexión. -->

| Campo | Valor |
|---|---|
| Proyecto | |
| Equipo | |
| Versión del plan | v1 |
| Versión del software cubierta | |
| Fecha | |

---

## 5.1 Proceso de liberación

| Paso | Comando o acción | Resultado esperado |
|---|---|---|
| *Pruebas en verde* | *CI del repositorio* | *Todos los checks pasan* |
| *Etiqueta* | *`git tag -a v1.0.0 -m "..."` + `git push origin v1.0.0`* | *Etiqueta visible en GitHub* |
| *Imagen* | *`docker build -t <proyecto>:1.0.0 --build-arg APP_VERSION=1.0.0 .`* | *Imagen listada con la etiqueta* |
| | | |

Esquema de versiones y criterio SemVer del proyecto:

Enlace al `CHANGELOG.md`:

## 5.2 Despliegue en servidor Linux

### Estructura

```
/opt/<proyecto>/
├──
```

### Variables de entorno

<!-- 📝 Instrucción: nombre de cada variable, para qué sirve y ejemplo ficticio. -->

| Variable | Propósito | Ejemplo (ficticio) |
|---|---|---|
| *`APP_VERSION`* | *Versión desplegada* | *`1.0.0`* |
| | | |

### Instalación inicial

| # | Acción | Comando | Resultado esperado |
|---|---|---|---|
| 1 | *Verificar requisitos* | *`bash scripts/verificar-requisitos.sh`* | *Código de salida 0* |
| 2 | | | |

### Actualización

| # | Acción | Comando | Resultado esperado |
|---|---|---|---|
| 1 | *Respaldo previo* | | |
| 2 | | | |

### Rollback

| # | Acción | Comando | Resultado esperado |
|---|---|---|---|
| 1 | | | |

Clasificación de migraciones (¿permiten rollback sin restaurar?):

| Migración | Cambio | ¿Compatible hacia atrás? |
|---|---|---|
| | | |

### Evidencia

```
<!-- salida de la prueba de humo en el servidor -->
```

## 5.3 Despliegue en la nube

| Componente | Proveedor y plan | Región | Configuración |
|---|---|---|---|
| *App* | *Render — free* | | *Blueprint `render.yaml`* |
| *Base de datos* | *Neon — free* | | *`DATABASE_URL` en el panel* |

URL pública: <!-- https://<servicio>.onrender.com -->

Procedimiento (pasos numerados):

1.

Método de rollback en el PaaS:

Límites del plan gratuito que afectan al cliente (con fuente y fecha):

### Evidencia

```
<!-- salida de la prueba de humo contra la URL pública -->
```

## 5.4 Estimación de costos

| Concepto | Alternativa 1 | Alternativa 2 |
|---|---|---|
| Total mensual | | |
| Total anual | | |
| Horas de administración al mes | | |
| Fuente y fecha | | |

Recomendación al cliente:
