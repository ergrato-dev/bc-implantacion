# Práctica 02 — Simulacro Cruzado con la App de Referencia

<!-- 📝 Instrucción: ensayo general del gate, en grupos de dos equipos + observador. El equipo A
entrega, el equipo B instala en su propio equipo, el observador (instructor o un tercer equipo)
registra. Después se intercambian. Tiempo máximo por intento: 60 minutos. -->

## Objetivo

Instalar la app de referencia desde cero y restaurar sus datos siguiendo **solo** su Plan de
Implantación, y registrar cada desviación del plan.

## Duración estimada

180 minutos (dos intentos de 60 minutos más preparación y cierre).

## Documento que se sigue

[`referencia/docs/plan-implantacion.md`](../../../../referencia/docs/plan-implantacion.md),
secciones 5 (instalación) y 3.3 (restauración).

## 1. Equipo A: preparar la entrega

En el laboratorio, con la "producción" arriba (práctica 01):

1. Registra en la app, desde el navegador, tres libros propios (datos inventados).
2. Genera el paquete:

   ```bash
   cd ../laboratorio
   bash preparar-entrega.sh
   ```

3. Lee [`preparar-entrega.sh`](../laboratorio/preparar-entrega.sh): ¿qué contiene `entrega/`? ¿Qué
   **no** contiene?
4. Entrega al equipo B:
   - la carpeta `entrega/` por SFTP o `rsync` sobre SSH (semana 3), o por una carpeta compartida
     del aula;
   - la contraseña de restic **por otro canal** (en persona o en un papel que luego se destruye).

## 2. Observador: preparar el registro

Copia [`registro-del-simulacro.md`](../../3-proyecto/starter/registro-del-simulacro.md) y anota
la hora de inicio. Durante el intento, el observador **no ayuda**: registra.

## 3. Equipo B: instalar y restaurar

Reglas (teoría 02): solo el plan, servidor limpio, cada pregunta es una desviación.

Servidor limpio en tu equipo: una carpeta nueva y ningún contenedor ni volumen del proyecto
`biblioteca`. Compruébalo antes de empezar:

```bash
docker ps -a --filter name=biblioteca
docker volume ls --filter name=biblioteca
```

En la sección 5.2 del plan usa:

```bash
DESTINO=~/simulacro/biblioteca
FUENTE=~/bc-implantacion/referencia      # ajusta la ruta a tu copia del bootcamp
ENTREGA=~/simulacro/entrega               # donde quedó la carpeta que te entregaron
```

Sigue el plan desde la sección 5.3. En la 5.6 elige "con datos de un respaldo".

Lo que se debe lograr (teoría 02, sección 4):

- [ ] Instalación completa, servicios sanos
- [ ] `HUELLAS IDÉNTICAS`
- [ ] Prueba de humo en verde con la versión de `entrega/version.txt`
- [ ] Los tres libros del equipo A aparecen en el catálogo
- [ ] Dentro de los 60 minutos

## 4. Cierre del intento

El observador anota la hora de fin, el resultado de cada criterio y la lista de desviaciones,
y decide si alguna invalida el intento.

El equipo B limpia:

```bash
cd ~/simulacro/biblioteca && docker compose down -v
cd ~ && rm -rf ~/simulacro
```

## 5. Intercambio

Repite las partes 1 a 4 con los papeles invertidos. El nuevo equipo A genera un paquete nuevo
(borra antes `entrega/`).

## 6. Mejorar el plan

Con los dos registros, propón cambios concretos al plan de la app de referencia: texto actual,
texto propuesto y la desviación que lo motiva.

| Sección | Texto actual | Texto propuesto | Desviación |
|---|---|---|---|
| | | | |

- [ ] ¿Qué supuestos del plan no se cumplían en tu equipo (puertos, espacio, herramientas)?
- [ ] ¿Cuánto tardó la restauración comparada con el RTO de 4 h? ¿Qué pasaría con una base de
      10 GB?

## ✅ Checklist

- [ ] Paquete de entrega preparado y contraseña entregada por otro canal
- [ ] Instalación y restauración con huellas idénticas y prueba de humo en verde
- [ ] Registro del simulacro completo y firmado por el observador, en ambos papeles
- [ ] Propuestas de mejora al plan basadas en desviaciones

Teoría relacionada: [`02-simulacro-cruzado.md`](../../1-teoria/02-simulacro-cruzado.md).
