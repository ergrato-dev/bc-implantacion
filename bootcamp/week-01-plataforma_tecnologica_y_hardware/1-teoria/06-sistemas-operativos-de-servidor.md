# Sistemas Operativos de Servidor

## 🎯 Objetivos

- Explicar qué distingue a un sistema operativo de servidor
- Comparar distribuciones Linux de servidor y el modelo de Windows Server
- Entender los ciclos de soporte (LTS) y por qué importan en producción
- Consultar e interpretar los requisitos mínimos de instalación

## 📋 Contenido

### 1. ¿Qué es un sistema operativo de servidor?

Es un sistema operativo optimizado para **ofrecer servicios a otros equipos** de forma continua:

- Sin interfaz gráfica por defecto (menos consumo, menos superficie de ataque)
- Administración remota (SSH)
- Soporte largo con parches de seguridad
- Herramientas para servicios de red, usuarios, almacenamiento y virtualización

### 2. Familias

| Sistema | Base | Licencia | Soporte | Uso típico |
|---|---|---|---|---|
| **Ubuntu Server LTS** | Debian | Gratis; Ubuntu Pro opcional | 5 años estándar, hasta 10 con Ubuntu Pro | Nube, contenedores, el más documentado |
| **Debian stable** | Propia | Gratis | ~3 años + ~2 de LTS comunitario | Servidores estables y livianos |
| **Rocky Linux / AlmaLinux** | Compatibles con RHEL | Gratis | ~10 años | Entornos tipo Red Hat |
| **Red Hat Enterprise Linux** | Propia | Suscripción | ~10 años | Empresas con soporte contratado |
| **Windows Server** | Windows | Comercial por núcleo + CAL | ~10 años | Directorio Activo, aplicaciones .NET Framework |

> **Windows Server en este bootcamp**: solo como comparación. Requiere licencia por núcleo (mínimo
> 16 núcleos por servidor, ediciones Standard y Datacenter) y licencias de acceso de cliente
> (CAL). Existe una versión de evaluación de 180 días, pero todas las prácticas usan Linux.

**Ubuntu Pro** es gratuito para uso personal en un número limitado de máquinas; en este bootcamp
no se necesita.

### 3. LTS: por qué importa

Una versión **LTS** (*Long Term Support*) recibe parches de seguridad durante años sin cambiar de
versión mayor. En producción:

- ✅ Instala siempre una versión LTS vigente (ej. Ubuntu 24.04 LTS)
- ❌ No instales versiones intermedias (ej. 24.10): tienen soporte de ~9 meses
- Registra en el plan de implantación la **fecha de fin de soporte** del sistema elegido — es
  insumo del plan de mantenimiento de la semana 8

Consulta el ciclo oficial de Ubuntu en la [webgrafía](../4-recursos/webgrafia/README.md).

### 4. Requisitos mínimos de instalación

Cada distribución publica sus requisitos mínimos por versión y **cambian entre versiones**, así
que no los memorices: consúltalos en la documentación oficial de la versión exacta. Como orden de
magnitud, Ubuntu Server sin interfaz gráfica arranca con alrededor de 1 núcleo, 1-2 GB de RAM y
unos pocos GB de disco.

Recuerda que ese mínimo es **solo del sistema operativo**. El requisito real del servidor es:

```
Requisito del servidor = mínimo del SO + consumo de tu software + margen
```

(ver [`03-dimensionamiento-y-requisitos-minimos.md`](03-dimensionamiento-y-requisitos-minimos.md)).

### 5. Criterios para elegir

| Pregunta | Si la respuesta es sí… |
|---|---|
| ¿El software corre en contenedores Linux? | Ubuntu Server LTS o Debian |
| ¿El cliente ya tiene soporte contratado con Red Hat? | RHEL o compatible |
| ¿Depende de .NET Framework o Directorio Activo? | Windows Server (fuera del alcance de este bootcamp) |
| ¿El equipo solo conoce una distribución? | Esa, si es LTS |

### 6. Aplicación al proyecto real

En la ficha técnica declara: sistema operativo, versión exacta, arquitectura, fecha de fin de
soporte, licencia y los requisitos mínimos oficiales que consultaste (con enlace).

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
