# Práctica 02 — Desplegar, Actualizar y Revertir en un Servidor Linux

<!-- 📝 Instrucción: práctica en parejas. Preferir la VM Ubuntu del laboratorio; si no hay VM,
el "servidor" es una carpeta del propio equipo que simula /opt/biblioteca. -->

## Objetivo

Instalar la versión 1.0.0 en un servidor con la estructura de `/opt`, actualizar a 1.1.0 sin
compilar en el servidor y volver a 1.0.0.

## Duración estimada

180 minutos.

## Opciones de servidor

| Opción | "Servidor" | Carpeta de despliegue | Puertos |
|---|---|---|---|
| A — VM del laboratorio | VM Ubuntu con Docker | `/opt/biblioteca` | 80 y 443 |
| B — Simulado | Tu propio equipo | `~/servidor/opt/biblioteca` | 8080 y 8443 |

Los comandos usan la variable `DESTINO`; defínela según tu opción:

```bash
DESTINO=/opt/biblioteca                  # opción A (en la VM)
DESTINO=~/servidor/opt/biblioteca        # opción B
```

## 1. Verificar el servidor

Ejecuta el script de la semana 1 en el servidor. Debe terminar con código `0` (en la opción B,
con `PORTS="8080 8443"`).

## 2. Preparar la estructura

```bash
mkdir -p $DESTINO/{releases,respaldos}
cp ~/biblioteca/deploy/compose.prod.yaml $DESTINO/compose.yaml
cp ~/biblioteca/deploy/Caddyfile $DESTINO/
cp ~/biblioteca/deploy/env.prod.example $DESTINO/.env
chmod 600 $DESTINO/.env
```

En la opción A estos archivos llegan por SFTP (semana 3). Edita `$DESTINO/.env`:

- `DOMINIO=biblioteca.lab.test`
- `APP_VERSION=1.0.0`
- `POSTGRES_PASSWORD` → genera una con `openssl rand -base64 24`

Como `.test` no es un dominio público, en `Caddyfile` descomenta `tls internal`.

**Solo opción B**: en `compose.yaml` cambia los puertos a `"8080:80"` y `"8443:443"`.

## 3. Llevar la imagen sin registro

En tu equipo:

```bash
docker save biblioteca:1.0.0 | gzip > biblioteca-1.0.0.tar.gz
docker save biblioteca:1.1.0 | gzip > biblioteca-1.1.0.tar.gz
ls -lh biblioteca-*.tar.gz
```

Transfiérelas a `$DESTINO/releases/` (SFTP en la opción A, `cp` en la B) y cárgalas **en el
servidor**:

```bash
gunzip -c $DESTINO/releases/biblioteca-1.0.0.tar.gz | docker load
gunzip -c $DESTINO/releases/biblioteca-1.1.0.tar.gz | docker load
```

## 4. Instalar 1.0.0

```bash
cd $DESTINO
docker compose up -d --wait
docker compose ps
```

Prueba de humo a través del proxy (opción B; en la A usa el puerto 443):

```bash
CURL_OPTS="-k --resolve biblioteca.lab.test:8443:127.0.0.1" \
  bash ~/biblioteca/scripts/smoke-test.sh https://biblioteca.lab.test:8443
```

- [ ] ¿Qué puertos publica el servidor? Revisa `docker compose ps`: ¿la base de datos o la app
      tienen puerto propio hacia afuera?

## 5. Actualizar a 1.1.0

1. Respaldo antes de actualizar (semana 2):

   ```bash
   docker compose exec -T db pg_dump -U biblioteca -Fc biblioteca > respaldos/antes-1.1.0.dump
   ```

2. Cambia `APP_VERSION=1.1.0` en `.env` y aplica:

   ```bash
   docker compose up -d --wait
   docker compose logs app | grep -i migración
   ```

3. Prueba de humo: debe reportar `1.1.0`.

## 6. Rollback a 1.0.0

Cambia `APP_VERSION=1.0.0` y ejecuta `docker compose up -d --wait`. Prueba de humo.

```bash
docker compose exec -T db psql -U biblioteca -d biblioteca -c "SELECT * FROM schema_migrations;"
```

- [ ] La migración `002` sigue aplicada y la versión 1.0.0 funciona. ¿Por qué?
- [ ] ¿Qué harías si la 1.1.0 hubiera borrado una columna que usa la 1.0.0?

## 7. Reinicio del servidor

```bash
docker compose restart          # opción B
sudo reboot                     # opción A (espera y vuelve a conectarte)
```

¿Los servicios volvieron solos? ¿Qué línea de `compose.yaml` lo garantiza?

## 8. Limpieza

```bash
cd $DESTINO && docker compose down -v
```

## ✅ Checklist

- [ ] Estructura de `/opt/biblioteca` con `.env` en permisos 600
- [ ] Imagen transferida como archivo y cargada con `docker load`
- [ ] Instalación 1.0.0, actualización 1.1.0 y rollback, con prueba de humo en cada paso
- [ ] Respaldo tomado antes de actualizar
- [ ] Explicación de por qué este rollback no requirió restaurar la base

Teoría relacionada: [`02-despliegue-en-servidor.md`](../../1-teoria/02-despliegue-en-servidor.md).
