# 📊 Rúbrica de Evaluación — Semana 04

> **Semana 04**: Despliegue Local y en la Nube
> **Criterios RAP evaluados**: CE-1, CE-5

---

## Distribución de la Evaluación

| Tipo de Evidencia | Porcentaje | Instrumento |
|-------------------|-----------|-------------|
| 🧠 Conocimiento | 30% | Cuestionario de conceptos clave |
| 💪 Desempeño | 40% | Prácticas `2-practicas/01` a `04` sobre la app de referencia |
| 📦 Producto | 30% | Procedimiento de despliegue del proyecto real (local y nube) |

**Nota mínima de aprobación por tipo: 70%**

---

## 🧠 Evidencia de Conocimiento (30%)

**Instrumento:** Cuestionario de 10 preguntas

1. Una versión `2.3.1` corrige un error de cálculo. ¿Cuál es la siguiente versión y por qué?
2. ¿Por qué no se despliega la etiqueta `latest`?
3. ¿Por qué la misma imagen debe pasar por pruebas y llegar a producción sin reconstruirse?
4. ¿Qué debe contener la sección "Al actualizar" de unas notas de versión?
5. ¿Cómo llega una imagen a un servidor sin registro? ¿Por qué no se compila en el servidor?
6. ¿Por qué un rollback del código no deshace una migración? ¿Qué migraciones son compatibles con volver atrás?
7. Diferencia IaaS, PaaS y SaaS con un ejemplo de cada uno.
8. En el modelo de responsabilidad compartida, ¿qué sigue siendo responsabilidad del cliente en cualquier modelo?
9. Nombra tres costos de la nube que suelen sorprender.
10. ¿Qué es el arranque en frío y por qué ocurre en los planes gratuitos?

### Criterios de Calificación

| Puntaje | Desempeño |
|---------|-----------|
| 9-10 correctas | Excelente |
| 7-8 correctas | Bueno |
| 5-6 correctas | Aceptable — requiere repaso |
| < 5 correctas | Insuficiente — revisar toda la teoría de la semana |

---

## 💪 Evidencia de Desempeño (40%)

**Instrumento:** prácticas 01 a 04

| Criterio | Excelente (100%) | Bueno (80%) | Aceptable (60%) | Insuficiente (<60%) |
|----------|-----------------|-------------|-----------------|---------------------|
| **Liberación** (práctica 01) | Dos versiones con etiqueta, imagen, CHANGELOG con "Al actualizar" y SemVer justificado | Dos versiones sin "Al actualizar" | Una versión | Ninguna |
| **Despliegue en servidor** (práctica 02) | Instalación, actualización con respaldo previo y rollback, prueba de humo en cada paso | Los tres pasos sin respaldo previo | Solo instalación | No despliega |
| **Análisis de rollback** (práctica 02) | Explica por qué no hizo falta restaurar y qué haría si la migración fuera incompatible | Explica solo lo primero | Explicación vaga | Sin explicación |
| **Despliegue en la nube** (práctica 03) | App en Render + Neon, secretos solo en el panel, arranque en frío medido, rollback identificado | Desplegada sin medir arranque en frío | Desplegada con errores | No desplegada |
| **Costos** (práctica 04) | Tres alternativas con fuente y fecha, costos ocultos y recomendación | Dos alternativas | Una alternativa | Sin estimación |

**Fórmula:** promedio de los 5 criterios (peso igual).

---

## 📦 Evidencia de Producto (30%)

**Instrumento:** sección 5 del Plan de Implantación (`entregable-s04-procedimiento-despliegue.md`),
carpeta `deploy/`, etiqueta `v1.0.0` y `CHANGELOG.md` en el repositorio del proyecto real

| Criterio | Puntaje Máx. | Qué se evalúa |
|----------|:---:|---|
| **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado | 40 | Servidor Linux preparado con estructura, permisos y configuración por variables de entorno (20); plataforma en la nube configurada con secretos fuera del repositorio y límites del plan documentados con fuente (20) |
| **CE-5** — Elabora el plan de instalación de acuerdo con las características del software a implantar | 60 | Proceso de liberación documentado y aplicado (15); instalación, actualización y rollback con comandos exactos y resultado esperado (25); clasificación de migraciones (10); estimación de costos con recomendación (10) |

**Total:** 100 puntos

**Condición adicional:** sin evidencia de ambos despliegues funcionando (salida de la prueba de
humo en servidor y en la nube), el Producto no puede superar 60/100.

**Descuento:** −20 puntos si el repositorio contiene un `.env`, una contraseña o una cadena de
conexión real.

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
3. **Producto:** completar el procedimiento según observaciones (plazo: 5 días, sin retrasar la semana 5)

Si la nota es inferior al 60%, reunión con el instructor antes de iniciar la semana 5.

---

*Cadena de Formación · Implantación del Software · Semana 4 de 9 + 1 opcional*
