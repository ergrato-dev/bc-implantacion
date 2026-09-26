# Práctica 03 — Soporte, Runbooks y Análisis de Incidentes

<!-- 📝 Instrucción: práctica en equipos de 4: dos personas hacen de mesa de ayuda (N1) y dos de
soporte técnico (N2); en la parte 4 se intercambian. Todos los reportes son sintéticos. -->

## Objetivo

Recibir reportes por un canal único, clasificarlos con la matriz de prioridad, escalarlos con la
información completa y atender un incidente siguiendo un runbook escrito por otro equipo.

## Duración estimada

120 minutos.

## 1. Canal de reporte

Copia los formularios de la app de referencia a tu repositorio y súbelos por *pull request*:

```bash
cd ~/biblioteca
cp -r ~/bc-implantacion/referencia/.github/ISSUE_TEMPLATE .github/     # ajusta la ruta
```

Lee [`reporte-de-falla.yml`](../../../../referencia/.github/ISSUE_TEMPLATE/reporte-de-falla.yml).
En GitHub, **Issues → New issue**: ¿qué opciones aparecen? ¿Se puede abrir un issue en blanco?

- [ ] ¿Por qué el formulario pide la versión? ¿Y por qué advierte sobre contraseñas y datos
      personales?

## 2. Clasificar

La mesa de ayuda recibe estos reportes. Clasifícalos con la matriz de prioridad (teoría 03):

| # | Reporte (palabras del usuario) | ¿Incidente o solicitud? | Impacto | Urgencia | Prioridad | Nivel que lo resuelve |
|---|---|---|---|---|---|---|
| 1 | "No abre la página, sale un error 502, a ninguno de la sala nos funciona" | | | | | |
| 2 | "¿Cómo busco un libro por autor?" | | | | | |
| 3 | "Cuando guardo un libro a veces solo dice 'Datos inválidos' y no sé qué campo está mal" | | | | | |
| 4 | "Necesitamos que el sistema guarde también la editorial" | | | | | |
| 5 | "Registré un libro con el año mal, ¿lo pueden corregir?" | | | | | |
| 6 | "Desde ayer no puedo guardar libros nuevos, dice error del servidor, los de antes sí se ven" | | | | | |
| 7 | "La página se demora como 40 segundos en abrir por la mañana, después ya va rápido" | | | | | |
| 8 | "Un compañero que ya no trabaja aquí todavía entra al servidor" | | | | | |

- [ ] ¿Cuál es el reporte 7 en realidad? (Pista: semana 4, plan gratuito de Render.)
- [ ] ¿Por qué el 8 no es un problema de la app, pero sí es P1 o P2?

Registra los reportes 1, 3 y 6 como issues con el formulario, completando lo que un usuario real
habría escrito. Ponles una etiqueta de prioridad (`P1`…`P4`).

## 3. Escalar con información completa

Para el reporte 6, la mesa de ayuda escala a N2. Escribe el comentario de escalamiento:

| Dato | Valor |
|---|---|
| Qué reporta el usuario | |
| Desde cuándo | |
| A cuántos afecta | |
| Qué verificó N1 (y resultado) | |
| Versión en producción | |
| Prioridad y por qué | |

- [ ] Un N2 que lea solo ese comentario, ¿puede empezar sin volver a preguntar?

## 4. Runbook

Cada equipo escribe en `~/biblioteca/docs/runbooks/salud-en-rojo.md` el runbook para la alerta
"Biblioteca — salud" de Uptime Kuma (semana 7), con las secciones de la teoría 03: síntoma,
verificación, acciones en orden con el resultado esperado, escalamiento y cierre. Debe cubrir al
menos: la app detenida, la base detenida y una versión recién desplegada que falla.

Prueba el runbook de **otro** equipo sobre el laboratorio de la semana 7:

```bash
cd ../../../week-07-cicd_de_despliegue_y_monitoreo/2-practicas/laboratorio
cp .env.example .env && docker compose up -d --wait registro db kuma alertas
docker build -q --build-arg APP_VERSION=1.0.0 -t localhost:5000/biblioteca:1.0.0 ../../../../referencia \
  && docker push -q localhost:5000/biblioteca:1.0.0
docker compose up -d --wait app
```

Una persona provoca en secreto uno de los fallos (`docker compose stop app` o
`docker compose stop db`); la otra lo resuelve **solo** con el runbook y anota dónde dudó.

- [ ] ¿Qué paso del runbook fue ambiguo? Devuélvele la observación al equipo autor.
- [ ] ¿Cuánto tardó desde "la alerta está en rojo" hasta "resuelto y verificado"?

Al terminar: `docker compose down -v`.

## 5. Análisis posterior al incidente

Escribe en `~/biblioteca/docs/incidentes/` el análisis sin culpables de la regresión de la semana
7 (la versión que devolvía `200` en lugar de `201`), como si hubiera llegado a producción:

| Sección | Contenido |
|---|---|
| Resumen | Qué pasó, impacto, duración |
| Línea de tiempo | Hora y evento, desde el despliegue hasta la resolución |
| Causa | Técnica y del proceso: ¿por qué no se detuvo antes? |
| Qué funcionó | |
| Qué no funcionó | |
| Acciones | Qué, responsable, fecha |

- [ ] ¿Alguna acción apunta a una persona en lugar de al proceso? Reescríbela.

## ✅ Checklist

- [ ] Formulario de reporte en el repositorio, sin issues en blanco
- [ ] Ocho reportes clasificados; tres registrados como issues con prioridad
- [ ] Escalamiento con la información completa
- [ ] Runbook propio escrito y runbook de otro equipo probado, con observaciones
- [ ] Análisis posterior al incidente sin culpables

Teoría relacionada: [`03-soporte-por-niveles.md`](../../1-teoria/03-soporte-por-niveles.md).
