# 🧪 Laboratorio de la Semana 8

Un servidor Ubuntu construido **sin actualizar** a propósito, para practicar las actualizaciones
de seguridad y las rutinas de mantenimiento, y un archivo de dependencias antiguas para auditar.

| Elemento | Qué es | Práctica |
|---|---|---|
| `servidor` | Ubuntu 24.04 con `unattended-upgrades`, cron y el script [`revisar-servidor`](servidor/revisar-servidor.sh) | [02](../02-mantenimiento-del-servidor/README.md) |
| [`auditoria/requirements-antiguo.txt`](auditoria/requirements-antiguo.txt) | Dependencias de 2021 de un proyecto "heredado" | [01](../01-dependencias-y-vulnerabilidades/README.md) |

```
laboratorio/
├── compose.yaml
├── servidor/
│   ├── Dockerfile               ← Ubuntu 24.04 sin actualizar
│   └── revisar-servidor.sh      ← revisión rutinaria: disco, parches, reinicio, respaldos
└── auditoria/requirements-antiguo.txt
```

## Comandos

Desde esta carpeta:

```bash
docker compose up -d --build --wait
docker compose exec servidor bash          # consola root del servidor
docker compose down -v                     # borrar todo al terminar
```

Las prácticas 01, 03 y 04 trabajan sobre tu repositorio `~/biblioteca` en GitHub.

## Diferencias con la VM real

| En el laboratorio | En la VM Ubuntu del laboratorio |
|---|---|
| La imagen de Docker trae un archivo que desactiva las tareas periódicas de `apt` | No existe: basta con activar `unattended-upgrades` |
| Sin `systemd`: las actualizaciones automáticas se ejecutan a mano con `unattended-upgrade` | Un temporizador de `systemd` las ejecuta cada día |
| "Reiniciar" es recrear el contenedor | `sudo reboot` en la ventana de mantenimiento |
