# 📊 Rúbrica de Evaluación — Semana 08

> **Semana 08**: Mantenimiento, Soporte y Capacitación
> **Criterios RAP evaluados**: CE-5

---

## Distribución de la Evaluación

| Tipo de Evidencia | Porcentaje | Instrumento |
|-------------------|-----------|-------------|
| 🧠 Conocimiento | 30% | Cuestionario de conceptos clave |
| 💪 Desempeño | 40% | Prácticas `2-practicas/01` a `04` |
| 📦 Producto | 30% | Plan de mantenimiento, soporte y capacitación del proyecto real |

**Nota mínima de aprobación por tipo: 70%**

---

## 🧠 Evidencia de Conocimiento (30%)

**Instrumento:** Cuestionario de 10 preguntas

1. Diferencia los mantenimientos correctivo, preventivo, adaptativo y perfectivo con un ejemplo de cada uno.
2. ¿Qué es el fin de soporte (EOL) de un componente y por qué debe estar en el plan de mantenimiento?
3. ¿Qué hace Dependabot? ¿Qué diferencia hay entre sus actualizaciones de versión y de seguridad?
4. ¿Por qué una imagen puede tener vulnerabilidades en paquetes que no están en `requirements.txt`? ¿Cómo se reducen?
5. ¿Qué instala `unattended-upgrades` por defecto y qué deja para la ventana de mantenimiento?
6. ¿Qué resuelve cada nivel de soporte (N0 a N3)? ¿Qué debe llevar un escalamiento?
7. ¿Cómo se calcula la prioridad de un incidente? ¿Qué diferencia hay entre incidente y solicitud?
8. ¿Qué diferencia hay entre SLA, SLO y SLI?
9. Escribe un objetivo de capacitación observable para bibliotecarios y explica cómo lo comprobarías.
10. ¿Por qué las ayudas en línea se escriben por tareas y viven en el repositorio?

### Criterios de Calificación

| Puntaje | Desempeño |
|---------|-----------|
| 9-10 correctas | Excelente |
| 7-8 correctas | Bueno |
| 5-6 correctas | Aceptable — requiere repaso |
| < 5 correctas | Insuficiente — revisar toda la teoría de la semana |

---

## 💪 Evidencia de Desempeño (40%)

**Instrumento:** prácticas 01, 02, 03 y 04

| Criterio | Excelente (100%) | Bueno (80%) | Aceptable (60%) | Insuficiente (<60%) |
|----------|-----------------|-------------|-----------------|---------------------|
| **Dependencias y vulnerabilidades** (práctica 01) | Dependabot con decisiones justificadas, auditorías completas, hallazgo rastreado a su origen, imagen corregida y liberada como parche | Sin liberar la corrección | Solo ejecuta las auditorías | No ejecuta |
| **Mantenimiento del servidor** (práctica 02) | Actualizaciones de seguridad activas y explicadas, revisión programada con una verificación propia, tabla de EOL con fuente y calendario | Sin verificación propia | Solo ejecuta la revisión | No ejecuta |
| **Soporte** (práctica 03) | Reportes clasificados y escalados con datos completos, runbook propio y ajeno probados, análisis sin culpables | Runbook sin probar | Solo clasifica | No ejecuta |
| **Capacitación y ayudas** (práctica 04) | Guía y FAQ por tareas probadas por otra persona, sesión dictada a tiempo con objetivos comprobados y resultados analizados | Sesión sin verificación de objetivos | Solo escribe la guía | No ejecuta |

**Fórmula:** promedio de los 4 criterios (peso igual).

---

## 📦 Evidencia de Producto (30%)

**Instrumento:** sección 9 del Plan de Implantación
(`entregable-s08-mantenimiento-soporte-y-capacitacion.md`) + archivos en el repositorio del proyecto real

| Criterio | Puntaje Máx. | Qué se evalúa |
|----------|:---:|---|
| **CE-5** — Elabora el plan de instalación de acuerdo con las características del software a implantar | 100 | Plan de mantenimiento: calendario con responsables, tabla de EOL con fuente y política de actualizaciones (20); Dependabot configurado y auditoría del proyecto con decisiones (15); modelo de soporte: niveles, canal, matriz de prioridad y tiempos propuestos (15); al menos dos runbooks probados por otra persona (15); plan de capacitación por público con objetivos observables, sesiones, materiales y evaluación (20); guía rápida y preguntas frecuentes publicadas en el repositorio y probadas (15) |

**Total:** 100 puntos

**Condición adicional:** si la guía rápida o los runbooks no fueron probados por alguien que no
los escribió, esos criterios no pueden superar la mitad de su puntaje.

**Descuento:** −20 puntos si el repositorio o el entregable contienen un secreto real o datos
personales reales en ejemplos o capturas.

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
3. **Producto:** completar el entregable según observaciones (plazo: 5 días, antes del simulacro de la semana 9)

Si la nota es inferior al 60%, reunión con el instructor antes de iniciar la semana 9.

---

*Cadena de Formación · Implantación del Software · Semana 8 de 9 + 1 opcional*
