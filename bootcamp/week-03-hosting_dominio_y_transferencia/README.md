# 📚 Semana 03 — Hosting, Dominio y Transferencia de Archivos

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, el aprendiz será capaz de:

1. Comparar tipos de hosting (estático, compartido, VPS, dedicado, PaaS) según control y responsabilidad
2. Explicar el concepto de gestor de contenidos y ubicarlo dentro de las opciones de hosting
3. Explicar la resolución DNS y configurar registros A, AAAA, CNAME, TXT, MX y NS con su TTL
4. Publicar varios servicios en un servidor detrás de un reverse proxy con HTTPS (Caddy)
5. Diferenciar FTP, FTPS y SFTP, y transferir archivos de forma segura con llaves SSH

---

## 🧭 Trazabilidad RAP

| Saberes de conceptos | Saberes de proceso |
|---|---|
| C5, C6 | P1 |

**Criterios de evaluación:**

- **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado

Ver [`docs/plan-curricular.md`](../../docs/plan-curricular.md).

---

## 📋 Requisitos Previos

- Semanas 1 y 2: ficha técnica y planes del proyecto real
- Docker Engine + Compose; cliente OpenSSH (`ssh`, `sftp`, `scp`); `dig` (paquete `dnsutils`)
- Conexión a Internet (práctica 01)

---

## 🗂️ Estructura de la Semana

```
week-03-hosting_dominio_y_transferencia/
├── README.md                              ← Estás aquí
├── rubrica-evaluacion.md
├── 0-assets/                              ← 4 diagramas SVG
├── 1-teoria/
│   ├── 01-tipos-de-hosting.md
│   ├── 02-dominios-y-dns.md
│   ├── 03-servidor-web-y-reverse-proxy.md
│   └── 04-transferencia-de-archivos.md
├── 2-practicas/
│   ├── laboratorio/                       ← Caddy + API + SFTP en Docker Compose
│   ├── 01-dns-con-dig/
│   ├── 02-sitio-y-reverse-proxy/
│   └── 03-transferencia-sftp/
├── 3-proyecto/
│   ├── README.md
│   └── starter/entregable-s03-hosting-y-dominio.md
├── 4-recursos/{ebooks-free,videografia,webgrafia}/
└── 5-glosario/
```

---

## 📝 Contenidos

| # | Tema | Tipo |
|---|---|---|
| 1 | [Tipos de hosting](1-teoria/01-tipos-de-hosting.md) | Teoría |
| 2 | [Dominios y DNS](1-teoria/02-dominios-y-dns.md) | Teoría |
| 3 | [Servidor web, reverse proxy y HTTPS](1-teoria/03-servidor-web-y-reverse-proxy.md) | Teoría |
| 4 | [Transferencia de archivos: FTP, SFTP, `scp` y `rsync`](1-teoria/04-transferencia-de-archivos.md) | Teoría |
| 5 | [Laboratorio de la semana](2-practicas/laboratorio/README.md) | Preparación |
| 6 | [Consultas DNS con `dig`](2-practicas/01-dns-con-dig/README.md) | Práctica |
| 7 | [Sitios por nombre, reverse proxy y HTTPS](2-practicas/02-sitio-y-reverse-proxy/README.md) | Práctica |
| 8 | [Publicar archivos por SFTP](2-practicas/03-transferencia-sftp/README.md) | Práctica |
| 9 | [Estrategia de hosting y dominio](3-proyecto/README.md) | Proyecto |

---

## ⏱️ Distribución del Tiempo (17 horas)

```
🅰️ Ambiente de Formación     ████████████░░░░░   12h  (70%)
🅱️ Trabajo Autónomo          █████░░░░░░░░░░░░    5h  (30%)
```

### 🅰️ Ambiente de Formación (12h)

| Bloque | Horas | Actividad |
|---|:---:|---|
| 1 | 1h | Teoría 01 — tipos de hosting |
| 2 | 1h | Teoría 02 — dominios y DNS |
| 3 | 1,5h | Práctica 01 — DNS con `dig` |
| 4 | 1,5h | Teoría 03 — servidor web, reverse proxy, HTTPS |
| 5 | 2,5h | Práctica 02 — sitios por nombre y reverse proxy |
| 6 | 1h | Teoría 04 — transferencia de archivos |
| 7 | 2h | Práctica 03 — SFTP con llaves |
| 8 | 1,5h | Arranque del entregable: reverse proxy del proyecto real |

### 🅱️ Trabajo Autónomo (5h)

- Configurar y probar localmente el reverse proxy del proyecto real
- Completar la sección 4 del Plan de Implantación
- Repasar el glosario

---

## 📌 Entregable de la Semana

**Estrategia de hosting y dominio** del proyecto real — sección 4 de
[`docs/plan-implantacion-template.md`](../../docs/plan-implantacion-template.md), con la
configuración del reverse proxy probada localmente. Ver [`3-proyecto/`](3-proyecto/README.md).

---

## 🎓 Conceptos Clave

`VPS` · `PaaS` · `DNS` · `Registro A / CNAME` · `TTL` · `Reverse proxy` · `Virtual host` ·
`TLS` · `SFTP` · `Llave SSH`

Glosario completo: [`5-glosario/`](5-glosario/README.md).

---

## ✅ Checklist de Verificación

- [ ] Sé qué administro yo y qué el proveedor en cada tipo de hosting
- [ ] Interpreto la salida de `dig` y sé para qué sirve el TTL
- [ ] Publiqué dos servicios en un servidor diferenciados por nombre, con HTTPS
- [ ] Publiqué archivos por SFTP con llave SSH, sin contraseña
- [ ] Puedo explicar por qué FTP plano no se usa
- [ ] Mi entregable no contiene IPs, hosts ni credenciales reales

---

## 🔗 Navegación

| ← Anterior | → Siguiente |
|-----------|-------------|
| [← Semana 02 — Plan de Instalación, Migración y Respaldo](../week-02-plan_de_instalacion_migracion_y_respaldo/README.md) | [Semana 04 — Despliegue Local y en la Nube →](../week-04-despliegue_local_y_nube/README.md) |

---

## 💡 Consejos para esta Semana

- **Decide el hosting por componente**, no para todo el proyecto a la vez.
- **Baja el TTL antes de un cambio**, no después.
- **Un solo punto de entrada.** Si tu base de datos tiene un puerto abierto a Internet, algo está mal.
- **La llave privada no sale de tu equipo.** Nunca va al repositorio ni a un chat.

---

*Cadena de Formación · Implantación del Software · Semana 3 de 9 + 1 opcional*
