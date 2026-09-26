# Entregable S06 — Seguridad, Usuarios y Plan de Respaldo Final

<!-- 📝 Instrucción: completa cada sección con datos de TU proyecto real. Los valores en cursiva
son ejemplos parciales de la app de referencia; reemplázalos. Nunca pegues contraseñas, llaves
privadas, tokens ni IPs reales: usa marcadores (<clave>, <servidor>) o "en el gestor de
contraseñas del equipo". -->

| Campo | Valor |
|---|---|
| Proyecto | |
| Equipo | |
| Versión del software | |
| Fecha | |

---

## 7.1 Usuarios del sistema operativo

| Cuenta | Tipo | Persona o servicio | Grupos | Inicia sesión | `sudo` permitido |
|---|---|---|---|:---:|---|
| *ana* | *Persona* | *Administradora* | *sudo* | *Llave SSH* | *Todo, con contraseña* |
| *luis* | *Persona* | *Operador* | *despliegue* | *Llave SSH* | *`/usr/local/bin/reiniciar-<proyecto>`* |
| *respaldo* | *Servicio* | *cron* | — | *No (`nologin`)* | *Nada* |
| | | | | | |

Archivos y carpetas sensibles:

| Ruta | Dueño:grupo | Permisos | Por qué |
|---|---|:---:|---|
| */opt/\<proyecto\>* | *root:despliegue* | *2770* | *Solo el equipo de despliegue entra* |
| */opt/\<proyecto\>/.env* | *root:despliegue* | *640* | *Secretos de la app* |
| | | | |

## 7.2 Acceso remoto y firewall

<!-- 📝 Pega el archivo de endurecimiento de SSH y la salida de `sudo ufw status verbose`. -->

```
<!-- /etc/ssh/sshd_config.d/10-endurecer.conf -->
```

```
<!-- sudo ufw status verbose -->
```

| Puerto | Abierto | Justificación |
|---|:---:|---|
| *22* | *Sí* | *Administración, solo con llave* |
| | | |

Evidencia de que la base de datos no está expuesta (`docker compose ps` y prueba desde otro
equipo):

```
<!-- pega aquí -->
```

## 7.3 Roles de la base de datos

| Rol | Privilegios | No puede | Lo usa | Dónde vive su contraseña |
|---|---|---|---|---|
| *\<proyecto\>_owner* | *Dueño de las tablas* | *Crear roles ni bases* | *Migraciones* | *Gestor de contraseñas* |
| *\<proyecto\>_app* | *SELECT, INSERT, UPDATE, DELETE* | *DDL, TRUNCATE* | *La app* | *`.env` del servidor* |
| | | | | |

Enlace al script de roles en el repositorio: <!-- ruta -->

¿Cómo se aplican las migraciones con el rol dueño en tu despliegue?

## 7.4 Pruebas de privilegios

| Rol | Operación | Esperado | Obtenido |
|---|---|:---:|---|
| *\<proyecto\>_app* | *`DROP TABLE <tabla>`* | *❌* | *`must be owner of table ...`* |
| | | | |
| | | | |

## 7.5 Inventario de secretos

| Secreto | Da acceso a | Dónde vive (cada ambiente) | Permisos | Quién lo lee | Cómo se rota |
|---|---|---|---|---|---|
| *Contraseña de restic* | *Todos los respaldos* | *`/etc/restic/password` + gestor de contraseñas* | *600* | *respaldo, administradores* | *`restic key add` / `key remove`* |
| | | | | | |

Revisión del historial del repositorio (comando usado y resultado):

```
<!-- pega aquí -->
```

---

## 3. Plan de respaldo final (reemplaza la versión de la semana 2)

| Campo | Valor |
|---|---|
| Qué se respalda | |
| RPO / RTO acordados | |
| Herramienta | *pg_dump + restic* |
| Usuario del sistema y rol de base que lo ejecutan | |
| Cifrado y dónde vive la contraseña | |
| Horario (línea de cron) | |
| Retención | *7 diarios, 4 semanales, 12 mensuales* |
| Verificación automática | *`restic check` en cada ejecución* |
| Responsable | |

### 3.1 Regla 3-2-1

| Copia | Medio | Ubicación | ¿Inmutable? |
|---|---|---|:---:|
| *Producción* | *Volumen de PostgreSQL* | *Servidor* | *—* |
| *Repositorio local* | *Disco del servidor* | *`/var/respaldos/restic`* | *No* |
| *Repositorio externo* | | | |

### 3.2 Script y programación

Enlace al script en el repositorio: <!-- ruta -->

Log de una ejecución automática:

```
<!-- pega aquí -->
```

### 3.3 Procedimiento de restauración de desastre

<!-- 📝 Pasos numerados y verificables. Debe poder seguirlos alguien que no configuró el
respaldo: esta sección se usa en el gate de la semana 9. -->

1.
2.
3.

### 3.4 Restauración probada

| Campo | Valor |
|---|---|
| Fecha | |
| Quién restauró (rol en el equipo) | |
| Instantánea usada y repositorio | |
| Inicio / fin | |
| Tiempo total vs RTO | |

Huellas antes y después:

```
<!-- pega aquí -->
```

Problemas encontrados y cambios hechos al procedimiento:
