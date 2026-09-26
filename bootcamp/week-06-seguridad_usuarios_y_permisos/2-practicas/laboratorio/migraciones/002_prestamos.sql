-- Migración 002 (solo laboratorio): tabla de préstamos, para probar los permisos por defecto.

CREATE TABLE prestamos (
    id        SERIAL PRIMARY KEY,
    libro_id  INTEGER NOT NULL REFERENCES libros(id),
    lector    VARCHAR(120) NOT NULL,
    fecha     DATE NOT NULL DEFAULT current_date
);
