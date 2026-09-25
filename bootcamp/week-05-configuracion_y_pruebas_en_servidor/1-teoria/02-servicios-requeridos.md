# Configuración de los Servicios Requeridos

## 🎯 Objetivos

- Identificar los servicios que necesita un software para funcionar en el servidor
- Configurar el servidor de aplicaciones, la base de datos y el proxy
- Controlar el orden de arranque y el reinicio de los servicios
- Configurar y consultar logs sin llenar el disco

## 📋 Contenido

### 1. Inventario de servicios

| Servicio | En la app de referencia | Configuración clave |
|---|---|---|
| Proxy / servidor web | Caddy | Dominio, HTTPS, reenvío a la app |
| Servidor de aplicaciones | Uvicorn (FastAPI) | Puerto, procesos (*workers*), encabezados del proxy |
| Base de datos | PostgreSQL | Usuario, contraseña, base, conexiones, volumen |
| Tareas programadas | cron (semana 6) | Respaldos, limpieza |
| Monitoreo | Uptime Kuma (semana 7) | URL a vigilar, alertas |

### 2. Servidor de aplicaciones

- **Puerto**: el PaaS lo define con la variable `PORT`; en el servidor lo fija el Compose.
- **Procesos**: más *workers* atienden más peticiones simultáneas, pero cada uno consume RAM.
  Punto de partida habitual: uno o dos por núcleo, ajustado midiendo (semana 1).
- **Detrás de un proxy**: el servidor debe confiar en los encabezados `X-Forwarded-*` (en
  Uvicorn, `--proxy-headers`) para conocer la IP y el protocolo reales.

### 3. Servidor de base de datos

| Parámetro | Qué controla | Cuidado |
|---|---|---|
| Usuario y contraseña | Acceso | La app no debería usar un superusuario (semana 6) |
| `max_connections` | Conexiones simultáneas | Cada proceso de la app abre las suyas; los planes gratuitos las limitan |
| Volumen de datos | Persistencia | Sin volumen, los datos mueren con el contenedor |
| Zona horaria | Fechas y horas | Guardar en UTC y convertir al mostrar |
| Versión | Compatibilidad | Igual o mayor en destino al migrar (práctica 03) |

La base **no** publica su puerto hacia Internet: solo la alcanzan los servicios de la red interna.

### 4. Orden de arranque

```yaml
app:
  depends_on:
    db:
      condition: service_healthy
```

`depends_on` a secas solo espera a que el contenedor **exista**; con
`condition: service_healthy` espera a que su healthcheck pase. Sin eso, la app arranca antes de
que PostgreSQL acepte conexiones y falla.

### 5. Reinicio

| Política | Comportamiento |
|---|---|
| `no` | No reinicia (por defecto) |
| `on-failure` | Reinicia si el proceso termina con error |
| `unless-stopped` | Reinicia siempre, salvo que lo hayas detenido a mano |
| `always` | Reinicia siempre, incluso si lo detuviste, al reiniciar Docker |

⚠️ Docker Compose **no reinicia** un contenedor por estar `unhealthy`: el healthcheck solo informa.
Detectar y reaccionar a ese estado es tarea del monitoreo (semana 7).

### 6. Logs

```bash
docker compose logs -f app              # seguir en vivo
docker compose logs --since 10m app     # últimos 10 minutos
docker compose logs app | grep -i error
```

Por defecto Docker guarda los logs **sin límite**: un servicio que escribe mucho llena el disco.
Rotación en el Compose de producción:

```yaml
x-logging: &logging
  driver: json-file
  options:
    max-size: "10m"
    max-file: "3"
```

Cada servicio con `logging: *logging` conserva como máximo 3 archivos de 10 MB.

Buenas prácticas: la app escribe en la salida estándar (no en archivos dentro del contenedor), y
nunca registra contraseñas, tokens ni datos personales completos.

### 7. Aplicación al proyecto real

Lista los servicios de tu proyecto con su configuración clave, dependencias de arranque, política
de reinicio y rotación de logs.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
