# Entregable S02 — Planes de Migración, Respaldo e Instalación (v0)

<!-- 📝 Instrucción: completa cada sección con datos de TU proyecto real. Los valores en cursiva
son ejemplos parciales del laboratorio de la biblioteca; reemplázalos. Solo datos sintéticos. -->

| Campo | Valor |
|---|---|
| Proyecto | |
| Equipo | |
| Fecha | |

---

## 2. Plan de migración de datos

### 2.1 Objetivo medible

<!-- 📝 Instrucción: qué se migra, criterio de éxito, ventana máxima, qué no se puede alterar. -->

*Migrar el 100 % de los clientes válidos del sistema anterior a `socios`, con reporte de
rechazos aprobado por el cliente, en máximo 2 horas, sin modificar los socios existentes.*

### 2.2 Inventario de origen

| Origen | Formato | Volumen estimado | Responsable de entregarlo | Estado de calidad |
|---|---|---|---|---|
| *Sistema anterior — clientes* | *CSV `;`* | *20 filas* | *Rol: coordinador de biblioteca* | *Emails sin normalizar, fechas en texto* |
| | | | | |

### 2.3 Estrategia

- Estrategia de corte (big bang / por fases) y justificación:
- Ventana de mantenimiento propuesta:

### 2.4 Tabla de mapeo

| Origen | Destino | Transformación | Regla de rechazo |
|---|---|---|---|
| *`correo`* | *`socios.email`* | *`trim` + minúsculas* | *Vacío → rechazar* |
| | | | |

### 2.5 Validaciones

| Validación | Consulta o método | Resultado esperado |
|---|---|---|
| Conciliación de conteos | | origen = migrados + rechazados |
| Checksum | | hashes iguales |
| | | |

### 2.6 Rollback

- Criterio para ejecutar rollback:
- Método principal:
- Rol que decide:

### 2.7 Matriz de riesgos

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| | | | |

---

## 3. Plan de respaldo (v0)

### 3.1 Qué se respalda

| Elemento | Ubicación | Método | ¿Contiene datos personales? |
|---|---|---|---|
| *Base de datos* | *Servicio `db`* | *`pg_dump -Fc`* | *Sí* |
| | | | |

### 3.2 Objetivos

| RPO | RTO | Justificación (acordada con el cliente) |
|---|---|---|
| | | |

### 3.3 Política

| Aspecto | Decisión |
|---|---|
| Tipo (completo / incremental / diferencial) | |
| Frecuencia y hora | |
| Retención | |
| Copia 1 — ubicación y medio | |
| Copia 2 — ubicación y medio | |
| Copia 3 (fuera del sitio) | |
| Cifrado | |
| Responsable (rol) | |

### 3.4 Procedimiento de restauración

<!-- 📝 Instrucción: los 8 pasos de la teoría 04, con comandos exactos y copiables. -->

1. Detectar y decidir:
2. Contener:
3. Elegir el respaldo:
4. Respaldar el estado actual:
5. Restaurar:
6. Verificar:
7. Reabrir y comunicar:
8. Registrar:

### 3.5 Evidencia de restauración

<!-- 📝 Instrucción: respaldo de la base de TU proyecto restaurado en una base aparte. -->

| Tabla | Filas en producción | Filas restauradas |
|---|---|---|
| | | |

Tiempo de restauración medido:

### 3.6 Calendario de pruebas

| Prueba | Frecuencia | Responsable |
|---|---|---|
| | | |

---

## 5. Plan de instalación (v0)

| # | Sección | Contenido |
|---|---|---|
| 1 | Alcance | |
| 2 | Ambientes | |
| 3 | Roles | |
| 4 | Prerrequisitos | *Ver sección 1 (ficha técnica, semana 1)* |
| 5 | Preparación | |
| 6 | Procedimiento | *Ver pasos abajo* |
| 7 | Migración de datos | *Ver sección 2* |
| 8 | Verificación | |
| 9 | Rollback | |
| 10 | Cronograma | *Ver tabla abajo* |

### Procedimiento

| # | Acción | Comando | Resultado esperado |
|---|---|---|---|
| 1 | *Verificar requisitos del servidor* | *`bash scripts/verificar-requisitos.sh`* | *Código de salida 0* |
| 2 | | | |

### Cronograma de la ventana

| Fase | Duración | Acumulado |
|---|---|---|
| | | |

Punto de no retorno:
