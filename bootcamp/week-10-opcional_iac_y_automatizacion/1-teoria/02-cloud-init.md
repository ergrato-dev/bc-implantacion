# cloud-init: el Primer Arranque

## 🎯 Objetivos

- Explicar qué hace cloud-init y cuándo se ejecuta
- Escribir un archivo `user-data` que deje un servidor listo para Ansible
- Validar el archivo antes de usarlo
- Diagnosticar un primer arranque que falló

## 📋 Contenido

### 1. ¿Qué es?

cloud-init es el estándar para configurar una máquina Linux **en su primer arranque**. Viene
instalado en las imágenes de Ubuntu Server para nube y virtualización. Al encender, lee los datos
que le entregó quien creó la máquina (el proveedor de nube, Multipass, Proxmox, LXD, OpenTofu) y
los aplica una sola vez.

| Datos | Contenido |
|---|---|
| `meta-data` | Identidad de la instancia (lo pone el proveedor) |
| `user-data` | Lo que tú quieres: usuarios, llaves, paquetes, archivos, comandos |
| `network-config` | Red, si no se usa DHCP |

### 2. `user-data` con `#cloud-config`

El archivo empieza con `#cloud-config` y es YAML. El de la app de referencia:
[`user-data.yaml`](../2-practicas/laboratorio/cloud-init/user-data.yaml).

| Módulo | Para qué | En el ejemplo |
|---|---|---|
| `users` | Crear usuarios con llaves y `sudo` | `ubuntu`, solo con llave |
| `ssh_pwauth`, `disable_root` | Endurecer SSH (semana 6) | Sin contraseñas, sin `root` |
| `package_update`, `package_upgrade`, `packages` | Parches e instalación | `python3`, `unattended-upgrades` |
| `write_files` | Crear archivos de configuración | `sshd_config.d/10-endurecer.conf` |
| `runcmd` | Comandos al final | Recargar SSH |
| `timezone`, `hostname` | Identidad | `America/Bogota` |

### 3. Alcance: poco y en el primer arranque

cloud-init corre **una vez**. Si después quieres cambiar algo, tendrías que recrear la máquina.
Por eso se usa para lo mínimo que permite llegar al servidor —usuario, llave, SSH seguro, Python—
y el resto lo hace Ansible, que sí se puede volver a ejecutar.

| cloud-init | Ansible |
|---|---|
| Primer arranque, una vez | Cuando quieras, las veces que quieras |
| Lo entrega el proveedor | Se conecta por SSH desde el nodo de control |
| Mínimo para ser alcanzable | Todo lo demás |

### 4. Validar antes de usar

Un error de sintaxis en `user-data` se descubre con la máquina ya creada y, a veces, sin forma
de entrar. Se valida antes:

```bash
cloud-init schema --config-file user-data.yaml
```

Detecta claves que no existen, tipos equivocados y opciones obsoletas.

### 5. Diagnóstico

Si una máquina no quedó como se esperaba, en la propia máquina (por consola del proveedor si SSH
no funciona):

```bash
cloud-init status --long          # ¿terminó? ¿con errores?
sudo cat /var/log/cloud-init-output.log
sudo cloud-init query userdata    # lo que realmente recibió
```

### 6. Secretos

`user-data` puede leerlo cualquiera con acceso a la metadata de la instancia (y queda en
`/var/lib/cloud` del servidor). Lleva llaves **públicas**, nunca contraseñas ni tokens.

### 7. Aplicación al proyecto real

Escribe el `user-data` que dejaría listo para Ansible el servidor de tu proyecto y valídalo.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
