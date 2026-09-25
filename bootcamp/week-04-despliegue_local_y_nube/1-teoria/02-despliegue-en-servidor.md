# Organización de Archivos y Despliegue en un Servidor

## 🎯 Objetivos

- Organizar los archivos de una aplicación en un servidor Linux
- Llevar una versión liberada al servidor sin compilar allí
- Actualizar a una nueva versión y volver a la anterior (rollback)
- Diseñar migraciones compatibles con el rollback

## 📋 Contenido

### 1. Estructura en el servidor

Convención usada en el bootcamp (basada en el estándar de Linux: `/opt` para software
adicional):

```
/opt/biblioteca/
├── compose.yaml      ← qué servicios corren y con qué imagen
├── .env              ← configuración y secretos (permisos 600, dueño: usuario de despliegue)
├── Caddyfile         ← proxy y HTTPS
├── releases/         ← imágenes recibidas (.tar.gz), si no hay registro
└── respaldos/        ← respaldos locales (copia 2 de la regla 3-2-1)
```

Reglas:

- **Nada se edita a mano sin registro**: los cambios a `compose.yaml` y `Caddyfile` vienen del
  repositorio (carpeta `deploy/`); solo `.env` es propio del servidor.
- `.env` nunca está en el repositorio: se crea en el servidor a partir de `env.prod.example`.
- Los datos viven en **volúmenes** de Docker, no dentro de los contenedores.

```bash
sudo mkdir -p /opt/biblioteca/{releases,respaldos}
sudo chown -R deploy:deploy /opt/biblioteca
chmod 600 /opt/biblioteca/.env
```

### 2. ¿Cómo llega la imagen al servidor?

| Opción | Cómo | Cuándo |
|---|---|---|
| Registro de imágenes | `docker compose pull` desde GHCR / Docker Hub | Lo habitual (semana 7) |
| Archivo | `docker save` → SFTP (semana 3) → `docker load` | Sin registro o servidor sin salida a Internet |
| Compilar en el servidor | `docker build` en producción | ❌ Evitar: consume recursos de producción y no garantiza la misma imagen probada |

```bash
# En tu equipo
docker save biblioteca:1.1.0 | gzip > biblioteca-1.1.0.tar.gz
# Transferir por SFTP a /opt/biblioteca/releases/, luego en el servidor:
gunzip -c releases/biblioteca-1.1.0.tar.gz | docker load
```

### 3. Desplegar y actualizar

La versión está en **un solo lugar**: `APP_VERSION` en `.env`. El `compose.yaml` usa
`image: biblioteca:${APP_VERSION}`.

```bash
cd /opt/biblioteca
nano .env                           # APP_VERSION=1.1.0
docker compose up -d --wait         # recrea solo lo que cambió
bash smoke-test.sh https://<dominio>
```

`--wait` espera a que los healthchecks pasen: si la versión nueva no arranca, el comando
falla y lo sabes de inmediato.

Políticas de reinicio (`restart: unless-stopped`): los servicios vuelven solos después de un
reinicio del servidor o de una caída del proceso.

### 4. Rollback

Volver atrás es el mismo procedimiento con la versión anterior:

```bash
nano .env                           # APP_VERSION=1.0.0
docker compose up -d --wait
```

Funciona porque la imagen `1.0.0` **sigue en el servidor**. Regla: no borres la imagen anterior
hasta confirmar que la nueva funciona.

### 5. El problema de las migraciones

El código vuelve atrás con cambiar una etiqueta; **la base de datos no**. Si `1.1.0` aplicó una
migración, `1.0.0` debe poder funcionar con el esquema nuevo.

| Migración | ¿Compatible con volver atrás? |
|---|---|
| Agregar tabla, índice o columna opcional | ✅ El código viejo la ignora |
| Renombrar o borrar columna | ❌ El código viejo falla |
| Cambiar el tipo de una columna | ❌ Probablemente falla |

Técnica **expandir y contraer**: en una versión se agrega lo nuevo (expandir); cuando ya no hay
vuelta atrás a versiones viejas, en una versión posterior se borra lo viejo (contraer). Si una
migración no es compatible, el rollback es **restaurar el respaldo** tomado antes (semana 2).

### 6. Aplicación al proyecto real

Define la estructura de tu proyecto en el servidor, cómo llega la imagen y los comandos exactos de
despliegue, actualización y rollback. Clasifica tus migraciones: ¿alguna impide el rollback?

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
