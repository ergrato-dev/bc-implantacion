# 📊 Rúbrica de Evaluación — Semana 09

> **Semana 09**: Aceptación y Entrega Formal
> **Criterios RAP evaluados**: CE-1, CE-2, CE-3, CE-4, CE-5

---

## Distribución de la Evaluación

| Tipo de Evidencia | Porcentaje | Instrumento |
|-------------------|-----------|-------------|
| 🧠 Conocimiento | 30% | Cuestionario de conceptos clave |
| 💪 Desempeño | 40% | Prácticas `2-practicas/01` a `03` |
| 📦 Producto | 30% | **Plan de Implantación consolidado** del proyecto real, validado en simulacro cruzado (gate) |

**Nota mínima de aprobación por tipo: 70%**

---

## 🧠 Evidencia de Conocimiento (30%)

**Instrumento:** Cuestionario de 10 preguntas

1. ¿Qué diferencia hay entre una prueba de humo y una prueba de aceptación? ¿Quién ejecuta cada una?
2. Escribe un caso de aceptación en formato *Dado / Cuando / Entonces* para un requisito de tu proyecto.
3. ¿Por qué los criterios de salida se acuerdan antes de ejecutar las pruebas?
4. ¿Qué diferencia hay entre un defecto bloqueante, mayor, menor y cosmético?
5. ¿Por qué el Plan de Implantación se valida con otro equipo y no con el que lo escribió?
6. ¿Qué reglas tiene el simulacro cruzado y qué papel cumple el observador?
7. ¿Qué tipos de desviación invalidan un intento del simulacro?
8. ¿Qué debe contener un acta de entrega? ¿Por qué no debe contener secretos?
9. ¿Cuántas horas sin servicio al mes permite una disponibilidad del 99 %? ¿Por qué no prometer más de lo que se puede cumplir?
10. ¿Qué revisiones se hacen al consolidar el plan?

### Criterios de Calificación

| Puntaje | Desempeño |
|---------|-----------|
| 9-10 correctas | Excelente |
| 7-8 correctas | Bueno |
| 5-6 correctas | Aceptable — requiere repaso |
| < 5 correctas | Insuficiente — revisar toda la teoría de la semana |

---

## 💪 Evidencia de Desempeño (40%)

**Instrumento:** prácticas 01, 02 y 03

| Criterio | Excelente (100%) | Bueno (80%) | Aceptable (60%) | Insuficiente (<60%) |
|----------|-----------------|-------------|-----------------|---------------------|
| **Pruebas de aceptación** (práctica 01) | Casos para todos los requisitos, criterios firmados antes de ejecutar, defectos clasificados y decisión justificada | Sin criterios previos | Casos sin ejecución completa | No ejecuta |
| **Simulacro** (práctica 02) | Superado en ambos papeles, registro completo y firmado, propuestas de mejora basadas en desviaciones | Superado en un papel | Intento con ayuda (invalidado) y registro | No ejecuta |
| **Acta y socialización** (práctica 03) | Acta completa, niveles de servicio justificados, revisada por otro equipo; presentación a tiempo con evidencia | Acta sin revisión cruzada | Acta incompleta | No ejecuta |

**Fórmula:** promedio de los 3 criterios (peso igual).

---

## 📦 Evidencia de Producto (30%)

**Instrumento:** Plan de Implantación consolidado (`docs/plan-implantacion.md` del proyecto
real) con su sección 10 (`entregable-s09-aceptacion-y-entrega.md`), registro del simulacro
firmado y acta de entrega

| Criterio | Puntaje Máx. | Qué se evalúa |
|----------|:---:|---|
| **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado | 20 | Secciones 4, 6, 7 y 8 completas y coherentes con lo que corre (10); en el simulacro, la plataforma quedó preparada solo con el plan (10) |
| **CE-2** — Verifica el cumplimiento de las características mínimas de hardware requeridas para el software desarrollado | 10 | Sección 1 con requisitos vigentes y verificados en el servidor del simulacro con el script (10) |
| **CE-3** — Diseña el plan de migración de datos de acuerdo con las condiciones de implementación | 15 | Sección 2 con procedimiento, validación por huella y evidencia de la migración ejecutada (15) |
| **CE-4** — Diseña el plan de respaldo de los datos para mitigar riesgos | 25 | Sección 3 consolidada (10); restauración del respaldo cifrado por otro equipo con huellas idénticas y tiempo comparado con el RTO (15) |
| **CE-5** — Elabora el plan de instalación de acuerdo con las características del software a implantar | 30 | Sección 5 ejecutable paso a paso (10); pruebas de aceptación con decisión (5); desviaciones del simulacro corregidas en una versión nueva del plan (5); acta con niveles de servicio cumplibles y sin secretos (5); sección 9 y socialización con lecciones aprendidas (5) |

**Total:** 100 puntos

**Condición de aprobación del Producto (gate):** el simulacro cruzado —instalación desde cero y
restauración del respaldo por otro equipo, solo con el plan— debe superarse: servicios sanos,
huellas idénticas, prueba de humo en verde y dentro del tiempo acordado. Sin gate superado, el
Producto **no se acepta**, cualquiera que sea el puntaje.

**Descuento:** −20 puntos si el plan, el acta o el repositorio contienen un secreto real o datos
personales reales.

---

## 📈 Nota Final de la Semana

```
Nota = (Conocimiento × 0.30) + (Desempeño × 0.40) + (Producto × 0.30)
```

---

## 🔄 Criterios de Recuperación

Si alguna evidencia está entre 60% y 69%:

1. **Conocimiento:** repetir el cuestionario con preguntas distintas (plazo: 3 días)
2. **Desempeño:** completar lo que falte de las prácticas (plazo: 3 días)
3. **Producto:** corregir el plan según el registro del simulacro y **repetir el simulacro** con
   otro equipo (plazo acordado con el instructor)

Si el gate no se supera, el equipo corrige el plan y agenda un nuevo simulacro; el Producto
queda pendiente hasta superarlo.

---

*Cadena de Formación · Implantación del Software · Semana 9 de 9 + 1 opcional*
