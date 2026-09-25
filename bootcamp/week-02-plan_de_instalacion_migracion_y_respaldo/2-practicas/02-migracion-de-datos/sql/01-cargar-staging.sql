-- Paso 1: cargar el archivo legado SIN transformar en una tabla de staging.
-- Todo es texto: la limpieza se hace después, nunca durante la carga.

DROP SCHEMA IF EXISTS migracion CASCADE;
CREATE SCHEMA migracion;

CREATE TABLE migracion.clientes_legado (
    codigo           TEXT,
    nombre_completo  TEXT,
    correo           TEXT,
    fecha_alta       TEXT,
    telefono         TEXT
);

COPY migracion.clientes_legado
FROM '/datos-legados/clientes_legado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';');

SELECT count(*) AS filas_cargadas FROM migracion.clientes_legado;
