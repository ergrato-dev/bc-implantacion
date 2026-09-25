-- Paso 2: limpiar, aplicar reglas de rechazo y cargar al destino.
-- Todo ocurre en UNA transacción: o migra todo lo válido, o no migra nada.

BEGIN;

-- Convierte 'dd/mm/yyyy' a DATE; devuelve NULL si la fecha no existe (ej. 31/02).
CREATE FUNCTION migracion.fecha_segura(valor TEXT) RETURNS DATE AS $$
BEGIN
    RETURN make_date(split_part(valor, '/', 3)::int,
                     split_part(valor, '/', 2)::int,
                     split_part(valor, '/', 1)::int);
EXCEPTION WHEN others THEN
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Datos normalizados según el mapeo del plan de migración.
CREATE TABLE migracion.clientes_normalizados AS
SELECT
    trim(codigo)                               AS documento,
    initcap(trim(nombre_completo))             AS nombre,
    nullif(lower(trim(correo)), '')            AS email,
    migracion.fecha_segura(trim(fecha_alta))   AS fecha_registro
FROM migracion.clientes_legado;

-- Reglas de rechazo, en orden. Cada fila rechazada queda registrada con su motivo.
CREATE TABLE migracion.rechazos (documento TEXT, motivo TEXT);

INSERT INTO migracion.rechazos
SELECT documento, 'sin email' FROM migracion.clientes_normalizados
WHERE email IS NULL;

INSERT INTO migracion.rechazos
SELECT documento, 'fecha invalida' FROM migracion.clientes_normalizados
WHERE email IS NOT NULL AND fecha_registro IS NULL;

-- Duplicados por email dentro del archivo: se conserva el registro más antiguo.
INSERT INTO migracion.rechazos
SELECT documento, 'email duplicado en origen'
FROM (
    SELECT documento,
           row_number() OVER (PARTITION BY email ORDER BY fecha_registro) AS orden
    FROM migracion.clientes_normalizados
    WHERE email IS NOT NULL AND fecha_registro IS NOT NULL
) d
WHERE orden > 1;

INSERT INTO migracion.rechazos
SELECT n.documento, 'email ya existe en destino'
FROM migracion.clientes_normalizados n
JOIN socios s ON s.email = n.email
WHERE n.documento NOT IN (SELECT documento FROM migracion.rechazos);

-- Carga al destino: solo lo que no fue rechazado.
INSERT INTO socios (documento, nombre, email, fecha_registro)
SELECT documento, nombre, email, fecha_registro
FROM migracion.clientes_normalizados
WHERE documento NOT IN (SELECT documento FROM migracion.rechazos);

COMMIT;

SELECT motivo, count(*) FROM migracion.rechazos GROUP BY motivo ORDER BY motivo;
