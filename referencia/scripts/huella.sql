-- Huella de la base: filas y checksum por tabla. Se ejecuta antes y después de migrar o
-- restaurar; las dos salidas deben ser idénticas. Uso: psql ... -tA < scripts/huella.sql

SELECT 'libros' AS tabla, count(*) AS filas,
       md5(coalesce(string_agg(t::text, ',' ORDER BY id), '')) AS checksum
FROM libros t
UNION ALL
SELECT 'schema_migrations', count(*),
       md5(coalesce(string_agg(version, ',' ORDER BY version), ''))
FROM schema_migrations
ORDER BY tabla;
