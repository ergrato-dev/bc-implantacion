# Entregable S03 — Estrategia de Hosting y Dominio

<!-- 📝 Instrucción: completa cada sección con datos de TU proyecto real. Los valores en cursiva
son ejemplos parciales; reemplázalos. Usa IP de documentación (203.0.113.x) o marcadores
(<ip-servidor>), nunca IP reales. -->

| Campo | Valor |
|---|---|
| Proyecto | |
| Equipo | |
| Fecha | |

---

## 4.1 Tipo de hosting por componente

| Componente | Tipo de hosting | Proveedor candidato | Justificación |
|---|---|---|---|
| *Frontend (build estático)* | *Estático* | *Render Static Site* | *Solo archivos, CDN y HTTPS incluidos* |
| *API* | *PaaS (contenedor)* | *Render Web Service* | *Corre la imagen Docker sin administrar servidor* |
| *Base de datos* | *PostgreSQL gestionado* | *Neon* | *Free tier con respaldos del proveedor* |
| | | | |

Alternativa en servidor propio (VM Ubuntu del laboratorio o del cliente):

<!-- 📝 Instrucción: describe cómo quedaría todo en un VPS con Docker Compose + Caddy. -->

## 4.2 Dominio

| Campo | Valor |
|---|---|
| Nombre de dominio o subdominio | |
| Tipo (propio / subdominio gratuito / PaaS) | |
| Registrador o proveedor | |
| Responsable de pago y renovación (rol) | |
| Fecha de vencimiento | |

## 4.3 Registros DNS

| Nombre | Tipo | Valor | TTL | Propósito |
|---|---|---|---|---|
| *`@`* | *A* | *`<ip-servidor>`* | *3600* | *Sitio principal* |
| *`api`* | *CNAME* | *`<servicio>.onrender.com`* | *3600* | *API en PaaS* |
| | | | | |

## 4.4 Camino de una petición

<!-- 📝 Instrucción: diagrama (imagen o lista) desde el navegador hasta la base de datos. Indica
dónde termina HTTPS. -->

1. *El usuario abre `https://<dominio>`*
2.

Puertos abiertos a Internet:

| Puerto | Servicio | ¿Por qué debe estar abierto? |
|---|---|---|
| | | |

## 4.5 Reverse proxy

Archivo en el repositorio: <!-- ej. deploy/Caddyfile -->

Evidencia de prueba local:

```
<!-- pega la salida de curl --resolve contra cada nombre de dominio -->
```

## 4.6 Transferencia de archivos

| Qué se transfiere | Método | Autenticación | Frecuencia |
|---|---|---|---|
| *Respaldos de base de datos* | *SFTP* | *Llave SSH de un usuario solo SFTP* | *Diaria* |
| | | | |
