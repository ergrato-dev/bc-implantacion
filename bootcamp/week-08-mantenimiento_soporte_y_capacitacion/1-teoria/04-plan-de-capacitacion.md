# Plan de Capacitación

## 🎯 Objetivos

- Identificar los públicos que necesitan capacitación y lo que cada uno debe lograr
- Redactar objetivos de capacitación observables
- Planear sesiones con técnicas activas y comunicación oral clara
- Evaluar si la capacitación funcionó

## 📋 Contenido

### 1. Implantar también es enseñar

Un software instalado que nadie sabe usar, o que nadie sabe operar, no está implantado. La
capacitación es parte del plan de implantación: sin ella, el soporte N1 recibe las mismas
preguntas cada día.

### 2. Públicos

| Público | Necesita | Ejemplo en la app de referencia |
|---|---|---|
| **Usuarios finales** | Hacer sus tareas diarias | Bibliotecarios: consultar y registrar libros |
| **Soporte N1** | Resolver consultas y clasificar reportes | Mesa de ayuda: preguntas frecuentes, formulario de reporte, runbooks básicos |
| **Operación (N2)** | Mantener el servicio | Administrador del servidor: desplegar, respaldar, restaurar, monitorear |

Cada público recibe una sesión distinta: a un bibliotecario no se le explica Docker; a quien
opera el servidor no le basta con la guía rápida.

### 3. Objetivos observables

Un objetivo de capacitación describe algo que la persona **podrá hacer** y que se puede comprobar.

| ❌ Vago | ✅ Observable |
|---|---|
| Conocer el sistema | Registrar un libro nuevo sin ayuda en menos de 2 minutos |
| Entender los respaldos | Restaurar el último respaldo en un servidor de prueba siguiendo el procedimiento |
| Saber qué hacer si falla | Clasificar un reporte con la matriz de prioridad y escalarlo con los datos completos |

Verbos útiles: registrar, consultar, clasificar, restaurar, desplegar, identificar. Verbos que no
se pueden observar: conocer, entender, comprender.

### 4. Estructura de una sesión

| Momento | Tiempo (sesión de 60 min) | Qué se hace |
|---|:---:|---|
| Apertura | 5 min | Para qué sirve el software **para ellos**, qué lograrán al terminar |
| Demostración | 15 min | Quien capacita hace la tarea completa, en el sistema real o en uno de prueba |
| Práctica guiada | 25 min | Cada participante hace la tarea con datos de prueba; quien capacita acompaña |
| Verificación | 10 min | Una tarea corta sin ayuda: el objetivo se cumple o no |
| Cierre | 5 min | Dónde está la ayuda en línea, cómo pedir soporte, preguntas |

Se aprende haciendo: la exposición larga sin práctica se olvida en días.

### 5. Comunicación oral

- **Lenguaje del público**: "guardar el libro", no "hacer un POST a `/api/libros`".
- **Una idea por paso**: mostrar, pausar, dejar que lo hagan.
- **Preguntas abiertas** para comprobar: "¿qué harías si…?" en lugar de "¿quedó claro?".
- **Ritmo**: hablar pausado, mirar al grupo, no leer las diapositivas.
- **Errores a propósito**: mostrar qué pasa cuando algo sale mal y cómo se resuelve (por ejemplo,
  un ISBN duplicado) prepara mejor que una demostración perfecta.
- **Accesibilidad**: letra grande en pantalla, contraste, materiales disponibles antes y después.

### 6. Materiales

| Material | Para qué | Dónde vive |
|---|---|---|
| Guía rápida | Recordar las tareas diarias | Ayuda en línea (teoría 05) |
| Preguntas frecuentes | Resolver dudas sin llamar a soporte | Ayuda en línea |
| Datos de práctica | Practicar sin dañar datos reales | Ambiente de pruebas con datos sintéticos |
| Ejercicio de verificación | Comprobar el objetivo | Plan de la sesión |
| Registro de asistencia y resultados | Evidencia de la capacitación | Plan de Implantación |

### 7. Evaluar la capacitación

| Nivel | Pregunta | Instrumento |
|---|---|---|
| Reacción | ¿Les resultó útil? | Encuesta corta al cierre |
| Aprendizaje | ¿Lograron el objetivo? | Ejercicio de verificación |
| Aplicación | ¿Lo usan en su trabajo? | Consultas a soporte en las semanas siguientes |

Son los primeros tres niveles del modelo de Kirkpatrick. Si después de capacitar llegan muchas
consultas sobre la misma tarea, la sesión o la guía de esa tarea necesita cambiar.

### 8. Cronograma

La capacitación ocurre **antes** de la puesta en producción (semana 9), con el software ya
instalado en un ambiente de prueba. Se programa por público, con fecha, duración, lugar o enlace,
responsable y número de participantes.

### 9. Aplicación al proyecto real

Elabora el plan de capacitación de tu proyecto: públicos, objetivos observables por público,
sesiones, materiales, evaluación y cronograma.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
