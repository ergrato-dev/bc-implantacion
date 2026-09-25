# Práctica 02 — Sitios por Nombre, Reverse Proxy y HTTPS

<!-- 📝 Instrucción: práctica en parejas sobre el laboratorio. En el paso 5 cada pareja agrega
un sitio propio al Caddyfile. -->

## Objetivo

Publicar dos servicios en un mismo servidor diferenciados por nombre de dominio, detrás de un
reverse proxy con HTTPS, y entender qué hace cada pieza.

## Duración estimada

150 minutos.

## Preparación

```bash
cd ../laboratorio
docker compose up -d --wait
```

## 1. Un servidor, dos sitios

Revisa el [`Caddyfile`](../laboratorio/caddy/Caddyfile). Hay dos bloques: `sitio.lab.test` y
`api.lab.test`. Ambos llegan al **mismo** puerto 443 del **mismo** contenedor.

```bash
curl -k --resolve api.lab.test:8443:127.0.0.1 https://api.lab.test:8443/
curl -k --resolve sitio.lab.test:8443:127.0.0.1 https://sitio.lab.test:8443/ -i
```

- [ ] ¿Cómo sabe Caddy a qué servicio mandar cada petición? (pista: encabezado `Host`)
- [ ] ¿Por qué el sitio responde `404`? (se resuelve en la práctica 03)

## 2. Lo que ve el backend

La respuesta de `api.lab.test` muestra la petición tal como la recibió el servicio `api`.
Busca los encabezados `X-Forwarded-For`, `X-Forwarded-Proto` y `X-Forwarded-Host`.

- [ ] ¿Qué IP ve el backend como `RemoteAddr`? ¿Es la tuya o la del proxy?
- [ ] `X-Forwarded-For` muestra la puerta de enlace de la red de Docker, no `127.0.0.1`: Docker
      traduce la dirección al entrar al contenedor. En un servidor real ahí aparece la IP del cliente.
- [ ] ¿Para qué necesita el backend `X-Forwarded-For`?

## 3. HTTP → HTTPS

```bash
curl -i -H "Host: sitio.lab.test" http://127.0.0.1:8080/
```

Caddy responde `308` y redirige a `https://`. La redirección apunta al puerto 443 estándar; en
el laboratorio usamos 8443, por eso la probamos con `curl` y no con el navegador.

## 4. El certificado

```bash
curl -kv --resolve sitio.lab.test:8443:127.0.0.1 https://sitio.lab.test:8443/ 2>&1 \
  | grep -E "subject:|issuer:|expire date"
```

- [ ] ¿Quién emitió el certificado (`issuer`)?
- [ ] ¿Cuándo vence (`expire date`)? Los certificados de la CA interna de Caddy duran horas y
      se renuevan solos: renovar no es una tarea manual.
- [ ] ¿Por qué `curl` sin `-k` lo rechaza? Pruébalo.
- [ ] ¿Qué cambiaría en el `Caddyfile` en un servidor real con dominio público?

## 5. Agrega tu propio sitio

Agrega al final de `laboratorio/caddy/Caddyfile` un bloque nuevo que responda un texto fijo:

```
equipo.lab.test {
	tls internal
	respond "Hola desde el equipo <nombre>"
}
```

Recarga Caddy **sin reiniciar** el contenedor y pruébalo:

```bash
docker compose exec proxy caddy reload --config /etc/caddy/Caddyfile
curl -k --resolve equipo.lab.test:8443:127.0.0.1 https://equipo.lab.test:8443/
```

- [ ] ¿Qué ventaja tiene `reload` frente a reiniciar el contenedor en producción?

## 6. Error provocado

Introduce un error de sintaxis en el `Caddyfile` (borra una llave `}`) y vuelve a ejecutar
`caddy reload`. ¿Qué pasa con los sitios que ya estaban funcionando? Corrige el error.

## ✅ Checklist

- [ ] Explico cómo el proxy distingue sitios por nombre
- [ ] Identifiqué los encabezados `X-Forwarded-*` y su propósito
- [ ] Revisé el certificado y sé qué cambia con un dominio público
- [ ] Agregué un sitio y lo recargué sin reiniciar
- [ ] Probé que un `reload` con errores no tumba los sitios activos

Teoría relacionada:
[`03-servidor-web-y-reverse-proxy.md`](../../1-teoria/03-servidor-web-y-reverse-proxy.md).
