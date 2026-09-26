# Ayudas en Línea

## 🎯 Objetivos

- Diferenciar los tipos de ayuda en línea y el público de cada uno
- Escribir ayudas orientadas a tareas, claras y verificables
- Mantener las ayudas junto al código y al día con cada versión
- Publicar las ayudas sin herramientas adicionales

## 📋 Contenido

### 1. Tipos de ayuda

| Tipo | Responde a | Público | Extensión |
|---|---|---|---|
| **Guía rápida** | "¿Cómo hago mi tarea diaria?" | Usuarios finales | 1-2 páginas |
| **Preguntas frecuentes (FAQ)** | "¿Por qué pasa esto?", "¿Se puede…?" | Usuarios y N1 | Una entrada por pregunta real |
| **Tutorial** | "Quiero aprender a hacer X de principio a fin" | Usuarios nuevos | Paso a paso, con un resultado final |
| **Referencia** | "¿Qué significa este campo / este error?" | Usuarios avanzados, N1 | Tablas |
| **Runbook** | "Pasó X, ¿qué hago?" | N1, N2 | Paso a paso (teoría 03) |
| **Manual de operación** | "¿Cómo instalo, actualizo, respaldo?" | N2 | Es el Plan de Implantación |

Esta semana se elaboran la guía rápida y las preguntas frecuentes; los runbooks, en la práctica
de soporte; el manual de operación es el Plan de Implantación que se consolida en la semana 9.

### 2. Escribir por tareas

La ayuda se organiza por lo que la persona quiere **hacer**, no por las pantallas del sistema.

| ❌ Por pantallas | ✅ Por tareas |
|---|---|
| "La pantalla principal tiene un formulario y una tabla" | "Registrar un libro nuevo" |
| "El campo ISBN acepta 10 a 13 caracteres" | "Si aparece *ya existe un libro con ese ISBN*…" |

Cada tarea:

1. **Título** con el verbo de la tarea.
2. **Antes de empezar**: qué se necesita.
3. **Pasos** numerados, una acción por paso, con el resultado esperado.
4. **Si algo sale mal**: los errores más comunes y qué hacer.

### 3. Estilo

- Frases cortas, voz activa, segunda persona: "Escribe el ISBN", no "El ISBN deberá ser
  ingresado".
- Los nombres de botones y campos, **exactamente** como aparecen en pantalla.
- Capturas solo cuando ayudan, con texto alternativo que describa lo importante. Una captura
  desactualizada confunde más que ninguna.
- Sin datos reales en ejemplos ni capturas.
- Indicar la versión del software a la que corresponde la ayuda.

### 4. Preguntas frecuentes que sí son frecuentes

Una FAQ inventada antes de que existan usuarios suele responder lo que nadie pregunta. Fuentes
reales: las preguntas de la capacitación, los reportes a soporte N1, los errores que registra la
app. Cada entrada: la pregunta **en palabras del usuario**, la respuesta corta y, si aplica, el
enlace a la tarea de la guía.

### 5. Ayudas junto al código

| Decisión | Por qué |
|---|---|
| Markdown en `docs/ayuda/` del repositorio | Se revisan en el mismo *pull request* que el cambio que las afecta |
| GitHub las muestra formateadas | Publicadas sin instalar nada; GitHub Pages si se necesita un sitio |
| Enlace desde la app y desde el formulario de soporte | La ayuda que no se encuentra no existe |
| Revisión en la lista de liberación (semana 4) | Cada versión revisa si alguna ayuda cambió |

Un generador de sitios (MkDocs, Docusaurus) agrega búsqueda y navegación; se justifica cuando
las ayudas crecen. Para empezar, Markdown en el repositorio es suficiente.

### 6. Probar una ayuda

Una ayuda se prueba igual que el software: alguien que no la escribió sigue los pasos, sin
preguntar, y anota dónde se detuvo. Es el mismo principio del gate de la semana 9 aplicado a los
usuarios.

### 7. Aplicación al proyecto real

Escribe la guía rápida y las preguntas frecuentes de tu proyecto en `docs/ayuda/`, enlázalas
desde la app o el README, y pruébalas con alguien de otro equipo.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
