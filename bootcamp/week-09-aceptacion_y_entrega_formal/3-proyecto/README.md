# Proyecto Semana 9 — Plan de Implantación Consolidado y Gate

## 📋 Instrucciones

Esta semana se cierra el Producto del bootcamp: el **Plan de Implantación del proyecto real**,
consolidado, validado por otro equipo en un simulacro cruzado y acompañado del acta de entrega.

### 1. Consolidar

Reúne las secciones 1 a 9 en `docs/plan-implantacion.md` del repositorio del proyecto,
revísalas con la lista de completitud (teoría 04) y numera la versión del plan. Modelo:
[`referencia/docs/plan-implantacion.md`](../../../referencia/docs/plan-implantacion.md).

### 2. Pruebas de aceptación

Casos de aceptación a partir de los requisitos del proyecto, criterios de salida acordados antes
de ejecutar, ejecución con alguien que haga de cliente y decisión documentada.

### 3. Simulacro cruzado (gate)

| Paso | Quién | Qué |
|---|---|---|
| 1 | Instructor | Asigna qué equipo instala cada proyecto y quién observa |
| 2 | Equipo que entrega | Entrega el plan (versión), el paquete (respaldo cifrado + huella) y, por otro canal, las contraseñas |
| 3 | Equipo que instala | Instala desde cero en un servidor limpio (VM del laboratorio o equipo propio) y restaura, **solo con el plan** |
| 4 | Observador | Registra tiempos, criterios y desviaciones en [`registro-del-simulacro.md`](starter/registro-del-simulacro.md) |
| 5 | Equipo que entrega | Corrige el plan con cada desviación; si el intento se invalidó, se repite sobre la versión corregida |

Tiempo máximo: el que fije el instructor (sugerido: 90 minutos).

> **Condición de aprobación del Producto:** si el simulacro no logra instalación completa,
> huellas idénticas y prueba de humo en verde sin ayuda, el Plan de Implantación **no se
> acepta** hasta corregirlo y repetir el simulacro.

### 4. Acta de entrega

Con [`acta-de-entrega.md`](starter/acta-de-entrega.md): alcance, resultados de aceptación y del
simulacro, niveles de servicio que el equipo pueda cumplir, accesos a transferir (sin secretos),
garantía, pendientes y firmas.

### 5. Socialización

Presentación de 10 minutos con demostración en vivo (teoría 04) y lecciones aprendidas del equipo.

Todo se resume en la sección 10 del plan con
[`entregable-s09-aceptacion-y-entrega.md`](starter/entregable-s09-aceptacion-y-entrega.md).

## ❓ Preguntas Guía

- ¿Otra persona podría instalar tu proyecto mañana si tu equipo no estuviera?
- ¿Qué paso de tu plan depende de algo que solo sabe una persona del equipo?
- ¿Qué niveles de servicio puedes firmar con las personas y los planes gratuitos que tienes?

## ✅ Checklist de Cierre

- [ ] Plan consolidado y versionado, revisado con la lista de completitud
- [ ] Pruebas de aceptación con decisión documentada
- [ ] Simulacro cruzado superado: instalación, huellas idénticas, prueba de humo, dentro del tiempo
- [ ] Plan corregido con las desviaciones del simulacro
- [ ] Acta de entrega sin secretos, con niveles de servicio cumplibles
- [ ] Socialización hecha y lecciones aprendidas registradas
