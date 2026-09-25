# 📊 Rúbrica de Evaluación — Semana 01

> **Semana 01**: Plataforma Tecnológica y Hardware
> **Criterios RAP evaluados**: CE-1, CE-2

---

## Distribución de la Evaluación

| Tipo de Evidencia | Porcentaje | Instrumento |
|-------------------|-----------|-------------|
| 🧠 Conocimiento | 30% | Cuestionario de conceptos clave |
| 💪 Desempeño | 40% | Prácticas `2-practicas/01-inspeccion-de-servidor-linux/` y `02-script-verificacion-requisitos/` |
| 📦 Producto | 30% | Ficha técnica y matriz de requisitos mínimos del proyecto real |

**Nota mínima de aprobación por tipo: 70%**

---

## 🧠 Evidencia de Conocimiento (30%)

**Instrumento:** Cuestionario de 10 preguntas

1. ¿Qué componentes hacen que un servidor tolere fallas sin detener el servicio?
2. ¿En qué escenario recomendarías un servidor torre, uno rack y uno blade?
3. Con 6 discos de 4 TB, ¿cuál es la capacidad útil en RAID 5, RAID 6 y RAID 10?
4. ¿Por qué RAID no reemplaza un plan de respaldo? Da dos ejemplos.
5. ¿Qué diferencia hay entre requisito mínimo y requisito recomendado?
6. ¿Por qué se agrega un margen al consumo medido? ¿De cuánto?
7. ¿Qué diferencia hay entre una licencia permisiva y una copyleft? Da un ejemplo de cada una.
8. ¿Qué diferencia hay entre un hipervisor tipo 1 y uno tipo 2?
9. ¿Por qué un contenedor ve la RAM del anfitrión y una VM no?
10. ¿Por qué se instala una versión LTS en producción y qué dato de ella va al plan de implantación?

### Criterios de Calificación

| Puntaje | Desempeño |
|---------|-----------|
| 9-10 correctas | Excelente |
| 7-8 correctas | Bueno |
| 5-6 correctas | Aceptable — requiere repaso |
| < 5 correctas | Insuficiente — revisar toda la teoría de la semana |

---

## 💪 Evidencia de Desempeño (40%)

**Instrumento:** prácticas 01 y 02 sobre la app de referencia

| Criterio | Excelente (100%) | Bueno (80%) | Aceptable (60%) | Insuficiente (<60%) |
|----------|-----------------|-------------|-----------------|---------------------|
| **Inventario del servidor** (práctica 01) | Tabla completa, comando correcto por fila, tipo de plataforma identificado y justificado | Tabla completa, plataforma sin justificar | Tabla con 1-2 campos vacíos | 3+ campos vacíos |
| **Análisis VM vs contenedor** (práctica 01) | Explica con sus palabras por qué el contenedor ve los recursos del anfitrión y cómo limitarlos | Explicación correcta sin mencionar límites | Explicación parcial | Sin respuesta o incorrecta |
| **Ejecución e interpretación del script** (práctica 02) | Ejecuta, explica cada fila y el código de salida | Ejecuta y explica la mayoría | Ejecuta sin explicar | No lo ejecuta |
| **Pruebas de fallo** (práctica 02) | 3+ fallos distintos provocados y detectados | 2 fallos | 1 fallo | Ninguno |
| **Adaptación al proyecto real** (práctica 02) | Umbrales ajustados + chequeo propio que funciona | Umbrales ajustados | Script copiado sin cambios | No adaptado |

**Fórmula:** promedio de los 5 criterios (peso igual).

---

## 📦 Evidencia de Producto (30%)

**Instrumento:** sección 1 del Plan de Implantación (`entregable-s01-ficha-tecnica.md`) +
`scripts/verificar-requisitos.sh` en el repositorio del proyecto real

| Criterio | Puntaje Máx. | Qué se evalúa |
|----------|:---:|---|
| **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado | 40 | Sistema operativo justificado (versión, arquitectura, fin de soporte, licencia, requisitos oficiales enlazados); inventario de software con versión y licencia; plataforma física, nivel RAID y plataforma de ejecución justificados |
| **CE-2** — Verifica el cumplimiento de las características mínimas de hardware requeridas para el software desarrollado | 60 | Consumo medido (no estimado a ojo); matriz con mínimos y recomendados y margen calculado; script adaptado ejecutado en un servidor Linux con la salida pegada en la ficha |

**Total:** 100 puntos

**Condición adicional:** si la matriz de requisitos no está respaldada por una medición real y
por la salida del script, CE-2 no puede superar 30/60.

**Descuento:** −10 puntos si la ficha contiene IPs, nombres de host, usuarios o contraseñas
reales.

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
3. **Producto:** completar la ficha técnica según observaciones (plazo: 5 días, sin retrasar la semana 2)

Si la nota es inferior al 60%, reunión con el instructor antes de iniciar la semana 2.

---

*Cadena de Formación · Implantación del Software · Semana 1 de 9 + 1 opcional*
