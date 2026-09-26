# Entregable S08 — Mantenimiento, Soporte y Capacitación

<!-- 📝 Instrucción: completa cada sección con datos de TU proyecto real. Los valores en cursiva
son ejemplos parciales de la app de referencia; reemplázalos. Personas por rol ("administrador
del servidor"), nunca con datos personales. -->

| Campo | Valor |
|---|---|
| Proyecto | |
| Equipo | |
| Versión del software | |
| Fecha | |

---

## 9.1 Plan de mantenimiento

### Calendario

| Tarea | Tipo | Frecuencia | Automática / manual | Responsable (rol) | ¿Requiere ventana? |
|---|---|---|---|---|:---:|
| *Parches de seguridad del SO* | *Preventivo* | *Diaria* | *Automática (`unattended-upgrades`)* | *Administrador del servidor* | *No* |
| *Reinicio para parches del kernel* | *Preventivo* | *Mensual* | *Manual* | | *Sí* |
| *Restauración de prueba del respaldo* | *Preventivo* | *Mensual* | *Manual* | | *No* |
| | | | | | |

Ventana de mantenimiento propuesta: <!-- día, hora, duración máxima, aviso a usuarios -->

### Fin de soporte

| Componente | Versión | Fin de soporte | Fuente y fecha de consulta | Acción planeada |
|---|---|---|---|---|
| | | | | |

### Política de actualizaciones

| Tipo | Plazo | Cómo se decide |
|---|---|---|
| *Parche de seguridad* | *Días* | *CI en verde → fusionar → versión de parche* |
| | | |

Enlace a `dependabot.yml`: <!-- ruta -->

Resultado de la auditoría (herramientas, hallazgos y decisión por hallazgo):

| Herramienta | Hallazgo | Severidad | ¿En la imagen desplegada? | Decisión |
|---|---|---|:---:|---|
| | | | | |

## 9.2 Soporte

| Nivel | Quién (rol) | Resuelve | Horario |
|---|---|---|---|
| N0 | *Ayudas en línea* | *Dudas de uso* | *Siempre* |
| N1 | | | |
| N2 | | | |
| N3 | | | |

Canal único de reporte: <!-- enlace al formulario o dirección de soporte, sin datos personales -->

| Prioridad | Primera respuesta | Solución o alternativa |
|---|---|---|
| P1 | | |
| P2 | | |
| P3 | | |
| P4 | | |

<!-- 📝 Estos tiempos son una propuesta: se acuerdan con el cliente en el acta de la semana 9. -->

### Runbooks

| Runbook | Alerta o síntoma | Probado por (rol, otro equipo) | Correcciones tras la prueba |
|---|---|---|---|
| *`docs/runbooks/salud-en-rojo.md`* | *"Salud" en rojo en Uptime Kuma* | | |
| | | | |

## 9.3 Capacitación

| Público | Objetivos observables | Sesión (duración, modalidad) | Materiales | Cómo se evalúa |
|---|---|---|---|---|
| *Usuarios finales* | *Registrar un libro sin ayuda en menos de 2 minutos* | *60 min, presencial* | *Guía rápida, datos de prueba* | *Tarea de verificación + encuesta* |
| *Soporte N1* | | | | |
| *Operación N2* | | | | |

Cronograma:

| Fecha | Público | Responsable (rol) | Participantes esperados |
|---|---|---|---|
| | | | |

## 9.4 Ayudas en línea

| Ayuda | Enlace | Versión del software | Probada por (rol) |
|---|---|---|---|
| Guía rápida | | | |
| Preguntas frecuentes | | | |

Dónde se enlazan (README, aplicación, formulario de soporte):
