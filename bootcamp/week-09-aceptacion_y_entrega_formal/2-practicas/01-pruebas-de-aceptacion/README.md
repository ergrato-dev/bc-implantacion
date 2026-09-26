# Práctica 01 — Pruebas de Aceptación

<!-- 📝 Instrucción: práctica en equipos. La mitad del equipo hace de "cliente" (la Biblioteca
Municipal, datos sintéticos) y la otra mitad de equipo de implantación. El cliente ejecuta los
casos; el equipo acompaña sin tocar el teclado. -->

## Objetivo

Convertir requisitos en casos de aceptación, acordar los criterios de salida antes de probar,
ejecutar los casos con el "cliente" y tomar una decisión documentada.

## Duración estimada

120 minutos.

## Preparación

```bash
cd ../laboratorio
cp .env.example .env
docker compose up -d --build --wait
```

La app queda en <http://localhost:8000>. Es la "producción" que el cliente va a aceptar.

## 1. Requisitos acordados

La Biblioteca Municipal (cliente sintético) firmó estos requisitos al inicio del proyecto:

| ID | Requisito |
|---|---|
| RQ-01 | Los bibliotecarios consultan el catálogo completo desde el navegador, sin instalar nada |
| RQ-02 | Se registran libros con ISBN, título, autor y año de publicación |
| RQ-03 | El sistema no permite registrar dos libros con el mismo ISBN y avisa al usuario |
| RQ-04 | El sistema rechaza datos inválidos (por ejemplo, un año imposible) indicando el problema |
| RQ-05 | Se puede buscar un libro por autor |
| RQ-06 | La aplicación informa su versión, para los reportes de soporte |
| RQ-07 | La información se respalda diariamente y se puede recuperar en menos de 4 horas |

## 2. Casos de aceptación

Escribe al menos un caso por requisito, en formato *Dado / Cuando / Entonces* (teoría 01):

| ID | Requisito | Dado | Cuando | Entonces |
|---|---|---|---|---|
| CA-01 | RQ-01 | | | |
| CA-02 | RQ-02 | | | |
| … | | | | |

- [ ] ¿Qué evidencia usarás para RQ-07, que no se puede probar desde la pantalla?

## 3. Criterios de salida

**Antes** de ejecutar, el equipo y el cliente acuerdan y firman los criterios de salida:

| Criterio | Valor acordado |
|---|---|
| Casos ejecutados | |
| Defectos bloqueantes abiertos | |
| Defectos mayores abiertos | |
| Tratamiento de defectos menores | |

## 4. Ejecución

El cliente ejecuta cada caso en el navegador; el equipo registra:

| Caso | Resultado (pasa / falla) | Evidencia | Defecto (ID y severidad) |
|---|---|---|---|
| CA-01 | | | |

Para cada defecto:

| ID | Caso | Descripción | Severidad | Pasos para reproducir |
|---|---|---|---|---|
| D-01 | | | | |

- [ ] ¿Algún requisito no está implementado? ¿Es un defecto o un requisito que quedó fuera del
      alcance? ¿Qué dice el documento de requisitos?
- [ ] Para RQ-04: prueba con el año `3000` y con el año vacío. ¿El mensaje indica **cuál** es el
      problema?

## 5. Decisión

Con los criterios de la parte 3, decide: aceptado, aceptado con observaciones o rechazado.

| Campo | Valor |
|---|---|
| Decisión | |
| Justificación (criterio por criterio) | |
| Defectos que pasan al acta con fecha de corrección | |
| Fecha y firmas (roles) | |

- [ ] Si el cliente insiste en que RQ-05 es imprescindible, ¿qué opciones hay? ¿Cuál cambia el
      alcance y cuál la fecha?

## ✅ Checklist

- [ ] Casos de aceptación para los siete requisitos
- [ ] Criterios de salida firmados antes de ejecutar
- [ ] Resultados con evidencia y defectos clasificados por severidad
- [ ] Decisión justificada con los criterios

Teoría relacionada: [`01-pruebas-de-aceptacion.md`](../../1-teoria/01-pruebas-de-aceptacion.md).
