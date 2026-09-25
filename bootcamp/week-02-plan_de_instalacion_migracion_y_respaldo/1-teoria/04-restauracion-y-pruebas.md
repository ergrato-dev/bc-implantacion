# Procesos de Restauración y Pruebas

## 🎯 Objetivos

- Describir un procedimiento de restauración paso a paso
- Diferenciar escenarios de restauración (total, parcial, en otro servidor)
- Diseñar pruebas de restauración periódicas y un simulacro
- Medir el RTO real en vez de suponerlo

## 📋 Contenido

### 1. Un respaldo no probado no es un respaldo

Fallas típicas que solo aparecen al restaurar:

- El archivo está vacío o truncado (el disco se llenó durante el respaldo)
- Se respaldó la base equivocada, o faltaba una tabla
- Nadie sabe la contraseña del cifrado
- La restauración tarda 6 horas y el RTO acordado era 1 hora
- El respaldo no incluía los archivos subidos por los usuarios

Por eso el plan de respaldo **siempre** incluye un plan de pruebas de restauración.

### 2. Escenarios

| Escenario | Ejemplo | Enfoque |
|---|---|---|
| Restauración total | El servidor se perdió | Servidor nuevo + último respaldo completo |
| Restauración de una base | Base corrupta | `pg_restore --clean --if-exists` sobre la base |
| Recuperación parcial | Se borraron registros de una tabla | Restaurar en **base aparte** y copiar solo lo necesario |
| Restauración de verificación | Prueba periódica | Restaurar en base aparte y comparar |

⚠️ Restaurar una sola tabla con `pg_restore -t` recupera datos pero no sus llaves ni
dependencias. En recuperación parcial, restaura todo en una base aparte y copia desde ahí (lo
compruebas en la [práctica 01](../2-practicas/01-respaldo-y-restauracion/README.md)).

### 3. Procedimiento de restauración

Todo procedimiento escrito tiene la misma estructura:

1. **Detectar y decidir**: ¿quién declara que hay que restaurar? ¿Con qué criterio?
2. **Contener**: detener la aplicación para que no escriba sobre datos inconsistentes.
3. **Elegir el respaldo**: el último verificado anterior al incidente.
4. **Respaldar el estado actual** (aunque esté dañado): sirve para investigar después.
5. **Restaurar**: comandos exactos, copiables.
6. **Verificar**: conteos, consultas de control, prueba funcional de la aplicación.
7. **Reabrir** el servicio y **comunicar** a los usuarios qué datos se perdieron (RPO).
8. **Registrar**: hora de inicio, fin, respaldo usado, problemas encontrados.

### 4. Pruebas de restauración

| Prueba | Frecuencia sugerida | Qué verifica |
|---|---|---|
| Lectura del archivo (`pg_restore --list`) | En cada respaldo (automática) | El archivo no está corrupto |
| Restauración en base aparte + conteos | Semanal o mensual | Los datos restauran completos |
| Simulacro completo en servidor limpio | Trimestral o antes de cada entrega | El procedimiento funciona y el RTO se cumple |

### 5. Consultas de control

Guarda consultas cuyo resultado conoces para compararlas antes y después:

```sql
SELECT count(*) FROM socios;
SELECT count(*) FROM prestamos WHERE fecha_devolucion IS NULL;
SELECT max(fecha_prestamo) FROM prestamos;   -- ¿de cuándo es el dato más reciente?
```

La última consulta dice exactamente **hasta cuándo** tienes datos: tu RPO real.

### 6. Aplicación al proyecto real

En el entregable escribe el procedimiento de restauración de tu proyecto con los ocho pasos
y los comandos exactos, y define el calendario de pruebas. En la semana 9 otro equipo lo
ejecutará sin tu ayuda.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
