# Práctica 02 — Roles de Base de Datos y Rotación de Secretos

<!-- 📝 Instrucción: práctica en parejas sobre el laboratorio. La parte 6 (rol de lectura) la
escribe la pareja sin la solución a la vista. -->

## Objetivo

Sacar a la app del superusuario, darle un rol de mínimo privilegio, probar los permisos con
pruebas negativas, separar las migraciones y ensayar la rotación de una contraseña.

## Duración estimada

120 minutos.

## Preparación

```bash
cd ../laboratorio
docker compose up -d --build --wait                   # si no está arriba desde la práctica 01
bash ../../../../referencia/scripts/smoke-test.sh
```

## 1. El punto de partida: la app como superusuario

```bash
grep ^DATABASE_URL .env
docker compose exec db psql -U postgres -d biblioteca -c "\du"
```

- [ ] ¿Con qué rol se conecta la app? ¿Qué atributos tiene?
- [ ] Nombra tres cosas que ese rol puede hacer y la app nunca necesita.

## 2. Crear los roles

Lee [`sql/01-roles.sql`](../laboratorio/sql/01-roles.sql) y
[`sql/02-permisos.sql`](../laboratorio/sql/02-permisos.sql) antes de ejecutarlos.

```bash
docker compose exec -T db psql -v ON_ERROR_STOP=1 -U postgres -d biblioteca -f /sql/01-roles.sql
docker compose exec -T db psql -v ON_ERROR_STOP=1 -U postgres -d biblioteca -f /sql/02-permisos.sql
docker compose exec db psql -U postgres -d biblioteca -c "\du" -c "\dp"
```

- [ ] ¿Por qué los roles están en un archivo aparte de los permisos? (Pista: sección 6 de la
      teoría 03.)

## 3. La app con su propio rol

En `.env`, comenta la línea de `postgres` y activa la de `biblioteca_app`. Luego:

```bash
docker compose up -d --wait app
bash ../../../../referencia/scripts/smoke-test.sh
```

## 4. Pruebas negativas

```bash
docker compose exec -T -e PGPASSWORD=app-lab servidor psql -h db -U biblioteca_app -d biblioteca <<'EOF'
SELECT count(*) FROM libros;
DROP TABLE libros;
TRUNCATE libros;
CREATE TABLE intrusa (x int);
ALTER ROLE biblioteca_app SUPERUSER;
EOF
docker compose exec -T -e PGPASSWORD=app-lab servidor psql -h db -U biblioteca_app -d postgres -c "SELECT 1"
docker compose exec -T -e PGPASSWORD=respaldo-lab servidor psql -h db -U biblioteca_respaldo -d biblioteca \
  -c "SELECT count(*) FROM libros" -c "DELETE FROM libros"
```

Completa con el mensaje exacto que obtuviste:

| Rol | Operación | ¿Debía funcionar? | Mensaje obtenido |
|---|---|:---:|---|
| `biblioteca_app` | `SELECT` en `libros` | ✅ | |
| `biblioteca_app` | `DROP TABLE` | ❌ | |
| `biblioteca_app` | `TRUNCATE` | ❌ | |
| `biblioteca_app` | `CREATE TABLE` | ❌ | |
| `biblioteca_app` | `ALTER ROLE ... SUPERUSER` | ❌ | |
| `biblioteca_app` | Conectarse a `postgres` | ❌ | |
| `biblioteca_respaldo` | `SELECT` | ✅ | |
| `biblioteca_respaldo` | `DELETE` | ❌ | |

## 5. Una migración nueva

La app ya no puede crear tablas. Intenta aplicar
[`migraciones/002_prestamos.sql`](../laboratorio/migraciones/002_prestamos.sql) con su rol:

```bash
docker compose run --rm -v ./migraciones/002_prestamos.sql:/app/migrations/002_prestamos.sql:ro \
  app python -m app.main
```

Ahora como dueño, que es como se hace en un despliegue:

```bash
docker compose run --rm -v ./migraciones/002_prestamos.sql:/app/migrations/002_prestamos.sql:ro \
  -e DATABASE_URL=postgresql://biblioteca_owner:owner-lab@db:5432/biblioteca \
  app python -m app.main
```

Comprueba que la app puede usar la tabla nueva **sin** otorgarle nada a mano:

```bash
docker compose exec -T -e PGPASSWORD=app-lab servidor psql -h db -U biblioteca_app -d biblioteca \
  -c "INSERT INTO prestamos (libro_id, lector) VALUES (1, 'Lector de prueba') RETURNING id"
```

- [ ] ¿Qué línea de `02-permisos.sql` hizo posible ese `INSERT`?
- [ ] En un pipeline (semana 7), ¿en qué paso irían las migraciones y con qué secreto?

## 6. Tu turno: rol de lectura

Un analista necesita consultar `libros` y `prestamos` para reportes. Escribe `sql/03-lectura.sql`
que cree `biblioteca_lectura` con **solo** lo necesario, incluidas las tablas futuras. Ejecútalo
como `postgres` y demuéstralo con una prueba que funcione y dos que fallen.

## 7. Rotar un secreto

Supón que la contraseña de `biblioteca_app` apareció en un *commit*. Rótala:

```bash
NUEVA=$(openssl rand -hex 24)        # hex: sin caracteres que rompan la URL de conexión
docker compose exec -T db psql -U postgres -d biblioteca \
  -c "ALTER ROLE biblioteca_app PASSWORD '$NUEVA'"
```

1. Antes de tocar `.env`, reinicia la app (`docker compose restart app`) y revisa su estado. ¿Qué
   pasa y por qué?
2. Actualiza `DATABASE_URL` en `.env` con la nueva contraseña y ejecuta
   `docker compose up -d --wait app`.
3. Prueba de humo.
4. Comprueba que la contraseña vieja (`app-lab`) ya no entra desde el servidor:

   ```bash
   docker compose exec -T -e PGPASSWORD=app-lab servidor psql -h db -U biblioteca_app -d biblioteca -c "SELECT 1"
   ```

5. Repite la prueba **dentro** del contenedor de la base
   (`docker compose exec -T -e PGPASSWORD=app-lab db psql -h localhost -U biblioteca_app -d biblioteca -c "SELECT 1"`).
   Entra. Busca la explicación en `pg_hba.conf`:
   `docker compose exec db sh -c 'grep -v "^#" $PGDATA/pg_hba.conf | grep .'`


- [ ] ¿Cuánto tiempo estuvo la app sin servicio? ¿Cómo lo reducirías?
- [ ] ¿Qué otros pasos de la teoría 04 (sección 4) faltarían en un incidente real?

## 8. Inventario de secretos del laboratorio

| Secreto | Da acceso a | Dónde vive | Permisos | Quién lo lee | Cómo se rota |
|---|---|---|---|---|---|
| Contraseña de `postgres` | | | | | |
| Contraseña de `biblioteca_app` | | | | | |
| Contraseña de `biblioteca_owner` | | | | | |
| Contraseña de `biblioteca_respaldo` | | | | | |
| Llave privada `~/.ssh/lab_s06` | | | | | |

No borres el laboratorio si vas a seguir con la práctica 03.

## ✅ Checklist

- [ ] App funcionando con `biblioteca_app` y prueba de humo en verde
- [ ] Tabla de pruebas negativas completa con los mensajes reales
- [ ] Migración aplicada con el dueño y permisos heredados por la tabla nueva
- [ ] `03-lectura.sql` propio, con pruebas
- [ ] Contraseña rotada, la vieja rechazada
- [ ] Inventario de secretos

Teoría relacionada: [`03-roles-y-privilegios-en-la-base-de-datos.md`](../../1-teoria/03-roles-y-privilegios-en-la-base-de-datos.md),
[`04-gestion-de-secretos.md`](../../1-teoria/04-gestion-de-secretos.md).
