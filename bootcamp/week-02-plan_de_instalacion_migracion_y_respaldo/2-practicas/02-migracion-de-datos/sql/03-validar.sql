-- Paso 3: validar la migración. Cada consulta debe devolver resultado = 'OK'.

-- 1. Conciliación de conteos: origen = migrados + rechazados.
SELECT
    (SELECT count(*) FROM migracion.clientes_legado)                         AS origen,
    (SELECT count(*) FROM socios s
       JOIN migracion.clientes_normalizados n USING (documento))             AS migrados,
    (SELECT count(*) FROM migracion.rechazos)                                AS rechazados,
    CASE WHEN (SELECT count(*) FROM migracion.clientes_legado)
            = (SELECT count(*) FROM socios s JOIN migracion.clientes_normalizados n USING (documento))
            + (SELECT count(*) FROM migracion.rechazos)
         THEN 'OK' ELSE 'FALLA' END                                          AS resultado;

-- 2. Checksum: los emails esperados y los migrados son exactamente los mismos.
WITH esperado AS (
    SELECT md5(string_agg(email, ',' ORDER BY email)) AS h
    FROM migracion.clientes_normalizados
    WHERE documento NOT IN (SELECT documento FROM migracion.rechazos)
), migrado AS (
    SELECT md5(string_agg(s.email, ',' ORDER BY s.email)) AS h
    FROM socios s JOIN migracion.clientes_normalizados n USING (documento)
)
SELECT esperado.h AS checksum_esperado, migrado.h AS checksum_migrado,
       CASE WHEN esperado.h = migrado.h THEN 'OK' ELSE 'FALLA' END AS resultado
FROM esperado, migrado;

-- 3. Reglas de negocio en destino: ningún email con mayúsculas ni espacios.
SELECT count(*) AS emails_sucios,
       CASE WHEN count(*) = 0 THEN 'OK' ELSE 'FALLA' END AS resultado
FROM socios
WHERE email <> lower(trim(email));

-- 4. Los datos existentes antes de la migración no cambiaron (200 socios sintéticos).
SELECT count(*) AS socios_previos,
       CASE WHEN count(*) = 200 THEN 'OK' ELSE 'FALLA' END AS resultado
FROM socios
WHERE documento NOT IN (SELECT documento FROM migracion.clientes_normalizados);
