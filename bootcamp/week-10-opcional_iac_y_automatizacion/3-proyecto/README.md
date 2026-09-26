# Proyecto Semana 10 — Plan de Instalación Ejecutable

## 📋 Instrucciones

Convierte la sección 5 (instalación) y la 7 (seguridad) del Plan de Implantación de tu proyecto
real en código, y documenta cómo usarlo en una nueva subsección 5.10, con
[`starter/entregable-s10-instalacion-ejecutable.md`](starter/entregable-s10-instalacion-ejecutable.md).

En el repositorio del proyecto, carpeta `infra/`:

- `cloud-init/user-data.yaml` validado con `cloud-init schema`
- `ansible/`: inventario de ejemplo (sin IPs reales), `group_vars/`, plantillas y el playbook
- `ansible/group_vars/<grupo>/vault.yml` cifrado con Ansible Vault (la contraseña del vault **no**
  va al repositorio)
- Opcional: `opentofu/` con la infraestructura que tenga sentido describir
- `.gitignore` con llaves, contraseña del vault y archivos de estado

Modelo: [`2-practicas/laboratorio/ansible/`](../2-practicas/laboratorio/ansible/instalar-biblioteca.yml).

Y una prueba: el playbook sobre un servidor **limpio** (el contenedor del laboratorio, la VM
del laboratorio o una VM de Multipass) termina con la prueba de humo en verde, y la segunda
ejecución da `changed=0`.

## ❓ Preguntas Guía

- ¿Qué pasos del simulacro de la semana 9 habrían desaparecido con el playbook?
- ¿Qué sigue siendo manual y por qué (restaurar datos, crear cuentas en la nube, DNS)?
- ¿Quién guarda la contraseña del vault y cómo la recibe quien instala?

## ✅ Checklist de Cierre

- [ ] `user-data` validado
- [ ] Playbook que instala el proyecto en un servidor limpio con prueba de humo en verde
- [ ] Segunda ejecución con `changed=0`, con evidencia
- [ ] Secretos en Vault; nada sensible en el repositorio
- [ ] Subsección 5.10 del plan: cómo ejecutar, variables y qué queda manual
