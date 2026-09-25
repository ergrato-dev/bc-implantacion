# Práctica 03 — Migrar la Base a un Servidor Gestionado

<!-- 📝 Instrucción: práctica en equipo. Un integrante lee el procedimiento en voz alta, otro
ejecuta y un tercero registra horas y resultados: así se trabaja una ventana de mantenimiento.
Las partes 1-8 son en el laboratorio; la 9 repite el proceso contra Neon (opcional si no hay
cuenta). -->

## Objetivo

Ejecutar una migración completa con ventana de mantenimiento: congelar, volcar, restaurar,
validar con huellas, cortar y verificar, con el rollback listo.

## Duración estimada

150 minutos.

## Preparación

```bash
cd ../laboratorio
docker compose up -d --build --wait
bash ../../../../referencia/scripts/smoke-test.sh     # agrega datos nuevos al origen
```

Registro de la ventana (complétalo durante la práctica):

| Paso | Hora inicio | Hora fin | Resultado |
|---|---|---|---|
| Congelar | | | |
| Volcado | | | |
| Restauración | | | |
| Validación | | | |
| Corte | | | |
| Verificación | | | |

## 1. Congelar escrituras

```bash
docker compose stop app
```

- [ ] ¿Qué pasaría con un libro agregado entre el volcado y el corte si no se detiene la app?

## 2. Volcado del origen

Se usa el `pg_dump` del contenedor `destino` (versión 17) para leer el origen (versión 16):

```bash
docker compose exec -T -e PGPASSWORD=origen-lab destino \
  pg_dump -h origen -U biblioteca -Fc biblioteca -f /respaldos/migracion.dump
ls -lh respaldos/
```

- [ ] ¿Por qué no usar el `pg_dump` de la versión 16 para restaurar en 17? ¿Y al revés?

Este archivo es también el **respaldo de seguridad** para el rollback.

## 3. Restauración: primer intento

```bash
docker compose exec -T destino pg_restore -U propietario_nube -d nubedb /respaldos/migracion.dump
echo "código de salida: $?"
```

Lee los errores. ¿Qué rol falta? ¿Por qué existe en el origen y no en el destino?

Deja el destino limpio antes del segundo intento:

```bash
docker compose exec -T destino psql -U propietario_nube -d nubedb \
  -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
```

## 4. Restauración correcta

```bash
docker compose exec -T destino pg_restore -U propietario_nube -d nubedb \
  --no-owner --no-acl /respaldos/migracion.dump
echo "código de salida: $?"
```

## 5. Validación por huella

```bash
docker compose exec -T -e PGPASSWORD=origen-lab destino \
  psql -h origen -U biblioteca -d biblioteca -tA -f /sql/validar.sql > huella-origen.txt
docker compose exec -T destino \
  psql -U propietario_nube -d nubedb -tA -f /sql/validar.sql > huella-destino.txt
diff huella-origen.txt huella-destino.txt && echo "HUELLAS IDÉNTICAS"
```

Revisa [`sql/validar.sql`](../laboratorio/sql/validar.sql): ¿por qué incluye `schema_migrations`?

## 6. Corte

En `.env`, comenta la línea de `origen` y activa la de `destino`. Luego:

```bash
docker compose up -d --wait app
docker compose logs app | tail -5
```

- [ ] ¿La app aplicó alguna migración al arrancar contra el destino? ¿Por qué?

## 7. Verificación

```bash
bash ../../../../referencia/scripts/smoke-test.sh
docker compose exec -T destino psql -U propietario_nube -d nubedb -c "SELECT max(id) FROM libros;"
```

- [ ] El libro creado por la prueba de humo, ¿recibió un `id` nuevo sin chocar? ¿Qué se
      migró para que eso funcione?

## 8. Rollback (simulacro)

Suponiendo que la verificación falló: vuelve `.env` a `origen` y ejecuta
`docker compose up -d --wait app`. ¿Qué datos se perderían si ya hubiera usuarios escribiendo en
el destino? Después, deja la app apuntando al destino.

## 9. Opcional: la nube real (Neon)

Con la base de Neon de la semana 4 (vacía o recreada) y su cadena de conexión en una variable de
la terminal (**no** en un archivo del repositorio):

```bash
read -s NEON_URL      # pega la cadena y presiona Enter; no se muestra ni queda en el historial
docker compose exec -T destino pg_restore -d "$NEON_URL" --no-owner --no-acl /respaldos/migracion.dump
docker compose exec -T destino psql "$NEON_URL" -tA -f /sql/validar.sql
```

Compara con `huella-origen.txt`. Si la base de Neon ya tenía las tablas de la semana 4, primero
decide: ¿se sobrescriben o se conservan? Esa decisión es parte del plan.

## 10. Limpieza

```bash
docker compose down -v
rm -f huella-*.txt
```

## ✅ Checklist

- [ ] Registro de la ventana con horas
- [ ] Error de dueño provocado, explicado y resuelto
- [ ] Huellas idénticas entre origen y destino
- [ ] Corte y verificación con prueba de humo
- [ ] Rollback simulado y su límite explicado

Teoría relacionada: [`04-ejecutar-la-migracion.md`](../../1-teoria/04-ejecutar-la-migracion.md).
