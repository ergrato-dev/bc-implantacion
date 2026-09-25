# Dimensionamiento y Requisitos Mínimos

## 🎯 Objetivos

- Diferenciar requisitos mínimos y recomendados
- Estimar CPU, RAM, disco, IOPS y red a partir de las características del software
- Medir el consumo real de un software en ejecución en vez de adivinarlo
- Construir la matriz de requisitos que exige el criterio CE-2

## 📋 Contenido

### 1. Mínimo vs recomendado

| | Mínimo | Recomendado |
|---|---|---|
| Qué garantiza | El software **arranca** y responde | El software opera con la carga esperada y margen |
| Para qué sirve | Descartar un servidor que no alcanza | Dimensionar la compra o el plan de nube |
| Riesgo de usarlo en producción | Alto: cualquier pico lo satura | Bajo |

El plan de implantación debe declarar **ambos**. Un servidor que cumple solo el mínimo es válido
para pruebas, no para producción.

### 2. Los cinco recursos

| Recurso | Unidad | Qué lo consume | Cómo medirlo en Linux |
|---|---|---|---|
| CPU | núcleos / vCPU | Peticiones concurrentes, cálculos, compresión | `nproc`, `lscpu`, `top` |
| RAM | GB | Procesos de la app, caché de la base de datos | `free -h`, `docker stats` |
| Disco (capacidad) | GB | Sistema, imágenes, datos, logs, respaldos locales | `df -h`, `du -sh` |
| Disco (rendimiento) | IOPS, MB/s | Base de datos, escrituras frecuentes | `iostat`, `fio` |
| Red | Mbps | Usuarios concurrentes × tamaño de respuesta | `ip -br addr`, `ss -tuln` |

Referencia aproximada de IOPS aleatorias por tipo de disco (varía por modelo):

| Tipo | IOPS aproximadas |
|---|---|
| HDD 7200 rpm | ~100 |
| SSD SATA | decenas de miles |
| SSD NVMe | cientos de miles |

### 3. Método de estimación

1. **Inventario de servicios**: qué procesos corren (API, frontend, base de datos, proxy).
2. **Medición en reposo**: levanta el stack y observa el consumo con `docker stats`.
3. **Medición con carga**: simula usuarios concurrentes y observa el pico.
4. **Suma y margen**: suma los picos de cada servicio + sistema operativo y agrega **30-50 %** de
   margen para crecimiento y picos imprevistos.
5. **Crecimiento de datos**: estima registros por mes × tamaño promedio × meses de vida útil.

Ejemplo **ilustrativo** (app de referencia, 50 usuarios concurrentes):

| Servicio | RAM pico medida | CPU pico |
|---|---|---|
| Sistema operativo | 400 MB | 0,2 |
| PostgreSQL | 300 MB | 0,5 |
| API FastAPI | 250 MB | 0,6 |
| Frontend (Nginx estático) | 20 MB | 0,1 |
| **Total** | **970 MB** | **1,4** |
| **+ 50 % de margen** | **≈ 1,5 GB** | **≈ 2 vCPU** |

Conclusión: mínimo 1 vCPU / 1 GB para arrancar; recomendado 2 vCPU / 2 GB.

### 4. Requisitos de software también cuentan

La matriz no es solo hardware. Incluye:

- Sistema operativo y versión (ej. Ubuntu Server 24.04 LTS)
- Arquitectura (x86_64 / arm64 — importa para imágenes Docker)
- Versiones de runtime (Docker Engine, PostgreSQL)
- Puertos que deben estar libres (80, 443, 5432…)

### 5. De la matriz al script

Una matriz en papel se desactualiza. En la práctica
[`02-script-verificacion-requisitos`](../2-practicas/02-script-verificacion-requisitos/README.md)
la conviertes en un script que cualquier persona corre en el servidor destino antes de instalar y
responde **cumple / no cumple** por cada requisito. Esa es la evidencia de CE-2.

### 6. Aplicación al proyecto real

Mide tu proyecto con `docker stats` (o el administrador de tareas si aún no está en contenedores),
aplica el método de la sección 3 y registra la matriz en la ficha técnica.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
