# 📊 Rúbrica de Evaluación — Semana 07

> **Semana 07**: CI/CD de Despliegue y Monitoreo
> **Criterios RAP evaluados**: CE-1, CE-5

---

## Distribución de la Evaluación

| Tipo de Evidencia | Porcentaje | Instrumento |
|-------------------|-----------|-------------|
| 🧠 Conocimiento | 30% | Cuestionario de conceptos clave |
| 💪 Desempeño | 40% | Prácticas `2-practicas/01` a `04` |
| 📦 Producto | 30% | Pipeline de despliegue + monitoreo del proyecto real |

**Nota mínima de aprobación por tipo: 70%**

---

## 🧠 Evidencia de Conocimiento (30%)

**Instrumento:** Cuestionario de 10 preguntas

1. ¿Qué diferencia hay entre integración continua, entrega continua y despliegue continuo?
2. ¿Por qué se prueba y se publica la misma imagen en lugar de reconstruirla para producción?
3. En un workflow de GitHub Actions, ¿qué es un job, un paso y un runner? ¿Para qué sirve `permissions`?
4. ¿Qué diferencia hay entre un secreto del repositorio y uno de un ambiente? ¿Qué aporta exigir revisores en el ambiente?
5. ¿Por qué el pipeline no publica la etiqueta `latest`?
6. ¿Qué diferencia hay entre desplegar por empuje y por arrastre? ¿Cuál sirve para una VM en una red institucional y por qué?
7. En `desplegar.sh`, ¿por qué las migraciones se aplican antes de cambiar la app? ¿Qué pasa si fallan?
8. ¿Qué significa "expandir primero, contraer después" y qué problema evita en un rollback?
9. ¿Qué detecta un monitor de palabra clave que no detecta uno HTTP? ¿Y un monitor de latido?
10. ¿Qué hace que una alerta sea útil? ¿Qué es la fatiga de alertas?

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
| **Integración continua** (práctica 01) | CI en verde, regla en `main`, regresión y fallo de construcción detenidos y explicados | Sin el fallo de construcción | CI en verde sin regla en `main` | No ejecuta |
| **Entrega continua** (práctica 02) | Versión por etiqueta publicada en GHCR, desplegada y verificada en Render con tiempo medido; rollback sin reconstruir; versión rota detenida | Sin versión rota | Solo publica en GHCR | No ejecuta |
| **Despliegue en servidor** (práctica 03) | Despliegues con `desplegar.sh`, tiempo sin servicio medido, los tres fallos detenidos y explicados, rollback manual | Dos de los tres fallos | Solo despliega | No ejecuta |
| **Monitoreo** (práctica 04) | Tres monitores, alertas y recuperación recibidas, tabla de fallos completa con evidencia en logs | Tabla incompleta | Monitores sin alertas | No ejecuta |

**Fórmula:** promedio de los 4 criterios (peso igual).

---

## 📦 Evidencia de Producto (30%)

**Instrumento:** sección 8 del Plan de Implantación (`entregable-s07-pipeline-y-monitoreo.md`) +
workflows en el repositorio del proyecto real

| Criterio | Puntaje Máx. | Qué se evalúa |
|----------|:---:|---|
| **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado | 40 | Secretos del pipeline en el ambiente `produccion` con protección (10); despliegue en el servidor con `desplegar.sh` adaptado, permisos de ejecución justificados y un fallo detenido (15); monitoreo externo con salud, versión y latido del respaldo, canal de alertas y acción por alerta (15) |
| **CE-5** — Elabora el plan de instalación de acuerdo con las características del software a implantar | 60 | CI con prueba de humo y regla en `main`, con evidencia de un rechazo (15); liberación por etiqueta que construye, prueba, publica y despliega la misma imagen (20); verificación posterior al despliegue y rollback sin reconstruir, cronometrado (15); procedimiento escrito de despliegue y rollback, con la regla de migraciones del equipo (10) |

**Total:** 100 puntos

**Condición adicional:** si la liberación no se ejecutó de verdad (sin enlace a una ejecución en
verde), CE-5 no puede superar 30/60.

**Descuento:** −20 puntos si un workflow, el repositorio o el entregable contienen un secreto real.

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
3. **Producto:** completar el entregable según observaciones (plazo: 5 días, sin retrasar la semana 8)

Si la nota es inferior al 60%, reunión con el instructor antes de iniciar la semana 8.

---

*Cadena de Formación · Implantación del Software · Semana 7 de 9 + 1 opcional*
