# Práctica 01 — Inspección de un Servidor Linux

<!-- 📝 Instrucción: práctica individual, guiada por el instructor. Cada aprendiz completa la
tabla de la sección 3 con los valores de SU servidor. -->

## Objetivo

Levantar un inventario de hardware y software de un servidor Linux usando solo la terminal, y
entender la diferencia entre lo que ve una VM y lo que ve un contenedor.

## Duración estimada

90 minutos.

## 1. Preparar el servidor

Usa **una** de estas opciones:

**Opción A — VM Ubuntu del laboratorio** (preferida):

```bash
ssh <usuario>@<servidor-del-laboratorio>
```

**Opción B — contenedor Ubuntu** (si no hay VM disponible):

```bash
docker run -it --rm --name servidor-lab ubuntu:24.04 bash
apt-get update && apt-get install -y iproute2 procps pciutils util-linux
```

> Nunca copies en el repositorio la IP, el nombre de host ni el usuario real del laboratorio.

## 2. Comandos de inspección

Ejecuta cada comando y observa la salida:

| Qué | Comando |
|---|---|
| Sistema operativo y versión | `cat /etc/os-release` |
| Kernel y arquitectura | `uname -srm` |
| Procesador | `lscpu` y `nproc` |
| Memoria RAM | `free -h` |
| Discos y particiones | `lsblk` |
| Espacio libre | `df -h` |
| Interfaces de red | `ip -br addr` |
| Puertos en escucha | `ss -tuln` |
| Tiempo encendido y carga | `uptime` |
| ¿Estoy en una VM o contenedor? | `systemd-detect-virt` (VM) · `cat /proc/1/cgroup` (contenedor) |

## 3. Inventario

Completa esta tabla en tu cuaderno de laboratorio:

| Recurso | Valor encontrado | Comando usado |
|---|---|---|
| Sistema operativo / versión | | |
| Arquitectura | | |
| Núcleos de CPU | | |
| RAM total | | |
| Disco total / libre en `/` | | |
| Interfaces de red | | |
| Puertos abiertos | | |
| Tipo de plataforma (bare metal, VM, contenedor) | | |

## 4. Pregunta de análisis

Si usaste la **opción B**, compara `nproc` y `free -h` dentro del contenedor con los valores de
tu portátil. ¿Son iguales? ¿Por qué?

<details>
<summary>Respuesta</summary>

Un contenedor comparte el kernel del anfitrión, así que por defecto ve la CPU y RAM **del
anfitrión**. Para limitar recursos hay que declararlo (`docker run --cpus=1 --memory=1g`). Por
eso, al verificar requisitos dentro de un contenedor, lo que mides es el anfitrión, no un
"servidor" aislado. En una VM, en cambio, ves solo lo que el hipervisor le asignó.

</details>

## ✅ Checklist

- [ ] Inventario completo, sin campos vacíos
- [ ] Identifiqué el tipo de plataforma y cómo lo comprobé
- [ ] Respondí la pregunta de análisis con mis propias palabras

Teoría relacionada: [`01-hardware-de-servidores.md`](../../1-teoria/01-hardware-de-servidores.md),
[`05-virtualizacion-y-contenedores.md`](../../1-teoria/05-virtualizacion-y-contenedores.md).
