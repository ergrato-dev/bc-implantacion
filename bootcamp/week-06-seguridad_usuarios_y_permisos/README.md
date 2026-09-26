# 📚 Semana 06 — Seguridad, Usuarios y Permisos

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, el aprendiz será capaz de:

1. Crear usuarios y grupos en Linux, asignar permisos y delegar privilegios con `sudo`
2. Endurecer el acceso: SSH solo con llave y firewall UFW que niega por defecto
3. Definir roles en PostgreSQL con mínimo privilegio y validarlos con pruebas negativas
4. Gestionar secretos sin exponerlos en el repositorio y rotarlos
5. Automatizar un respaldo cifrado (restic + cron) con copia fuera del sitio y probar una restauración de desastre

---

## 🧭 Trazabilidad RAP

| Saberes de conceptos | Saberes de proceso |
|---|---|
| C2, C3 | P1, P4 |

**Criterios de evaluación:**

- **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado
- **CE-4** — Diseña el plan de respaldo de los datos para mitigar riesgos

Ver [`docs/plan-curricular.md`](../../docs/plan-curricular.md).

---

## 📋 Requisitos Previos

- Semana 2: plan de respaldo v0 del proyecto real (RPO, RTO, 3-2-1)
- Semana 3: llaves SSH y SFTP
- Semanas 4 y 5: servidor del proyecto desplegado y huellas de validación
- Docker Engine + Compose y un cliente SSH

---

## 🗂️ Estructura de la Semana

```
week-06-seguridad_usuarios_y_permisos/
├── README.md                                  ← Estás aquí
├── rubrica-evaluacion.md
├── 0-assets/                                  ← 4 diagramas SVG
├── 1-teoria/
│   ├── 01-usuarios-grupos-y-permisos.md
│   ├── 02-acceso-remoto-y-firewall.md
│   ├── 03-roles-y-privilegios-en-la-base-de-datos.md
│   ├── 04-gestion-de-secretos.md
│   └── 05-respaldo-automatizado-y-cifrado.md
├── 2-practicas/
│   ├── laboratorio/                           ← servidor Ubuntu + app + PostgreSQL + repositorio externo
│   ├── 01-usuarios-sudo-y-ssh/
│   ├── 02-roles-y-secretos/
│   └── 03-respaldo-cifrado-y-restauracion/
├── 3-proyecto/
│   ├── README.md
│   └── starter/entregable-s06-seguridad-y-respaldo.md
├── 4-recursos/{ebooks-free,videografia,webgrafia}/
└── 5-glosario/
```

---

## 📝 Contenidos

| # | Tema | Tipo |
|---|---|---|
| 1 | [Usuarios, grupos y permisos en Linux](1-teoria/01-usuarios-grupos-y-permisos.md) | Teoría |
| 2 | [Acceso remoto seguro y firewall](1-teoria/02-acceso-remoto-y-firewall.md) | Teoría |
| 3 | [Roles y privilegios en la base de datos](1-teoria/03-roles-y-privilegios-en-la-base-de-datos.md) | Teoría |
| 4 | [Gestión de secretos](1-teoria/04-gestion-de-secretos.md) | Teoría |
| 5 | [Respaldo automatizado y cifrado](1-teoria/05-respaldo-automatizado-y-cifrado.md) | Teoría |
| 6 | [Laboratorio de la semana](2-practicas/laboratorio/README.md) | Preparación |
| 7 | [Usuarios, sudo, SSH y firewall](2-practicas/01-usuarios-sudo-y-ssh/README.md) | Práctica |
| 8 | [Roles de base de datos y rotación de secretos](2-practicas/02-roles-y-secretos/README.md) | Práctica |
| 9 | [Respaldo cifrado automático y restauración de desastre](2-practicas/03-respaldo-cifrado-y-restauracion/README.md) | Práctica |
| 10 | [Seguridad, usuarios y plan de respaldo final](3-proyecto/README.md) | Proyecto |

---

## ⏱️ Distribución del Tiempo (17 horas)

```
🅰️ Ambiente de Formación     ████████████░░░░░   12h  (70%)
🅱️ Trabajo Autónomo          █████░░░░░░░░░░░░    5h  (30%)
```

### 🅰️ Ambiente de Formación (12h)

| Bloque | Horas | Actividad |
|---|:---:|---|
| 1 | 1,5h | Teoría 01 y 02 — usuarios, permisos, SSH y firewall |
| 2 | 2,5h | Práctica 01 — usuarios, sudo, SSH y firewall |
| 3 | 1h | Teoría 03 y 04 — roles de base de datos y secretos |
| 4 | 2h | Práctica 02 — roles y rotación de secretos |
| 5 | 1h | Teoría 05 — respaldo automatizado y cifrado |
| 6 | 3h | Práctica 03 — respaldo cifrado y restauración de desastre |
| 7 | 1h | Arranque del entregable: matriz de usuarios y roles del proyecto real |

### 🅱️ Trabajo Autónomo (5h)

- Aplicar el endurecimiento, los roles y el respaldo automático al servidor del proyecto real
- Ensayar la restauración de desastre con otra persona del equipo
- Completar la sección 7 y el plan de respaldo final (sección 3) del Plan de Implantación

---

## 📌 Entregable de la Semana

**Matriz de usuarios/roles + plan de respaldo final** del proyecto real — sección 7 y sección 3
(versión final) de [`docs/plan-implantacion-template.md`](../../docs/plan-implantacion-template.md).
Ver [`3-proyecto/`](3-proyecto/README.md).

---

## 🎓 Conceptos Clave

`Mínimo privilegio` · `Defensa en profundidad` · `sudoers` · `setgid` · `Llave SSH` · `UFW` ·
`Rol` · `ALTER DEFAULT PRIVILEGES` · `Secreto` · `Rotación` · `restic` · `Solo-agregar` ·
`Retención` · `Restauración de desastre`

Glosario completo: [`5-glosario/`](5-glosario/README.md).

---

## ✅ Checklist de Verificación

- [ ] Cada persona del equipo tiene su cuenta y su llave en el servidor; nadie entra como `root`
- [ ] El servidor rechaza contraseñas por SSH y solo abre los puertos necesarios
- [ ] Mi app se conecta con un rol que no puede borrar ni alterar tablas
- [ ] Sé dónde vive cada secreto y cómo rotarlo
- [ ] Otra persona restauró mi respaldo cifrado en un servidor nuevo, con huellas iguales

---

## 🔗 Navegación

| ← Anterior | → Siguiente |
|-----------|-------------|
| [← Semana 05 — Configuración y Pruebas en Servidor](../week-05-configuracion_y_pruebas_en_servidor/README.md) | [Semana 07 — CI/CD de Despliegue y Monitoreo →](../week-07-cicd_de_despliegue_y_monitoreo/README.md) |

---

*Cadena de Formación · Implantación del Software · Semana 6 de 9 + 1 opcional*
