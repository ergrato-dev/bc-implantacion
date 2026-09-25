# 🎓 Glosario — Semana 5

| Término | Definición breve |
|---|---|
| **Variable de entorno** | Valor que el sistema entrega a un proceso al arrancar, fuera del código |
| **12-factor** | Conjunto de principios para apps desplegables; uno de ellos: configuración en el entorno |
| **Secreto** | Configuración sensible: contraseñas, claves, cadenas de conexión |
| **Ambiente** | Instalación con un propósito: desarrollo, pruebas, producción |
| **Paridad entre ambientes** | Que los ambientes se parezcan lo más posible |
| **Interpolación** | Reemplazo de `${VAR}` por su valor al leer un archivo de Compose |
| **`--env-file`** | Opción de Compose para usar otro archivo de variables en lugar de `.env` |
| **Fallar rápido** | Negarse a arrancar con un mensaje claro si la configuración es inválida |
| **Worker** | Proceso del servidor de aplicaciones que atiende peticiones |
| **`max_connections`** | Límite de conexiones simultáneas de PostgreSQL |
| **`depends_on` + `service_healthy`** | Espera a que la dependencia pase su healthcheck antes de arrancar |
| **Rotación de logs** | Límite de tamaño y cantidad de archivos de log |
| **Healthcheck** | Verificación periódica de que un servicio funciona |
| **Liveness** | ¿El proceso está vivo? |
| **Readiness** | ¿El servicio puede atender usuarios? |
| **`unhealthy`** | Estado de un contenedor cuyo healthcheck falló varias veces seguidas |
| **Prueba de humo** | Verificación rápida y automática de lo esencial después de desplegar |
| **Prueba funcional** | Verificación de que cada funcionalidad hace lo que debe |
| **Caso de prueba** | Pasos, datos y resultado esperado de una verificación |
| **Congelar escrituras** | Detener los cambios de datos durante una migración |
| **`--no-owner` / `--no-acl`** | Opciones de `pg_restore` que omiten dueños y permisos del origen |
| **Huella** | Conteo y checksum por tabla para comparar dos bases |
| **Corte** | Momento en que la app pasa a usar el destino |
| **Secuencia** | Generador de valores de `id` en PostgreSQL (`SERIAL`) |
