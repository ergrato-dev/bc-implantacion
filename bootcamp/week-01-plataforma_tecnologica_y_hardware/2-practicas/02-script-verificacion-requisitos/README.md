# Práctica 02 — Script de Verificación de Requisitos

<!-- 📝 Instrucción: práctica en parejas. Primero se ejecuta el script tal cual, después se
adapta a los requisitos de la app de referencia y por último se provoca un fallo a propósito. -->

## Objetivo

Convertir una matriz de requisitos mínimos en un script que responde **cumple / no cumple** en
el servidor destino antes de instalar. Es la evidencia práctica del criterio CE-2.

## Duración estimada

120 minutos.

## 1. Requisitos de la app de referencia

| Requisito | Mínimo |
|---|---|
| Procesadores | 1 núcleo |
| RAM | 1024 MB |
| Disco libre en `/` | 10 GB |
| Arquitectura | x86_64 o aarch64 |
| Sistema operativo | Ubuntu 22.04 o superior |
| Docker Engine | 24.0 o superior |
| Puertos libres | 80, 443 |

## 2. Ejecutar el script

El script [`verificar-requisitos.sh`](verificar-requisitos.sh) ya trae esos umbrales:

```bash
bash verificar-requisitos.sh
echo "Código de salida: $?"
```

Salida esperada (los valores cambian según el servidor):

```
REQUISITO          ESPERADO               ENCONTRADO             ESTADO
------------------------------------------------------------------------
Procesadores       >= 1                   2                      CUMPLE
RAM (MB)           >= 1024                1987                   CUMPLE
...
RESULTADO: el servidor cumple todos los requisitos mínimos.
```

Código de salida `0` = cumple todo; `1` = al menos un requisito falla. Ese código permite usar
el script dentro de otro script o de un pipeline de CI (semana 7).

## 3. Leer el script

Abre el archivo y ubica:

- [ ] Dónde se declaran los umbrales y cómo se cambian con variables de entorno
- [ ] De qué archivo del sistema se lee la RAM (`/proc/meminfo`)
- [ ] Cómo se comparan versiones (`sort -V`)
- [ ] Cómo se detecta un puerto en uso sin depender de `ss`

## 4. Provocar fallos

Comprueba que el script **detecta** incumplimientos:

```bash
MIN_RAM_MB=999999 bash verificar-requisitos.sh      # RAM insuficiente
OS_ID=debian bash verificar-requisitos.sh           # sistema operativo distinto
python3 -m http.server 8080 &                       # ocupar un puerto
PORTS="8080" bash verificar-requisitos.sh
kill %1
```

Cada ejecución debe terminar con `NO CUMPLE` en la fila correspondiente y código de salida `1`.
Si el script dice "cumple" cuando no debería, tiene un error: esa es la prueba más importante.

## 5. Ejecutar en otro sistema

```bash
docker run --rm -v "$PWD":/w debian:stable-slim bash /w/verificar-requisitos.sh
```

¿Qué filas fallan y por qué?

## 6. Adaptar al proyecto real (trabajo autónomo)

Copia el script al repositorio de tu proyecto (`scripts/verificar-requisitos.sh`), ajusta los
umbrales por defecto a la matriz de tu ficha técnica y agrega al menos **un** chequeo propio de tu
proyecto (ej. versión de PostgreSQL, un puerto adicional, memoria swap).

## ✅ Checklist

- [ ] Ejecuté el script y entendí cada fila
- [ ] Provoqué al menos tres fallos distintos y el script los detectó
- [ ] Adapté el script a los requisitos de mi proyecto y lo ejecuté en un servidor Linux

Teoría relacionada:
[`03-dimensionamiento-y-requisitos-minimos.md`](../../1-teoria/03-dimensionamiento-y-requisitos-minimos.md).
