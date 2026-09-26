# Entregable S10 — Instalación Ejecutable (subsección 5.10 del plan)

<!-- 📝 Instrucción: esta subsección se agrega a la sección 5 del Plan de Implantación del
proyecto real. Los valores en cursiva son ejemplos parciales de la app de referencia. Sin IPs,
usuarios ni contraseñas reales. -->

| Campo | Valor |
|---|---|
| Proyecto | |
| Equipo | |
| Versión del plan | |
| Fecha | |

---

## 5.10 Instalación automatizada

### Qué hace cada herramienta

| Herramienta | Archivo | Qué automatiza |
|---|---|---|
| cloud-init | *`infra/cloud-init/user-data.yaml`* | *Usuario con llave, SSH endurecido, Python, parches* |
| Ansible | *`infra/ansible/instalar-<proyecto>.yml`* | *Secciones 5.3 a 5.7 y 7* |
| OpenTofu (opcional) | | |

### Prerrequisitos del nodo de control

| Requisito | Versión |
|---|---|
| Ansible | |
| Colecciones | *`community.general`, `ansible.posix`* |
| Llave SSH del servidor | *En el equipo de quien instala, nunca en el repositorio* |
| Contraseña del vault | *La entrega el responsable por otro canal* |

### Variables

| Variable | Dónde | Descripción | Ejemplo |
|---|---|---|---|
| *`app_version`* | *`group_vars/<grupo>/vars.yml`* | *Versión a instalar* | *`1.0.0`* |
| *`vault_postgres_password`* | *`vault.yml` (cifrado)* | *Contraseña de la base* | *—* |
| | | | |

### Ejecución

```bash
# 1. Comprobar acceso
# 2. Ver qué cambiaría
# 3. Aplicar
# 4. Comprobar idempotencia
```

### Evidencia

Primera ejecución sobre un servidor limpio (`PLAY RECAP` y resultado de la prueba de humo):

```
<!-- pega aquí -->
```

Segunda ejecución:

```
<!-- pega aquí: debe decir changed=0 -->
```

### Qué sigue siendo manual

| Paso | Por qué no está automatizado | Sección del plan |
|---|---|---|
| *Restaurar datos de un respaldo* | *Decisión humana: qué instantánea, comparar huellas* | *3.3* |
| | | |
