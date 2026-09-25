-- Rollback lógico: deshace SOLO lo que agregó la migración.
-- El rollback completo y seguro es restaurar el respaldo tomado antes de migrar
-- (práctica 01); este script sirve cuando no hubo otros cambios después.

BEGIN;

DELETE FROM socios
WHERE documento IN (SELECT trim(codigo) FROM migracion.clientes_legado);

DROP SCHEMA migracion CASCADE;

COMMIT;

SELECT count(*) AS socios_despues_del_rollback FROM socios;
