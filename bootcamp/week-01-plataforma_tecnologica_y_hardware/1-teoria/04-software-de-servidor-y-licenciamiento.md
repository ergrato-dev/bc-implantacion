# Software de Servidor y Licenciamiento

## 🎯 Objetivos

- Clasificar el software que corre en un servidor según su función
- Identificar los servidores de bases de datos más usados y sus características
- Diferenciar licencias permisivas, copyleft, *source-available* y comerciales
- Verificar que el stack del proyecto se puede implantar sin costos de licencia ocultos

## 📋 Contenido

### 1. Tipos de software de servidor

| Tipo | Función | Ejemplos open source |
|---|---|---|
| Servidor web | Entrega archivos estáticos, termina HTTPS | Nginx, Caddy, Apache HTTP Server |
| Reverse proxy / balanceador | Reparte tráfico hacia los servicios internos | Caddy, Nginx, HAProxy, Traefik |
| Servidor de aplicaciones | Ejecuta el código del backend | Uvicorn/Gunicorn (Python), Node.js, Tomcat (Java) |
| Servidor de bases de datos | Almacena y consulta datos | PostgreSQL, MySQL, MariaDB, MongoDB |
| Caché / colas | Datos en memoria, mensajería | Valkey, RabbitMQ |
| Transferencia de archivos | Subir/bajar archivos | OpenSSH (SFTP) — ver semana 3 |
| Monitoreo | Disponibilidad y métricas | Uptime Kuma, Prometheus — ver semana 7 |

La app de referencia usa: **Caddy** (proxy) → **Uvicorn** (FastAPI) → **PostgreSQL**.

### 2. Servidores de bases de datos

| Motor | Modelo | Fortalezas | Licencia |
|---|---|---|---|
| PostgreSQL | Relacional | Estándar SQL, integridad, extensiones, JSON | PostgreSQL License (permisiva) |
| MySQL | Relacional | Muy difundido, hosting compartido | GPLv2 + licencia comercial (dual) |
| MariaDB | Relacional | Fork comunitario de MySQL | GPLv2 |
| SQLite | Relacional embebido | Sin servidor, un archivo | Dominio público |
| MongoDB | Documentos | Esquema flexible | SSPL (*source-available*) |

Al elegir motor para producción considera: soporte de respaldos en caliente, herramientas de
migración, disponibilidad como servicio gestionado gratuito (Neon y Supabase ofrecen PostgreSQL) y
experiencia del equipo.

### 3. Tipos de licencia

| Tipo | Qué permite | Obligación principal | Ejemplos |
|---|---|---|---|
| **Permisiva** | Usar, modificar, vender, cerrar el código | Conservar el aviso de copyright | MIT, BSD, Apache 2.0, PostgreSQL |
| **Copyleft** | Usar y modificar | Si **distribuyes** software derivado, debe ir con la misma licencia | GPLv2, GPLv3 |
| **Copyleft de red** | Igual que GPL | También aplica si ofreces el software **por red** | AGPLv3 (ej. Proxmox VE) |
| ***Source-available*** | Ver el código | Restricciones de uso comercial como servicio; no es open source según la OSI | SSPL, BSL, RSAL |
| **Comercial / propietaria** | Lo que diga el contrato | Pago por núcleo, usuario o suscripción | Windows Server, Oracle DB, SQL Server |

Puntos que confunden:

- **Open source no siempre significa gratis para todo uso**, y gratis no siempre significa open
  source.
- Las licencias **cambian**: Redis pasó en 2024 a licencias *source-available*; la comunidad creó
  el fork **Valkey** (BSD). Revisa siempre la licencia de la **versión** que vas a instalar.
- **Docker Engine** es open source (Apache 2.0); **Docker Desktop** requiere suscripción paga en
  empresas grandes. En un servidor Linux solo necesitas Docker Engine.
- Usar software GPL en tu servidor **sin distribuirlo** no te obliga a publicar tu código; AGPL sí
  puede obligarte si lo modificas y lo ofreces por red.

### 4. Modelos de cobro del software comercial

| Modelo | Cómo se paga |
|---|---|
| Por núcleo | Según núcleos físicos del servidor (ej. Windows Server, mínimo 16 núcleos) |
| Por usuario / dispositivo (CAL) | Licencia adicional por cada usuario que accede |
| Suscripción | Pago anual con soporte y actualizaciones |
| Por consumo | Nube: pagas por hora, GB o petición |

### 5. Aplicación al proyecto real

En la ficha técnica lista cada componente de software de tu proyecto con su versión y licencia,
y responde: ¿hay algún componente que genere costo o restricción al implantarlo para el cliente?

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
