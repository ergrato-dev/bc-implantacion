-- Paso 2 de 2: permisos sobre la base de la app de referencia (ya migrada).
-- Ejecutar como superusuario:  psql -U postgres -d biblioteca -f /sql/02-permisos.sql
-- Al restaurar un respaldo no hace falta: pg_dump guarda dueños y permisos de las tablas.

-- Nadie se conecta a la base "por defecto": solo los roles que se nombran.
REVOKE ALL ON DATABASE biblioteca FROM PUBLIC;
REVOKE CONNECT ON DATABASE postgres FROM PUBLIC;
GRANT CONNECT ON DATABASE biblioteca TO biblioteca_owner, biblioteca_app, biblioteca_respaldo;

-- Las tablas que hoy son de "postgres" pasan al dueño, igual que el esquema.
ALTER SCHEMA public OWNER TO biblioteca_owner;
ALTER TABLE libros OWNER TO biblioteca_owner;
ALTER TABLE schema_migrations OWNER TO biblioteca_owner;

-- La app usa el esquema y manipula filas, sin CREATE.
GRANT USAGE ON SCHEMA public TO biblioteca_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO biblioteca_app;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO biblioteca_app;

-- Tablas y secuencias que el dueño cree en el futuro (nuevas migraciones) heredan los permisos.
ALTER DEFAULT PRIVILEGES FOR ROLE biblioteca_owner IN SCHEMA public
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO biblioteca_app;
ALTER DEFAULT PRIVILEGES FOR ROLE biblioteca_owner IN SCHEMA public
    GRANT USAGE ON SEQUENCES TO biblioteca_app;
