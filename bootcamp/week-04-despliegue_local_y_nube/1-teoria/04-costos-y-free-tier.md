# Costos en la Nube y Límites del Free Tier

## 🎯 Objetivos

- Identificar cómo cobra la nube y qué genera costos inesperados
- Leer los límites de un plan gratuito antes de depender de él
- Estimar el costo mensual de un despliegue con calculadoras oficiales
- Comparar el costo total de servidor propio, IaaS y PaaS

## 📋 Contenido

### 1. ¿Qué se cobra?

| Concepto | Unidad típica | Ejemplo |
|---|---|---|
| Cómputo | Hora de instancia, vCPU-hora | Una VM encendida todo el mes ≈ 730 horas |
| Memoria | GB-hora | Planes PaaS por tamaño de RAM |
| Almacenamiento | GB-mes | Disco de la VM, base de datos, respaldos |
| Transferencia de salida | GB | Datos que salen hacia Internet |
| Peticiones / operaciones | Millones de peticiones | Funciones serverless, almacenamiento de objetos |
| IP pública, dominio, certificado | Mensual / anual | Algunos proveedores cobran la IP fija |

Costos que suelen sorprender:

- Recursos **olvidados encendidos** (una VM de pruebas, un disco sin usar, una IP reservada)
- **Respaldos y snapshots** acumulados
- **Transferencia de salida** alta (descargas, imágenes pesadas)
- Pasar el límite del free tier sin darse cuenta

Siempre configura una **alerta de presupuesto** en la cuenta del proveedor.

### 2. Free tier: leer la letra pequeña

Los planes gratuitos cambian con frecuencia. Antes de depender de uno, verifica en la página
oficial de precios:

| Pregunta | Por qué importa |
|---|---|
| ¿El servicio se **suspende** por inactividad? | El primer usuario del día espera segundos o minutos (arranque en frío) |
| ¿Tiene **fecha de vencimiento**? | Algunas bases gratuitas se eliminan después de un tiempo |
| ¿Cuáles son los límites de horas, RAM, almacenamiento y conexiones? | Al pasarlos, el servicio se detiene o empieza a cobrar |
| ¿Exige tarjeta de crédito? | Riesgo de cobros si se pasa el límite |
| ¿Incluye respaldos o recuperación a un punto en el tiempo? | Afecta el plan de respaldo (semana 2) |

Ejemplos de comportamiento habitual (verifica los valores vigentes):

- **Render** (plan gratuito, consultado en septiembre de 2026): el servicio web se suspende tras
  15 minutos sin tráfico y tarda alrededor de un minuto en despertar; los archivos escritos en el
  disco del contenedor **se pierden** al suspenderse o redesplegarse; hay un cupo mensual de horas
  gratuitas por cuenta; y su PostgreSQL gratuito **vence a los 30 días**. Por eso en las
  prácticas la base de datos va en Neon y la app no guarda archivos en disco.
- **Neon** (plan gratuito): la base se suspende sin actividad (*scale to zero*) y tiene límites
  de almacenamiento y de horas de cómputo.
- **Supabase** (plan gratuito): los proyectos se pausan tras un periodo de inactividad.

Conclusión: el free tier sirve para **aprender, demostrar y proyectos pequeños**. Para un cliente
con usuarios reales se presupuesta un plan pago.

### 3. Estimar con calculadoras

- [AWS Pricing Calculator](https://calculator.aws/)
- [Azure Pricing Calculator](https://azure.microsoft.com/es-es/pricing/calculator/)
- [Google Cloud Pricing Calculator](https://cloud.google.com/products/calculator)
- Páginas de precios de Render, Neon y Supabase

Procedimiento:

1. Parte de la matriz de requisitos **recomendados** de la semana 1 (no de los mínimos).
2. Elige región y tipo de instancia o plan equivalente.
3. Suma cómputo + almacenamiento + respaldos + transferencia estimada.
4. Calcula el costo **mensual y anual**, en la moneda que usa el proveedor, y anota la fecha
   de la consulta (los precios cambian).

### 4. Costo total, no solo la factura

| | Servidor propio | IaaS (VPS) | PaaS |
|---|---|---|---|
| Inversión inicial | Alta (hardware) | Nula | Nula |
| Pago mensual | Energía, conectividad | Instancia + disco | Plan |
| Horas de administración | Muchas: hardware, SO, parches | Medias: SO, parches | Pocas |
| Escalar | Comprar hardware | Cambiar tamaño de VM | Cambiar plan |

Las horas de administración cuestan: un PaaS más caro en factura puede ser más barato en total.

### 5. Aplicación al proyecto real

Estima el costo mensual y anual de tu proyecto en al menos dos alternativas (por ejemplo, VPS
en una gran nube y PaaS + base gestionada) y recomienda una al cliente.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
