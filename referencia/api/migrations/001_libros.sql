-- Migración 001: tabla de libros con datos semilla sintéticos.

CREATE TABLE libros (
    id      SERIAL PRIMARY KEY,
    isbn    VARCHAR(13)  NOT NULL UNIQUE,
    titulo  VARCHAR(200) NOT NULL,
    autor   VARCHAR(120) NOT NULL,
    anio    SMALLINT     NOT NULL
);

INSERT INTO libros (isbn, titulo, autor, anio) VALUES
    ('9780000000001', 'Libro de prueba 1', 'Autor Uno', 2001),
    ('9780000000002', 'Libro de prueba 2', 'Autor Dos', 2010),
    ('9780000000003', 'Libro de prueba 3', 'Autor Tres', 2022);
