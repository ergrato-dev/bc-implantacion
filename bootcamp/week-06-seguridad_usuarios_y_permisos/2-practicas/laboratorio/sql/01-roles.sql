-- Paso 1 de 2: roles de mínimo privilegio para la app de referencia.
-- Los roles son del servidor, no de la base: pg_dump NO los respalda. Este archivo se
-- versiona y se vuelve a ejecutar al reconstruir un servidor, ANTES de restaurar.
-- Ejecutar como superusuario:  psql -U postgres -d biblioteca -f /sql/01-roles.sql
-- Contraseñas solo de laboratorio: en un servidor real salen de un gestor de secretos.

-- 1. Dueño: crea y modifica tablas (migraciones). No es superusuario.
CREATE ROLE biblioteca_owner LOGIN PASSWORD 'owner-lab';

-- 2. App: solo lee y escribe datos. No crea, no borra, no altera tablas.
CREATE ROLE biblioteca_app LOGIN PASSWORD 'app-lab';

-- 3. Respaldo: solo lectura de todo, para pg_dump.
CREATE ROLE biblioteca_respaldo LOGIN PASSWORD 'respaldo-lab';
GRANT pg_read_all_data TO biblioteca_respaldo;
