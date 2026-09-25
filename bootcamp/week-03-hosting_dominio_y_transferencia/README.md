# 📚 Semana 03 — Hosting, Dominio y Transferencia de Archivos

> 🚧 Esqueleto — contenido de teoría, prácticas y proyecto pendiente.

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, el aprendiz será capaz de:

1. Comparar tipos de hosting: estático, compartido, VPS, PaaS y contenedores
2. Explicar el funcionamiento de dominios y DNS (registros A, AAAA, CNAME, TXT)
3. Publicar un servicio detrás de un reverse proxy con HTTPS automático (Caddy)
4. Diferenciar FTP, FTPS y SFTP, y transferir archivos con `scp` / `rsync` de forma segura

---

## 🧭 Trazabilidad RAP

| Saberes de conceptos | Saberes de proceso |
|---|---|
| C5, C6 | P1 |

**Criterios de evaluación:**

- **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado

Ver [`docs/plan-curricular.md`](../../docs/plan-curricular.md).

---

## 📝 Contenidos

- Tipos de hosting y criterios de selección
- Gestores de contenido: qué son y cuándo aplican (conceptual)
- Dominios, DNS, propagación; dominios gratuitos (DuckDNS, subdominios PaaS)
- Reverse proxy y certificados TLS
- FTP: concepto y riesgos; transferencia segura con SFTP, `scp`, `rsync`
- Práctica: publicar la app de referencia detrás de Caddy y subir artefactos por SFTP

---

## ⏱️ Distribución del Tiempo (17 horas)

```
🅰️ Ambiente de Formación     ████████████░░░░░   12h  (70%)
🅱️ Trabajo Autónomo          █████░░░░░░░░░░░░    5h  (30%)
```

- **🅰️ Ambiente de Formación (12h)**: teoría guiada + práctica sobre la app de referencia ([`referencia/`](../../referencia/README.md)).
- **🅱️ Trabajo Autónomo (5h)**: aplicar la práctica al proyecto real y completar la sección del Plan de Implantación.

---

## 📌 Entregable de la Semana

Estrategia de hosting y dominio del proyecto real — sección de [`docs/plan-implantacion-template.md`](../../docs/plan-implantacion-template.md).

---

## 🎓 Conceptos Clave

`DNS`, `Registro A / CNAME`, `Reverse proxy`, `TLS`, `SFTP`, `rsync`

---

## 🔗 Navegación

| ← Anterior | → Siguiente |
|-----------|-------------|
| [← Semana 02 — Plan de Instalación, Migración y Respaldo](../week-02-plan_de_instalacion_migracion_y_respaldo/README.md) | [Semana 04 — Despliegue Local y en la Nube →](../week-04-despliegue_local_y_nube/README.md) |

---

*Cadena de Formación · Implantación del Software · Semana 3 de 9 + 1 opcional*
