# 🎓 Glosario — Semana 7

| Término | Definición breve |
|---|---|
| **Integración continua (CI)** | Construir y probar automáticamente cada cambio del código |
| **Entrega continua** | Dejar cada versión lista para desplegar, con una decisión humana final |
| **Despliegue continuo** | Llevar cada versión a producción sin intervención humana |
| **Pipeline** | Secuencia automatizada de etapas: construir, probar, publicar, desplegar, verificar |
| **Workflow** | Archivo YAML de GitHub Actions que define un pipeline |
| **Job** | Conjunto de pasos que corre en una máquina limpia |
| **Runner** | Máquina que ejecuta los jobs |
| **`workflow_dispatch`** | Evento para lanzar un workflow a mano, con entradas |
| **`GITHUB_TOKEN`** | Credencial temporal que GitHub crea para cada ejecución |
| **Ambiente (*environment*)** | Grupo de secretos y reglas (revisores) para un destino, como producción |
| **GHCR** | GitHub Container Registry: registro de imágenes de GitHub |
| **Registro de imágenes** | Servidor que guarda y entrega imágenes de contenedor |
| **Deploy hook** | URL secreta que, al llamarla, pide un despliegue al PaaS |
| **Despliegue por empuje** | El pipeline se conecta al destino y despliega |
| **Despliegue por arrastre** | El destino trae la versión publicada del registro |
| **Azul-verde** | Dos ambientes completos; el tráfico cambia de uno al otro |
| **Canary** | La versión nueva recibe primero una parte pequeña del tráfico |
| **Rollback** | Volver a la versión anterior |
| **Expand/contract** | Cambiar el esquema en dos pasos para que la versión anterior siga funcionando |
| **Check obligatorio** | Resultado de CI que debe estar en verde para fusionar a una rama protegida |
| **Indicadores DORA** | Frecuencia de despliegue, tiempo de entrega, tasa de fallos y tiempo de recuperación |
| **Monitoreo de caja negra** | Probar el servicio desde afuera, como un usuario |
| **Uptime Kuma** | Herramienta de código abierto para monitorear disponibilidad y enviar alertas |
| **Monitor de palabra clave** | Verifica que la respuesta contenga un texto esperado |
| **Monitor de latido (*push*)** | Alerta cuando **no** recibe una señal en el tiempo esperado |
| **Webhook** | Petición HTTP que un sistema envía a otro para avisar de un evento |
| **Fatiga de alertas** | Ignorar alertas por recibir demasiadas sin acción clara |
| **Página de estado** | Página pública con la disponibilidad de los servicios |
