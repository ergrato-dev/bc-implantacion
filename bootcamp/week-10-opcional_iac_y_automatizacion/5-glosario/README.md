# 🎓 Glosario — Semana 10

| Término | Definición breve |
|---|---|
| **IaC** | Infraestructura como código: describir servidores y servicios en archivos ejecutables |
| **Imperativo** | Describir los pasos para llegar a un resultado |
| **Declarativo** | Describir el estado deseado; la herramienta decide los pasos |
| **Idempotencia** | Ejecutar una o muchas veces deja el mismo resultado |
| **Convergencia** | Llevar el sistema al estado declarado desde cualquier punto de partida |
| **Deriva (*drift*)** | Diferencia entre lo declarado y lo real, casi siempre por cambios a mano |
| **cloud-init** | Estándar para configurar una máquina en su primer arranque |
| **`user-data`** | Configuración que se entrega a cloud-init al crear la máquina |
| **Nodo de control** | Máquina desde la que Ansible administra los servidores |
| **Inventario** | Lista de servidores y grupos que administra Ansible |
| **Módulo** | Unidad de trabajo de Ansible que comprueba antes de cambiar |
| **Playbook** | Archivo YAML con tareas para un grupo de servidores |
| **Tarea ad hoc** | Comando suelto de Ansible, sin playbook |
| **Handler** | Tarea que solo corre si otra la notificó con cambios |
| **Plantilla (Jinja2)** | Archivo con variables que Ansible completa |
| **Ansible Vault** | Cifrado de archivos con secretos para versionarlos con seguridad |
| **Rol** | Paquete reutilizable de tareas, plantillas y variables de Ansible |
| **`--check --diff`** | Modo de Ansible que muestra qué cambiaría sin cambiarlo |
| **OpenTofu** | Herramienta de código abierto para aprovisionar infraestructura, bifurcación de Terraform |
| **Proveedor** | *Plugin* de OpenTofu que habla con una plataforma |
| **Recurso** | Objeto de infraestructura declarado en OpenTofu |
| **Estado** | Registro de OpenTofu de lo que creó; contiene secretos |
| **`plan` / `apply`** | Mostrar los cambios / ejecutarlos |
| **Reemplazo (`-/+`)** | Destruir y volver a crear un recurso |
| **`prevent_destroy`** | Protección que impide destruir un recurso |
| **Servidor mascota / ganado** | Configurado a mano e insustituible / recreable desde código |
