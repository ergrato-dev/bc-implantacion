# 📊 Rúbrica de Evaluación — Semana 10

> **Semana 10**: (Opcional) IaC y Automatización
> **Criterios RAP evaluados**: CE-1, CE-5

---

## Distribución de la Evaluación

| Tipo de Evidencia | Porcentaje | Instrumento |
|-------------------|-----------|-------------|
| 🧠 Conocimiento | 30% | Cuestionario de conceptos clave |
| 💪 Desempeño | 40% | Prácticas `2-practicas/01` a `03` |
| 📦 Producto | 30% | Plan de instalación ejecutable (playbook) del proyecto real |

**Nota mínima de aprobación por tipo: 70%**

---

## 🧠 Evidencia de Conocimiento (30%)

**Instrumento:** Cuestionario de 10 preguntas

1. ¿Qué diferencia hay entre un enfoque imperativo y uno declarativo? Da un ejemplo de cada uno.
2. ¿Qué es la idempotencia y cómo se comprueba en un playbook?
3. ¿Qué es la deriva y por qué con IaC nadie debe cambiar el servidor a mano?
4. ¿Qué hace cloud-init y por qué se limita a lo mínimo del primer arranque?
5. ¿Qué necesita un servidor para que Ansible lo administre? ¿Qué es el inventario?
6. ¿Por qué copiar un archivo y luego editarlo rompe la idempotencia? ¿Cómo se corrige?
7. ¿Para qué sirven los *handlers*? ¿Cuándo se ejecutan?
8. ¿Qué cifra Ansible Vault y qué se puede subir al repositorio?
9. En un plan de OpenTofu, ¿qué diferencia hay entre `~` y `-/+`? ¿Por qué el segundo es riesgoso para una base de datos?
10. ¿Por qué el archivo de estado de OpenTofu no se sube al repositorio? ¿Qué hace `prevent_destroy`?

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
| **cloud-init** (práctica 01) | Errores provocados y analizados, tres adaptaciones validadas; comprobado en VM real si la hubo | Adaptaciones sin analizar errores | Solo valida el ejemplo | No ejecuta |
| **Ansible** (práctica 02) | Instalación con Vault, `changed=0` demostrado, deriva corregida, versión actualizada y tres extensiones idempotentes | Sin extensiones | Instalación sin comprobar idempotencia | No ejecuta |
| **OpenTofu** (práctica 03) | Ciclo completo, estado y deriva analizados, cambio peligroso leído en el plan, `prevent_destroy` probado | Sin el cambio peligroso | Solo `apply` y `destroy` | No ejecuta |

**Fórmula:** promedio de los 3 criterios (peso igual).

---

## 📦 Evidencia de Producto (30%)

**Instrumento:** playbook en el repositorio del proyecto real + subsección 5.10 del Plan de
Implantación (`entregable-s10-instalacion-ejecutable.md`)

| Criterio | Puntaje Máx. | Qué se evalúa |
|----------|:---:|---|
| **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado | 40 | `user-data` validado que deja el servidor alcanzable y endurecido (15); el playbook prepara la plataforma: paquetes, Docker, usuarios y grupos, firewall, permisos de carpetas y archivos (25) |
| **CE-5** — Elabora el plan de instalación de acuerdo con las características del software a implantar | 60 | El playbook instala el proyecto en un servidor limpio y termina con la prueba de humo en verde (25); segunda ejecución con `changed=0`, con evidencia (15); secretos en Vault o variables de entorno, ninguno en texto plano (10); sección 5 del plan actualizada: cómo ejecutar, variables, qué queda manual (10) |

**Total:** 100 puntos

**Condición adicional:** sin evidencia de una ejecución completa sobre un servidor limpio, CE-5 no
puede superar 30/60.

**Descuento:** −20 puntos si el repositorio contiene un secreto en texto plano, una llave privada,
la contraseña del vault o un archivo de estado de OpenTofu.

---

## 📈 Nota Final de la Semana

```
Nota = (Conocimiento × 0.30) + (Desempeño × 0.40) + (Producto × 0.30)
```

---

## 🔄 Criterios de Recuperación

Semana opcional: no afecta la aprobación del bootcamp. Si se entrega y alguna evidencia está
entre 60% y 69%, se puede completar según observaciones en el plazo que acuerde el instructor.

---

*Cadena de Formación · Implantación del Software · Semana 10 de opcional*
