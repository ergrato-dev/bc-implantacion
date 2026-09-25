# Entregable S05 — Configuración, Verificación y Migración Ejecutada

<!-- 📝 Instrucción: completa cada sección con datos de TU proyecto real. Los valores en cursiva
son ejemplos parciales de la app de referencia; reemplázalos. Nunca pegues valores reales de
secretos: usa marcadores (<clave>) o "configurado en el panel". -->

| Campo | Valor |
|---|---|
| Proyecto | |
| Equipo | |
| Versión del software | |
| Fecha | |

---

## 6.1 Inventario de configuración

| Variable | ¿Secreto? | Desarrollo | Servidor | Nube | Si falta… |
|---|:---:|---|---|---|---|
| *`DATABASE_URL`* | *Sí* | *`.env` local* | *`/opt/<proyecto>/.env` (600)* | *Panel de Render* | *No arranca: mensaje claro* |
| | | | | | |

## 6.2 Servicios

| Servicio | Imagen / versión | Depende de | Política de reinicio | Healthcheck | Rotación de logs |
|---|---|---|---|---|---|
| *app* | *`<proyecto>:1.0.0`* | *db (healthy)* | *unless-stopped* | */api/health* | *3 × 10 MB* |
| | | | | | |

## 6.3 Endpoint de salud

| Campo | Valor |
|---|---|
| Ruta | |
| Dependencias que verifica | |
| Respuesta si está sano | |
| Respuesta si falla una dependencia | |

## 6.4 Pruebas

### Prueba de humo

Verificaciones incluidas:

| # | Verificación | Resultado esperado |
|---|---|---|
| | | |

Salida contra el servidor y contra la nube:

```
<!-- pega aquí -->
```

### Casos funcionales

| ID | Caso | Pasos | Resultado esperado | Resultado obtenido |
|---|---|---|---|---|
| F-01 | | | | |

## 6.5 Lista de verificación posterior al despliegue

- [ ]

---

## 2.8 Evidencia de migración ejecutada (se agrega a la sección 2)

| Campo | Valor |
|---|---|
| Origen (tipo y versión) | |
| Destino (proveedor, versión, región) | |
| Diferencias resueltas (dueño, versión, SSL…) | |

Registro de la ventana:

| Paso | Hora inicio | Hora fin | Resultado |
|---|---|---|---|
| | | | |

Huellas:

```
<!-- salida de la consulta de huella en origen y en destino -->
```

Prueba de humo después del corte:

```
<!-- pega aquí -->
```

¿Fue necesario el rollback? ¿Por qué?
