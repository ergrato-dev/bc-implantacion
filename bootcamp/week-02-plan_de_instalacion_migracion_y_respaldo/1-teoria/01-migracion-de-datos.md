# Migración de Datos: Concepto y Estrategias

## 🎯 Objetivos

- Definir qué es una migración de datos y cuándo aparece en una implantación
- Diferenciar tipos de migración y estrategias de corte (big bang vs por fases)
- Entender el patrón ETL con tabla de staging

## 📋 Contenido

### 1. ¿Qué es migrar datos?

**Migrar datos** es trasladar datos de un origen a un destino **transformándolos** para que
cumplan las reglas del destino, sin perderlos ni corromperlos, y pudiendo demostrar que llegaron
completos.

Casi toda implantación real tiene una migración, aunque nadie la llame así:

| Situación | Origen | Destino |
|---|---|---|
| El cliente reemplaza un sistema viejo | Base de datos o archivos del sistema anterior | Base de tu software |
| El cliente trabajaba en hojas de cálculo | Archivos `.xlsx` / `.csv` | Base de tu software |
| Pasas de pruebas a producción con datos iniciales | Scripts de carga, catálogos | Base de producción |
| Cambias de servidor o de proveedor | PostgreSQL local | PostgreSQL en la nube (semana 5) |
| Nueva versión con cambio de esquema | Esquema v1 | Esquema v2 |

### 2. Tipos de migración

| Tipo | Qué se mueve | Ejemplo |
|---|---|---|
| **De almacenamiento** | Archivos o volúmenes, sin cambiar su formato | Mover `/uploads` a otro disco |
| **De base de datos** | Datos entre motores o versiones | MySQL 5.7 → PostgreSQL 17 |
| **De aplicación** | Datos de un sistema a otro con modelo distinto | Sistema de biblioteca viejo → nuevo |
| **A la nube** | Datos y servicios desde local hacia un proveedor | Servidor propio → Neon / Supabase |

Una migración de aplicación suele incluir las otras tres.

### 3. Estrategias de corte

| | Big bang | Por fases (*trickle*) |
|---|---|---|
| Cómo es | Se detiene el sistema viejo, se migra todo, se enciende el nuevo | Se migra por partes; ambos sistemas conviven un tiempo |
| Duración | Una ventana corta (una noche, un fin de semana) | Semanas o meses |
| Complejidad | Baja | Alta: sincronizar datos entre dos sistemas vivos |
| Riesgo | Alto si falla: todo o nada | Menor por fase, pero más puntos de falla |
| Apto para | Volúmenes pequeños o medianos, sistemas que admiten parada | Sistemas que no pueden detenerse |

Para proyectos del tamaño de los que se implantan en este bootcamp, **big bang con ventana de
mantenimiento y plan de rollback** suele ser la opción correcta.

### 4. ETL y tabla de staging

**ETL** = *Extract, Transform, Load*:

1. **Extraer** del origen, sin modificar nada (exportación CSV, `pg_dump`, consulta).
2. **Transformar**: limpiar, normalizar, aplicar reglas, rechazar lo inválido.
3. **Cargar** en el destino.

Buena práctica: cargar primero en una **tabla de staging** (área intermedia) con todas las
columnas como texto. Ventajas:

- La carga nunca falla por formato: los problemas se ven con SQL, no con errores crípticos
- El origen queda intacto y consultable durante toda la migración
- La transformación es repetible: si falla, se borra el staging y se vuelve a empezar

Así funciona la [práctica 02](../2-practicas/02-migracion-de-datos/README.md).

### 5. Calidad de datos: lo que siempre aparece

| Problema | Ejemplo | Decisión que exige |
|---|---|---|
| Formato inconsistente | `ANA@X.COM` vs `ana@x.com` | Regla de normalización |
| Campos obligatorios vacíos | Cliente sin email | ¿Rechazar o valor por defecto? |
| Valores imposibles | Fecha `31/02/2020` | Rechazar y reportar |
| Duplicados | Mismo email dos veces | ¿Cuál se conserva? |
| Conflicto con el destino | Email que ya existe en el sistema nuevo | ¿Fusionar o rechazar? |

Ninguna de estas decisiones es técnica: **las valida el cliente**. El plan de migración las deja
por escrito antes de ejecutar.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
