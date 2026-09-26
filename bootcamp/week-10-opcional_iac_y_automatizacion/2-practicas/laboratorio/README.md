# 🧪 Laboratorio de la Semana 10

Tres carpetas, una por herramienta:

| Carpeta | Contenido | Práctica |
|---|---|---|
| [`cloud-init/`](cloud-init/user-data.yaml) | `user-data.yaml`: primer arranque de un Ubuntu Server | [01](../01-cloud-init/README.md) |
| [`ansible/`](ansible/instalar-biblioteca.yml) | Inventario, variables, plantillas y el playbook que instala la app de referencia | [02](../02-ansible/README.md) |
| [`opentofu/`](opentofu/main.tf) | La app de referencia descrita como infraestructura, con el Docker local | [03](../03-opentofu/README.md) |

Para la práctica 02, `compose.yaml` levanta dos contenedores:

| Servicio | Papel |
|---|---|
| `servidor` | Ubuntu 24.04 "recién creado": systemd, SSH, Python y el usuario `ubuntu` con `sudo`. Nada más |
| `control` | Nodo de control con Ansible; ve la carpeta `ansible/` como `/trabajo` |

```bash
docker compose up -d --build
docker compose exec control bash          # consola del nodo de control
docker compose down -v                    # borrar todo al terminar
```

La app que instala Ansible queda en `https://biblioteca.lab.test:8443` (puerto 443 del
`servidor` publicado en el 8443 de tu equipo).

## Por qué el servidor corre privilegiado

Dentro del `servidor` corren systemd y Docker, como en una VM. Eso exige `privileged: true` y
volúmenes propios para `/var/lib/docker` y `/var/lib/containerd`. Es una concesión **solo de
laboratorio**: con una VM real (Multipass, la VM del laboratorio) no hace falta nada de esto.

Si tienes una VM Ubuntu disponible, úsala en lugar del contenedor: cambia `ansible_host` en
`ansible/inventario.ini` y pon tu llave pública en la VM (o créala con el `user-data` de la
práctica 01).
