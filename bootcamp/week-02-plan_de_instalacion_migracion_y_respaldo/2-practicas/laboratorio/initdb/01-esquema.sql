-- Esquema del sistema nuevo de la biblioteca (destino de la migración).

CREATE TABLE socios (
    id              SERIAL PRIMARY KEY,
    documento       VARCHAR(20)  NOT NULL UNIQUE,
    nombre          VARCHAR(120) NOT NULL,
    email           VARCHAR(120) NOT NULL UNIQUE,
    fecha_registro  DATE         NOT NULL
);

CREATE TABLE libros (
    id      SERIAL PRIMARY KEY,
    isbn    VARCHAR(13)  NOT NULL UNIQUE,
    titulo  VARCHAR(200) NOT NULL,
    autor   VARCHAR(120) NOT NULL,
    anio    SMALLINT     NOT NULL
);

CREATE TABLE prestamos (
    id                SERIAL PRIMARY KEY,
    socio_id          INTEGER NOT NULL REFERENCES socios (id),
    libro_id          INTEGER NOT NULL REFERENCES libros (id),
    fecha_prestamo    DATE    NOT NULL,
    fecha_devolucion  DATE,
    CHECK (fecha_devolucion IS NULL OR fecha_devolucion >= fecha_prestamo)
);
