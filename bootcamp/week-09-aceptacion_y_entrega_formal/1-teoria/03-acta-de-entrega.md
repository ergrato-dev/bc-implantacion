# Acta de Entrega y Niveles de Servicio

## 🎯 Objetivos

- Identificar el contenido de un acta de entrega de software
- Acordar niveles de servicio que el equipo pueda cumplir
- Transferir accesos y secretos de forma segura
- Cerrar formalmente la implantación

## 📋 Contenido

### 1. ¿Para qué un acta?

El acta es el documento con el que el cliente **recibe** el software implantado. Deja por
escrito qué se entregó, en qué estado, qué queda pendiente y qué compromisos siguen vigentes.
Protege a ambas partes: el cliente sabe qué puede exigir y el equipo sabe dónde termina su
responsabilidad.

### 2. Contenido

| Sección | Contenido |
|---|---|
| Identificación | Proyecto, cliente, equipo (por roles), fecha, lugar o medio |
| Alcance entregado | Funcionalidades aceptadas (casos de aceptación) y versión exacta |
| Ambientes | Producción (URL), pruebas, dónde está el código y el registro de imágenes |
| Documentación | Plan de Implantación (versión), ayudas en línea, runbooks |
| Resultado de aceptación | Decisión y defectos abiertos con fecha de corrección |
| Resultado del simulacro | Quién instaló, duración, huellas, desviaciones corregidas |
| Transferencia de accesos | **Qué** accesos se transfieren y **cómo**, nunca los secretos mismos |
| Niveles de servicio | Soporte, tiempos, disponibilidad, horario (sección 3) |
| Garantía | Qué cubre, por cuánto tiempo, qué no cubre |
| Pendientes | Qué queda por hacer, responsable y fecha |
| Firmas | Quién entrega, quién recibe, testigo |

### 3. Niveles de servicio

Los tiempos propuestos en la semana 8 se convierten aquí en **compromisos**. Solo se firma lo que
el equipo puede cumplir con las personas que tiene.

| Nivel de servicio | Ejemplo | Cómo se mide |
|---|---|---|
| Disponibilidad | 99 % mensual, fuera de ventanas de mantenimiento | Uptime Kuma |
| Horario de soporte | Lunes a viernes, 8:00-17:00 | — |
| Primera respuesta / solución | Por prioridad (P1-P4) | Fechas de los issues |
| RPO / RTO | 24 h / 4 h | Restauración de prueba mensual |
| Ventana de mantenimiento | Domingo 06:00-07:00, aviso con 48 h | Registro de mantenimiento |

Un 99 % mensual permite unas 7 horas sin servicio al mes; un 99,9 %, unos 43 minutos. En un plan
gratuito que se suspende por inactividad (semana 4), prometer 99,9 % es incumplir.

### 4. Transferencia de accesos

El acta **lista** los accesos; los secretos viajan por un canal seguro y aparte:

| Acceso | Cómo se transfiere |
|---|---|
| Repositorio y registro de imágenes | Invitar a la cuenta del cliente como administrador; luego retirar al equipo si corresponde |
| Servidor | Crear las cuentas del cliente con **sus** llaves; retirar las del equipo |
| Contraseñas (base, restic, paneles) | Gestor de contraseñas compartido o entrega en persona; **rotarlas** después de entregar |
| Dominio y proveedores en la nube | Transferir la propiedad de la cuenta o del recurso |

Rotar después de entregar garantiza que solo el cliente conoce los secretos vigentes.

### 5. Garantía

Periodo (por ejemplo, 30 días) en el que el equipo corrige **defectos** sin costo. No cubre
funcionalidades nuevas, cambios hechos por terceros ni fallas de proveedores externos. Lo que
no está en el acta queda fuera de la garantía.

### 6. Aplicación al proyecto real

Redacta el acta de entrega de tu proyecto con los resultados de la aceptación y del simulacro,
niveles de servicio que puedas cumplir y la lista de accesos a transferir.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
