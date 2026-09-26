# 📊 Rúbrica de Evaluación — Semana 06

> **Semana 06**: Seguridad, Usuarios y Permisos
> **Criterios RAP evaluados**: CE-1, CE-4

---

## Distribución de la Evaluación

| Tipo de Evidencia | Porcentaje | Instrumento |
|-------------------|-----------|-------------|
| 🧠 Conocimiento | 30% | Cuestionario de conceptos clave |
| 💪 Desempeño | 40% | Prácticas `2-practicas/01`, `02` y `03` sobre el laboratorio |
| 📦 Producto | 30% | Matriz de usuarios/roles + plan de respaldo final del proyecto real |

**Nota mínima de aprobación por tipo: 70%**

---

## 🧠 Evidencia de Conocimiento (30%)

**Instrumento:** Cuestionario de 10 preguntas

1. ¿Qué es el principio de mínimo privilegio? Da un ejemplo en el sistema operativo y otro en la base de datos.
2. ¿Qué significan los permisos `2770` en una carpeta y `640` en un archivo?
3. ¿Por qué pertenecer al grupo `docker` o poder ejecutar `docker` con `sudo` equivale a ser `root`?
4. ¿Qué ventajas tiene la llave SSH frente a la contraseña? ¿Qué protege la frase de paso?
5. ¿Por qué se deja una sesión SSH abierta al cambiar la configuración de `sshd`?
6. ¿Por qué un puerto publicado por Docker puede quedar abierto aunque UFW lo niegue? ¿Cómo se evita?
7. ¿Qué puede hacer una app conectada como superusuario de PostgreSQL que no debería? ¿Para qué sirve `ALTER DEFAULT PRIVILEGES`?
8. ¿Qué pasos se siguen cuando un secreto llega a un repositorio público? ¿Por qué rotar va primero?
9. ¿Qué aporta restic frente a guardar archivos `.dump`? ¿Qué pasa si se pierde su contraseña?
10. ¿Qué protege un repositorio de respaldo solo-agregar? ¿Qué falta en un volcado de `pg_dump` para restaurar en un servidor nuevo?

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
| **Usuarios y sudo** (práctica 01) | Cuentas por persona, carpeta con setgid, `sudo` limitado y comando prohibido demostrado; riesgo del grupo `docker` explicado | Todo configurado sin demostrar lo prohibido | Solo crea las cuentas | No ejecuta |
| **SSH y firewall** (práctica 01) | Entrada con llave, contraseña rechazada con evidencia, UFW con puerto bloqueado y permitido, riesgo de Docker frente a UFW explicado | Sin la evidencia de UFW | Solo configura la llave | No ejecuta |
| **Roles de base de datos** (práctica 02) | App con su rol, tabla de pruebas negativas completa, migración con el dueño y rol de lectura propio probado | Sin rol de lectura propio | App con su rol sin pruebas negativas | No ejecuta |
| **Secretos** (práctica 02) | Contraseña rotada, la vieja rechazada por la red, `trust` de `pg_hba.conf` explicado e inventario completo | Rotación sin inventario | Solo rota | No ejecuta |
| **Respaldo y restauración** (práctica 03) | Cron, retención, borrado rechazado en el externo y restauración de desastre por otra persona con huellas iguales y tiempo medido | Restauración por quien configuró el respaldo | Respaldo cifrado sin restauración | No ejecuta |

**Fórmula:** promedio de los 5 criterios (peso igual).

---

## 📦 Evidencia de Producto (30%)

**Instrumento:** sección 7 y sección 3 (versión final) del Plan de Implantación
(`entregable-s06-seguridad-y-respaldo.md`) + cambios en el servidor y el repositorio del proyecto real

| Criterio | Puntaje Máx. | Qué se evalúa |
|----------|:---:|---|
| **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado | 55 | Matriz de usuarios del sistema operativo con grupos, permisos de archivos sensibles y `sudo` limitado (15); SSH solo con llave y firewall con puertos justificados y base no expuesta (15); roles de la base con mínimo privilegio, migraciones con el dueño y pruebas negativas (15); inventario de secretos con ubicación, permisos y rotación (10) |
| **CE-4** — Diseña el plan de respaldo de los datos para mitigar riesgos | 45 | Respaldo automático y cifrado con usuario y rol de solo lectura, retención y verificación (15); regla 3-2-1 con copia fuera del sitio y contraseña guardada fuera del servidor (10); procedimiento de restauración de desastre claro y completo, incluidos los roles (10); restauración probada por otra persona, con huellas y tiempo comparado con el RTO (10) |

**Total:** 100 puntos

**Condición adicional:** sin restauración probada con huellas, CE-4 no puede superar 20/45.

**Descuento:** −20 puntos si el repositorio, el historial o el entregable contienen un secreto
real sin rotar.

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
3. **Producto:** completar el entregable según observaciones (plazo: 5 días, sin retrasar la semana 7)

Si la nota es inferior al 60%, reunión con el instructor antes de iniciar la semana 7.

---

*Cadena de Formación · Implantación del Software · Semana 6 de 9 + 1 opcional*
