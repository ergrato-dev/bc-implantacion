# Práctica 04 — Monitoreo con Uptime Kuma

<!-- 📝 Instrucción: práctica en parejas sobre el laboratorio, a continuación de la práctica 03
(app en 1.1.0). Una persona provoca fallos sin avisar y la otra los detecta desde el panel y las
alertas. -->

## Objetivo

Vigilar la app con monitores de disponibilidad, de contenido y de latido, recibir alertas por
webhook y usar los logs para diagnosticar cada fallo.

## Duración estimada

120 minutos.

## Preparación

```bash
cd ../laboratorio
docker compose up -d --wait registro db app kuma alertas
curl -s localhost:8000/api/version
```

Abre <http://localhost:3001>:

1. Base de datos de Uptime Kuma: **SQLite** (suficiente para un monitor pequeño).
2. Crea el usuario administrador con una contraseña generada. Es un secreto más del inventario
   (semana 6).

Uptime Kuma corre en la red del laboratorio: llega a la app como `http://app:8000`.

## 1. Canal de alertas

**Settings → Notifications → Setup Notification**:

| Campo | Valor |
|---|---|
| Notification Type | Webhook |
| Friendly Name | Webhook del equipo |
| Post URL | `http://alertas:8080/kuma` |
| Request Body | JSON (application/json) |
| Default enabled | ✅ |

Pulsa **Test** y comprueba que llegó:

```bash
docker compose logs alertas | tail -20
```

En un equipo real, este canal sería Telegram, Discord, Slack o correo: elige uno que alguien lea.

## 2. Monitores

**Add New Monitor** tres veces:

| Tipo | Nombre | URL / configuración | Intervalo | Reintentos |
|---|---|---|---|---|
| HTTP(s) | Biblioteca — salud | `http://app:8000/api/health` | 20 s | 1 |
| HTTP(s) - Keyword | Biblioteca — versión | `http://app:8000/api/version`, palabra `1.1.0` | 20 s | 0 |
| Push | Respaldo diario | (Uptime Kuma genera la URL) | 60 s | 0 |

En producción, el intervalo de la salud sería de 60 s y el del respaldo de 24 h más un margen:
aquí se acortan para ver resultados en clase. Copia la **Push URL** del tercer monitor.

## 3. Latido del respaldo

Simula el final exitoso de `respaldar.sh` de la semana 6, que ya envía el latido si tiene
`URL_LATIDO` definida:

```bash
URL_LATIDO='http://localhost:3001/api/push/<token>?status=up&msg=OK&ping='
curl -fsS "$URL_LATIDO"
```

Envíalo dos o tres veces y luego **deja de enviarlo**.

- [ ] ¿Cuánto tardó en llegar la alerta "No heartbeat in the time window"?
- [ ] Lee [`respaldar.sh`](../../../week-06-seguridad_usuarios_y_permisos/2-practicas/laboratorio/respaldo/respaldar.sh):
      ¿en qué punto envía el latido? ¿Por qué no al principio?

## 4. Provoca y detecta

Una persona provoca cada fallo sin decir cuál; la otra lo detecta con el panel, las alertas y los
logs, y anota:

| # | Fallo provocado | Monitor que alertó | Tiempo hasta la alerta | Evidencia en logs |
|---|---|---|---|---|
| 1 | `docker compose stop app` | | | |
| 2 | `docker compose stop db` | | | |
| 3 | `bash desplegar.sh 1.0.0` (despliegue "no anunciado") | | | |
| 4 | Dejar de enviar el latido | | | |

Comandos de diagnóstico:

```bash
docker compose ps
docker compose logs --since 5m app | grep -iE "error|traceback" | tail -5
curl -s -w " %{http_code}\n" localhost:8000/api/health
```

- [ ] En el fallo 2, la app sigue viva pero `/api/health` responde `503`. ¿Qué monitores alertaron
      y cuáles no? ¿Por qué el de salud revisa la base?
- [ ] En el fallo 3, ¿qué monitor lo detectó? ¿Qué harías con él en cada despliegue legítimo?
- [ ] Restablece todo (`docker compose start app db`, `bash desplegar.sh 1.1.0`) y comprueba que
      llega la alerta de recuperación.

## 5. Recursos del servidor

```bash
docker stats --no-stream
docker system df
df -h /
docker inspect --format '{{json .HostConfig.LogConfig}}' lab-s07-app-1
```

- [ ] ¿Qué contenedor usa más memoria? ¿Cuánto ocupan las imágenes de las versiones publicadas?
- [ ] ¿Qué pasaría con el disco del registro si el pipeline publicara una versión al día durante
      un año?

## 6. Página de estado (opcional)

**Status Pages → New Status Page** con los monitores de la biblioteca. ¿Qué información mostrarías
a los usuarios y cuál no?

## 7. Limpieza

```bash
docker compose down -v
rm -f desplegar.sh smoke-test.sh despliegues.log && rm -rf respaldos
```

## ✅ Checklist

- [ ] Canal de alertas probado
- [ ] Monitores de salud, versión y latido configurados
- [ ] Alerta por latido ausente recibida
- [ ] Tabla de fallos provocados completa, con tiempos y evidencia en logs
- [ ] Alerta de recuperación recibida
- [ ] Consumo de recursos y espacio de Docker revisados

Teoría relacionada: [`04-monitoreo-basico.md`](../../1-teoria/04-monitoreo-basico.md).
