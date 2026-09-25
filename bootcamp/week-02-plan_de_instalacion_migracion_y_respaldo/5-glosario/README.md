# 🎓 Glosario — Semana 2

| Término | Definición breve |
|---|---|
| **Migración de datos** | Traslado de datos de un origen a un destino, transformándolos y verificando que llegaron completos |
| **Big bang** | Estrategia que migra todo en una sola ventana, con el sistema detenido |
| **Migración por fases** | Estrategia que migra por partes con ambos sistemas conviviendo |
| **ETL** | Extraer, transformar y cargar |
| **Staging** | Área intermedia donde se carga el origen sin transformar |
| **Tabla de mapeo** | Correspondencia columna a columna entre origen y destino, con su transformación |
| **Regla de rechazo** | Condición por la que un registro no se migra y queda reportado con su motivo |
| **Conciliación** | Verificar que origen = migrados + rechazados |
| **Checksum** | Hash que permite comparar si dos conjuntos de datos son idénticos |
| **Rollback** | Volver al estado anterior a un cambio |
| **Ventana de mantenimiento** | Periodo acordado en que el servicio puede estar detenido |
| **Punto de no retorno** | Momento después del cual volver atrás es costoso |
| **Respaldo completo** | Copia de todos los datos |
| **Respaldo incremental** | Copia de lo cambiado desde el último respaldo de cualquier tipo |
| **Respaldo diferencial** | Copia de lo cambiado desde el último respaldo completo |
| **Respaldo lógico** | Exporta datos y estructura (`pg_dump`) |
| **Respaldo físico** | Copia los archivos del motor (`pg_basebackup`) |
| **WAL** | Registro de escritura anticipada de PostgreSQL; permite recuperar a un punto en el tiempo |
| **PITR** | Recuperación a un punto en el tiempo |
| **RPO** | Máxima cantidad de datos, medida en tiempo, que se acepta perder |
| **RTO** | Máximo tiempo aceptable sin servicio |
| **Regla 3-2-1** | 3 copias, 2 medios distintos, 1 fuera del sitio |
| **Retención** | Cuánto tiempo se conservan los respaldos |
| **GFS** | Esquema de retención abuelo-padre-hijo (diarios, semanales, mensuales) |
| **Simulacro** | Ejecución planificada de un procedimiento de recuperación para comprobar que funciona |
| **Plan de instalación** | Documento que permite a otra persona poner el software en funcionamiento |
