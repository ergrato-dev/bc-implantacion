# 📊 Rúbrica de Evaluación — Semana 02

> **Semana 02**: Plan de Instalación, Migración y Respaldo
> **Criterios RAP evaluados**: CE-3, CE-4, CE-5

---

## Distribución de la Evaluación

| Tipo de Evidencia | Porcentaje | Instrumento |
|-------------------|-----------|-------------|
| 🧠 Conocimiento | 30% | Cuestionario de conceptos clave |
| 💪 Desempeño | 40% | Prácticas `2-practicas/01-respaldo-y-restauracion/` y `02-migracion-de-datos/` |
| 📦 Producto | 30% | Plan de migración + plan de respaldo v0 + plan de instalación v0 del proyecto real |

**Nota mínima de aprobación por tipo: 70%**

---

## 🧠 Evidencia de Conocimiento (30%)

**Instrumento:** Cuestionario de 10 preguntas

1. ¿Qué diferencia hay entre una migración big bang y una por fases? ¿Cuándo usarías cada una?
2. ¿Para qué sirve una tabla de staging y por qué sus columnas son de tipo texto?
3. ¿Qué es la conciliación de conteos y qué problema detecta que un checksum no?
4. ¿Quién debe aprobar las reglas de rechazo de una migración y por qué?
5. Si hay un respaldo completo el domingo e incrementales de lunes a miércoles, ¿qué necesitas para restaurar el miércoles? ¿Y si fueran diferenciales?
6. Define RPO y RTO con un ejemplo. ¿Qué acción reduce cada uno?
7. Explica la regla 3-2-1 con un ejemplo concreto de ubicaciones.
8. ¿Por qué un respaldo que nunca se ha restaurado no cuenta como respaldo?
9. ¿Qué riesgo tiene restaurar una sola tabla con `pg_restore -t`?
10. ¿Qué tres elementos debe tener cada paso de un plan de instalación?

### Criterios de Calificación

| Puntaje | Desempeño |
|---------|-----------|
| 9-10 correctas | Excelente |
| 7-8 correctas | Bueno |
| 5-6 correctas | Aceptable — requiere repaso |
| < 5 correctas | Insuficiente — revisar toda la teoría de la semana |

---

## 💪 Evidencia de Desempeño (40%)

**Instrumento:** prácticas 01 y 02 sobre el laboratorio de la biblioteca

| Criterio | Excelente (100%) | Bueno (80%) | Aceptable (60%) | Insuficiente (<60%) |
|----------|-----------------|-------------|-----------------|---------------------|
| **Respaldo y retención** (práctica 01) | Respaldo manual y con script; explica la retención en el código | Ambos respaldos, retención sin explicar | Solo respaldo manual | Sin respaldo |
| **Prueba de restauración** (práctica 01) | Restaura en base aparte, conteos idénticos, tiempo medido | Restaura y compara sin medir tiempo | Restaura sin comparar | No restaura |
| **Simulacro de desastre** (práctica 01) | Recupera con restricciones intactas y explica la trampa de `-t` | Recupera sin explicar la trampa | Recupera solo los datos | No recupera |
| **Mapeo y migración** (práctica 02) | Mapeo propio previo con los 6 tipos de problema detectados; 4 validaciones en `OK` | Mapeo con 4-5 tipos de problema; validaciones en `OK` | Migración ejecutada sin mapeo propio | No ejecuta |
| **Error provocado y rollback** (práctica 02) | Explica por qué la doble ejecución no duplica pero la validación falla; rollback y repetición exitosos | Rollback exitoso, explicación parcial | Solo rollback | Ninguno |

**Fórmula:** promedio de los 5 criterios (peso igual).

---

## 📦 Evidencia de Producto (30%)

**Instrumento:** secciones 2, 3 y 5 del Plan de Implantación (`entregable-s02-planes.md`) +
`scripts/respaldar.sh` en el repositorio del proyecto real

| Criterio | Puntaje Máx. | Qué se evalúa |
|----------|:---:|---|
| **CE-3** — Diseña el plan de migración de datos de acuerdo con las condiciones de implementación | 35 | Origen real identificado; objetivo medible; estrategia justificada; tabla de mapeo completa con reglas de rechazo; validaciones objetivas; rollback con criterio y responsable; matriz de riesgos |
| **CE-4** — Diseña el plan de respaldo de los datos para mitigar riesgos | 35 | Inventario de qué se respalda (no solo la base); RPO/RTO justificados; política con 3-2-1, retención y cifrado; procedimiento de restauración de 8 pasos con comandos; evidencia de restauración real; calendario de pruebas |
| **CE-5** — Elabora el plan de instalación de acuerdo con las características del software a implantar | 30 | Las 10 secciones presentes, ninguna vacía; pasos con acción, comando y resultado esperado; prerrequisitos enlazados a la ficha técnica; cronograma con punto de no retorno |

**Total:** 100 puntos

**Condición adicional:** sin evidencia de una restauración real de la base del proyecto
(conteos antes y después), CE-4 no puede superar 15/35.

**Descuento:** −10 puntos si el entregable contiene IPs, nombres de host, usuarios o
contraseñas reales.

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
3. **Producto:** completar los planes según observaciones (plazo: 5 días, sin retrasar la semana 3)

Si la nota es inferior al 60%, reunión con el instructor antes de iniciar la semana 3.

---

*Cadena de Formación · Implantación del Software · Semana 2 de 9 + 1 opcional*
