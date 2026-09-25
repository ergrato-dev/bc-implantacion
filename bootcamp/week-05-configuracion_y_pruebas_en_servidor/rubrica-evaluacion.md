# 📊 Rúbrica de Evaluación — Semana 05

> **Semana 05**: Configuración y Pruebas en Servidor
> **Criterios RAP evaluados**: CE-1, CE-3

---

## Distribución de la Evaluación

| Tipo de Evidencia | Porcentaje | Instrumento |
|-------------------|-----------|-------------|
| 🧠 Conocimiento | 30% | Cuestionario de conceptos clave |
| 💪 Desempeño | 40% | Prácticas `2-practicas/01`, `02` y `03` sobre el laboratorio |
| 📦 Producto | 30% | Checklist de configuración y verificación + evidencia de migración ejecutada del proyecto real |

**Nota mínima de aprobación por tipo: 70%**

---

## 🧠 Evidencia de Conocimiento (30%)

**Instrumento:** Cuestionario de 10 preguntas

1. ¿Qué diferencia hay entre configuración y secreto? Da un ejemplo de cada uno.
2. ¿Por qué la configuración no va dentro de la imagen?
3. ¿Qué valor gana si una variable está en la terminal y también en `.env`? ¿Qué hace `--env-file` con `.env`?
4. ¿Qué significa "fallar rápido" y por qué es mejor que arrancar con configuración incompleta?
5. ¿Qué diferencia hay entre `depends_on` a secas y con `condition: service_healthy`?
6. ¿Por qué hay que configurar rotación de logs en producción?
7. ¿Qué verifica un endpoint de tipo *readiness* y qué no debería hacer?
8. ¿Qué diferencia hay entre una prueba de humo, una funcional y una de aceptación?
9. ¿Por qué se detiene la app antes de volcar la base en una migración?
10. ¿Qué problema resuelve `--no-owner` y qué validación demuestra que la migración quedó completa?

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
| **Configuración y precedencia** (práctica 01) | Precedencia demostrada con evidencia, inventario completo, riesgo de logs explicado | Precedencia demostrada, inventario parcial | Ejecuta sin explicar | No ejecuta |
| **Fallar rápido** (práctica 01) | Mensaje claro implementado y comprobado con el código de salida | Mensaje implementado sin comprobar | Solo observa el fallo | No lo aborda |
| **Healthchecks** (práctica 02) | Observa y explica `unhealthy`, recuperación y por qué no hay reinicio automático | Observa sin explicar el reinicio | Solo consulta el estado | No ejecuta |
| **Pruebas** (práctica 02) | Casos funcionales + 2 propios; prueba de humo ampliada vista en verde y en rojo | Ampliada solo en verde | Solo ejecuta los casos dados | No ejecuta |
| **Migración** (práctica 03) | Registro de ventana, error de dueño resuelto, huellas idénticas, corte, verificación y rollback simulado | Sin rollback simulado | Migración sin validar huellas | No migra |

**Fórmula:** promedio de los 5 criterios (peso igual).

---

## 📦 Evidencia de Producto (30%)

**Instrumento:** sección 6 y evidencia de la sección 2 del Plan de Implantación
(`entregable-s05-configuracion-y-verificacion.md`) + cambios en el repositorio del proyecto real

| Criterio | Puntaje Máx. | Qué se evalúa |
|----------|:---:|---|
| **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado | 55 | Inventario de configuración por ambiente con secretos identificados (15); servicios con dependencias, reinicio, healthcheck y rotación de logs (15); la app falla rápido con mensaje claro (10); prueba de humo ampliada, casos funcionales y lista posterior al despliegue (15) |
| **CE-3** — Diseña el plan de migración de datos de acuerdo con las condiciones de implementación | 45 | Migración ejecutada según el plan de la semana 2 (15); diferencias entre servidores identificadas y resueltas (10); huellas de origen y destino iguales (10); registro de la ventana, prueba de humo tras el corte y decisión de rollback justificada (10) |

**Total:** 100 puntos

**Condición adicional:** sin huellas de origen y destino, CE-3 no puede superar 20/45.

**Descuento:** −20 puntos si el repositorio o el entregable contienen un secreto real.

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
3. **Producto:** completar el entregable según observaciones (plazo: 5 días, sin retrasar la semana 6)

Si la nota es inferior al 60%, reunión con el instructor antes de iniciar la semana 6.

---

*Cadena de Formación · Implantación del Software · Semana 5 de 9 + 1 opcional*
