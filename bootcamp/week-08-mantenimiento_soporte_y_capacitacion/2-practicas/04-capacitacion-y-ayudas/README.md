# Práctica 04 — Capacitación y Ayudas en Línea

<!-- 📝 Instrucción: práctica en parejas. En la parte 4, cada pareja capacita a otra pareja que
hace de bibliotecarios. El instructor controla los tiempos: 15 minutos por sesión, sin
excepciones. -->

## Objetivo

Escribir la guía rápida y las preguntas frecuentes de la app de referencia, planear una
micro-sesión de capacitación para bibliotecarios, dictarla y evaluar si logró su objetivo.

## Duración estimada

150 minutos.

## Preparación

La app de referencia funcionando en tu equipo, con datos de prueba:

```bash
cd ~/biblioteca
cp .env.example .env && docker compose up -d --build --wait
```

## 1. Público y objetivos

Los usuarios son bibliotecarios: usan el computador a diario, no saben qué es una API ni un
ISBN-13 "válido". Escribe **dos** objetivos observables para ellos (teoría 04, sección 3).

- [ ] ¿Cómo comprobarás cada objetivo al final de la sesión?

## 2. Guía rápida

Crea `docs/ayuda/guia-rapida.md` con las tareas de un bibliotecario, escritas por tareas
(teoría 05, sección 2). Ejemplo parcial de una tarea:

```markdown
## Registrar un libro nuevo

**Antes de empezar:** ten a mano el libro; el ISBN está en la contraportada, junto al código de
barras.

1. Abre la biblioteca en el navegador. Verás el catálogo con los libros registrados.
2. En el formulario, escribe el **ISBN** sin guiones ni espacios.
3. Escribe el **Título**, el **Autor** y el **Año**.
4. Pulsa **Agregar libro**. El libro aparece en el catálogo.

**Si algo sale mal**

- *"ya existe un libro con ese ISBN"*: el libro ya está registrado. Búscalo en el catálogo.
- …
```

Revisa la app real: los nombres de campos y botones deben coincidir **exactamente** con los de
la pantalla. Agrega al final la versión del software a la que corresponde la guía.

## 3. Preguntas frecuentes

Crea `docs/ayuda/preguntas-frecuentes.md` con al menos cinco preguntas **reales**: sácalas de la
práctica 03 (reportes 2, 3, 5 y 7) y de lo que pregunte la otra pareja en la parte 4. Cada una:
pregunta en palabras del usuario, respuesta corta, enlace a la tarea de la guía si aplica.

Enlaza ambas desde el `README.md` del repositorio.

## 4. Micro-sesión de 15 minutos

Planea con la estructura de la teoría 04 (sección 4) ajustada a 15 minutos:

| Momento | Minutos | Qué harás | Material |
|---|:---:|---|---|
| Apertura | 1 | | |
| Demostración | 4 | | |
| Práctica guiada | 6 | | |
| Verificación | 3 | | |
| Cierre | 1 | | |

Dicta la sesión a la otra pareja. Mientras una persona capacita, la otra observa con esta lista:

| Aspecto | Sí / No | Observación |
|---|:---:|---|
| Explicó para qué les sirve, no cómo funciona por dentro | | |
| Usó el lenguaje del público (sin "API", "endpoint", "POST") | | |
| Los participantes hicieron la tarea, no solo la vieron | | |
| Comprobó con preguntas abiertas | | |
| Mostró un error y cómo resolverlo | | |
| Terminó a tiempo | | |
| Indicó dónde está la ayuda y cómo pedir soporte | | |

Al final, los participantes hacen la tarea de verificación **sin ayuda** y responden:

1. ¿Te sirvió? (1 a 5)
2. ¿Qué fue lo más difícil?
3. ¿Qué pregunta te quedó?

Intercambien papeles.

## 5. Probar la guía

Una persona de otra pareja sigue tu guía rápida **sin preguntar nada**, sobre tu app, y marca el
paso exacto donde dudó o se equivocó. Corrige la guía.

## 6. Resultados

| Objetivo | Participantes que lo lograron | Promedio de utilidad | Cambios que harás |
|---|---|---|---|
| | | | |

Las preguntas que quedaron van a las preguntas frecuentes.

## ✅ Checklist

- [ ] Dos objetivos observables con su forma de comprobación
- [ ] Guía rápida por tareas, con nombres exactos de la pantalla y versión
- [ ] Preguntas frecuentes reales, enlazadas desde el README
- [ ] Micro-sesión planeada, dictada y observada con la lista
- [ ] Guía probada por otra persona y corregida
- [ ] Resultados de la evaluación con cambios decididos

Teoría relacionada: [`04-plan-de-capacitacion.md`](../../1-teoria/04-plan-de-capacitacion.md),
[`05-ayudas-en-linea.md`](../../1-teoria/05-ayudas-en-linea.md).
