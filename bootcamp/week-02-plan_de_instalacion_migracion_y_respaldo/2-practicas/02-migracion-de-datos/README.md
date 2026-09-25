# Práctica 02 — Migración de Datos desde un Sistema Legado

<!-- 📝 Instrucción: práctica en equipo. Antes de ejecutar cualquier SQL, el equipo llena la
tabla de mapeo de la sección 2 revisando el CSV a mano. -->

## Objetivo

Migrar los clientes de un sistema viejo (exportados a CSV) a la tabla `socios` del sistema
nuevo, aplicando un plan: respaldo previo, staging, mapeo, reglas de rechazo, validación y
rollback.

## Duración estimada

180 minutos.

## Escenario

La biblioteca reemplaza su sistema anterior. El sistema viejo exportó sus clientes en
[`clientes_legado.csv`](../laboratorio/datos-legados/clientes_legado.csv) (20 filas, separador `;`).
El sistema nuevo ya tiene 200 socios que **no** se pueden alterar.

## 1. Respaldo antes de migrar

```bash
cd ../laboratorio
docker compose up -d --wait
bash ../01-respaldo-y-restauracion/respaldar.sh
```

Ninguna migración empieza sin un respaldo verificado: es el rollback real.

## 2. Análisis y mapeo (sin ejecutar nada)

Abre el CSV y completa la tabla:

| Columna origen | Columna destino | Transformación | Problemas encontrados |
|---|---|---|---|
| `codigo` | `documento` | | |
| `nombre_completo` | `nombre` | | |
| `correo` | `email` | | |
| `fecha_alta` | `fecha_registro` | | |
| `telefono` | — | | |

Busca: espacios sobrantes, mayúsculas inconsistentes, campos vacíos, fechas imposibles,
duplicados y emails que ya existen en el destino.

## 3. Ejecutar la migración

Los scripts están en [`sql/`](sql/). Cada uno se ejecuta desde `laboratorio/`. La función `sql`
funciona en bash y zsh y vale para toda la sesión de terminal:

```bash
sql() { docker compose exec -T db psql -U biblioteca -d biblioteca -v ON_ERROR_STOP=1 "$@"; }
sql < ../02-migracion-de-datos/sql/01-cargar-staging.sql
sql < ../02-migracion-de-datos/sql/02-transformar.sql
```

| Script | Qué hace |
|---|---|
| `01-cargar-staging.sql` | Carga el CSV tal cual, todo como texto, en el esquema `migracion` |
| `02-transformar.sql` | Normaliza, registra rechazos con motivo y carga lo válido — en una sola transacción |
| `03-validar.sql` | Conciliación de conteos, checksum, reglas de negocio, datos previos intactos |
| `04-rollback.sql` | Elimina solo lo que agregó la migración |

Compara las reglas de rechazo de `02-transformar.sql` con los problemas que encontraste en el
paso 2. ¿Se te escapó alguno? ¿El script omite alguno que tú detectaste?

## 4. Validar

```bash
sql < ../02-migracion-de-datos/sql/03-validar.sql
```

Las cuatro validaciones deben decir `OK`. Resultado esperado de la conciliación:

| origen | migrados | rechazados |
|:---:|:---:|:---:|
| 20 | 16 | 4 |

Revisa los rechazos:

```bash
sql -c "SELECT * FROM migracion.rechazos ORDER BY documento;"
```

## 5. Provocar un error y detectarlo

Ejecuta **otra vez** `01` y `02` sin hacer rollback, y luego `03`. ¿Qué dicen las validaciones?
¿Se duplicaron socios? Explica por qué el resultado es seguro pero la validación falla.

## 6. Rollback

```bash
sql < ../02-migracion-de-datos/sql/04-rollback.sql
```

Debe quedar en 200 socios. Luego repite la migración completa (pasos 3 y 4) desde cero.

## 7. Limpieza

```bash
docker compose down -v
```

## ✅ Checklist

- [ ] Respaldo verificado antes de migrar
- [ ] Tabla de mapeo completa, hecha antes de leer los scripts
- [ ] Migración ejecutada con las 4 validaciones en `OK`
- [ ] Doble ejecución probada y explicada
- [ ] Rollback ejecutado y migración repetida desde cero

Teoría relacionada: [`01-migracion-de-datos.md`](../../1-teoria/01-migracion-de-datos.md),
[`02-plan-de-migracion.md`](../../1-teoria/02-plan-de-migracion.md).
