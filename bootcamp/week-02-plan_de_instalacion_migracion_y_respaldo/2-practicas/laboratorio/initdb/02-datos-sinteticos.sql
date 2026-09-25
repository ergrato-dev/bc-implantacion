-- Datos sintéticos y deterministas: siempre se generan los mismos registros,
-- así todos los aprendices pueden comparar conteos y checksums.

INSERT INTO socios (documento, nombre, email, fecha_registro)
SELECT
    (1000000 + n)::text,
    'Socio ' || n,
    'socio' || n || '@ejemplo.test',
    DATE '2024-01-01' + (n % 365)
FROM generate_series(1, 200) AS n;

INSERT INTO libros (isbn, titulo, autor, anio)
SELECT
    lpad((9780000000000 + n)::text, 13, '0'),
    'Libro de prueba ' || n,
    'Autor ' || (n % 25 + 1),
    1990 + (n % 35)
FROM generate_series(1, 100) AS n;

INSERT INTO prestamos (socio_id, libro_id, fecha_prestamo, fecha_devolucion)
SELECT
    (n % 200) + 1,
    (n % 100) + 1,
    DATE '2025-01-01' + (n % 240),
    CASE WHEN n % 4 = 0 THEN NULL ELSE DATE '2025-01-01' + (n % 240) + 14 END
FROM generate_series(1, 500) AS n;
