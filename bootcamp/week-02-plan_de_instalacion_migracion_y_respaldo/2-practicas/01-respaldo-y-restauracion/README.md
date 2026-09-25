# Práctica 01 — Respaldo y Restauración de PostgreSQL

<!-- 📝 Instrucción: práctica en parejas. El paso 4 (desastre) es obligatorio: un respaldo que
no se ha restaurado no cuenta como respaldo. -->

## Objetivo

Tomar respaldos lógicos con `pg_dump`, automatizar su retención y **demostrar** que restauran,
incluyendo la recuperación ante la pérdida de una tabla.

## Duración estimada

150 minutos.

## Preparación

```bash
cd ../laboratorio
docker compose up -d --wait
```

Todos los comandos de esta práctica se ejecutan desde `laboratorio/`.

## 1. Primer respaldo manual

```bash
docker compose exec -T db pg_dump -U biblioteca -Fc biblioteca > respaldos/manual.dump
ls -lh respaldos/
```

- `-Fc` = formato *custom*: comprimido y permite restaurar objetos sueltos.
- `-T` evita que Docker asigne una terminal: sin él, el archivo binario se corrompe.

Inspecciona qué contiene sin restaurarlo:

```bash
docker compose exec -T db pg_restore --list /respaldos/manual.dump | head -30
```

## 2. Respaldo con script: verificación y retención

El script [`respaldar.sh`](respaldar.sh) agrega lo que el comando manual no hace: nombre con fecha,
verificación de que el archivo se puede leer y **retención** (borra los más antiguos).

```bash
RETENCION=2 bash ../01-respaldo-y-restauracion/respaldar.sh
RETENCION=2 bash ../01-respaldo-y-restauracion/respaldar.sh
RETENCION=2 bash ../01-respaldo-y-restauracion/respaldar.sh
ls respaldos/
```

- [ ] ¿Cuántos respaldos con fecha quedaron? ¿Por qué?
- [ ] Ubica en el script la línea que implementa la retención.

## 3. Prueba de restauración en una base aparte

La forma segura de probar un respaldo es restaurarlo **en otra base** y comparar:

```bash
ULTIMO=$(ls -1t respaldos/biblioteca-*.dump | head -1 | xargs basename)
docker compose exec -T db createdb -U biblioteca biblioteca_verificacion
time docker compose exec -T db pg_restore -U biblioteca -d biblioteca_verificacion /respaldos/$ULTIMO
```

Compara conteos entre `biblioteca` y `biblioteca_verificacion`:

```bash
for base in biblioteca biblioteca_verificacion; do
  docker compose exec -T db psql -U biblioteca -d $base -tAc \
    "SELECT '$base', (SELECT count(*) FROM socios), (SELECT count(*) FROM libros), (SELECT count(*) FROM prestamos);"
done
```

Anota el **tiempo** que reportó `time`: es la parte técnica de tu RTO para esta base (el RTO
real suma además detectar el problema, decidir y verificar). Con 800 filas son milisegundos; con
millones de filas pueden ser horas — por eso se mide con datos de tamaño real.

## 4. Simulacro de desastre

Alguien borra una tabla por error:

```bash
docker compose exec -T db psql -U biblioteca -d biblioteca -c "DROP TABLE prestamos;"
```

Restaura la base completa desde el último respaldo:

```bash
docker compose exec -T db pg_restore -U biblioteca -d biblioteca --clean --if-exists /respaldos/$ULTIMO
```

Verifica datos **y** restricciones:

```bash
docker compose exec -T db psql -U biblioteca -d biblioteca -tAc "SELECT count(*) FROM prestamos;"
docker compose exec -T db psql -U biblioteca -d biblioteca -c "\d prestamos"
```

Debe haber 500 préstamos, llave primaria y dos llaves foráneas.

### ⚠️ Trampa frecuente

`pg_restore -t prestamos` (restaurar solo una tabla) recupera los datos pero **no** la llave
primaria ni las llaves foráneas. Pruébalo, revisa `\d prestamos` y explica la diferencia.
Conclusión: restaurar objetos sueltos exige saber qué más depende de ellos.

## 5. Pregunta de análisis

Si el respaldo se tomó a las 02:00 y la tabla se borró a las 16:00, ¿qué datos se perdieron?
¿Cómo se llama esa ventana y cómo la reducirías?

## 6. Limpieza

```bash
docker compose down -v
```

## ✅ Checklist

- [ ] Respaldo manual y con script, con retención comprobada
- [ ] Restauración en base aparte con conteos idénticos y tiempo medido
- [ ] Simulacro de desastre recuperado con restricciones intactas
- [ ] Trampa de `-t` probada y explicada
- [ ] Pregunta de análisis respondida

Teoría relacionada: [`03-copias-de-seguridad.md`](../../1-teoria/03-copias-de-seguridad.md),
[`04-restauracion-y-pruebas.md`](../../1-teoria/04-restauracion-y-pruebas.md).
