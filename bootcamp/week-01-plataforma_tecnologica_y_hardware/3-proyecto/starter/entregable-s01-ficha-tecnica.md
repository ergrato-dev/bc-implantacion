# Entregable S01 — Ficha Técnica y Matriz de Requisitos

<!-- 📝 Instrucción: completa cada sección con datos de TU proyecto real. Los valores en cursiva
son un ejemplo parcial de la app de referencia; reemplázalos. Solo datos sintéticos. -->

| Campo | Valor |
|---|---|
| Proyecto | |
| Equipo | |
| Fecha | |

---

## 1.1 Descripción técnica

<!-- 📝 Instrucción: 3-5 líneas. Qué hace el software, arquitectura (monolito, API + SPA…) y
quiénes lo usan. -->

## 1.2 Inventario de software

<!-- 📝 Instrucción: una fila por componente. Consulta la licencia de la versión exacta. -->

| Componente | Función | Versión | Licencia | ¿Genera costo? |
|---|---|---|---|---|
| *PostgreSQL* | *Base de datos* | *16* | *PostgreSQL License* | *No* |
| *FastAPI + Uvicorn* | *Servidor de aplicaciones* | *0.115 / 0.32* | *MIT / BSD* | *No* |
| | | | | |

## 1.3 Sistema operativo del servidor

| Campo | Valor |
|---|---|
| Distribución y versión | *Ubuntu Server 24.04 LTS* |
| Arquitectura | |
| Fin de soporte estándar | |
| Licencia | |
| Requisitos mínimos oficiales (enlace) | |

## 1.4 Medición de consumo

<!-- 📝 Instrucción: mide con `docker stats` (o el monitor del sistema) en reposo y con carga
simulada. Indica cómo simulaste la carga. -->

| Servicio | RAM reposo | RAM pico | CPU pico |
|---|---|---|---|
| | | | |
| **Total** | | | |

Carga simulada con: <!-- ej. 20 usuarios concurrentes con un script de peticiones -->

## 1.5 Matriz de requisitos

<!-- 📝 Instrucción: recomendado = total medido + margen (30-50 %). Muestra el cálculo. -->

| Requisito | Mínimo | Recomendado | Justificación |
|---|---|---|---|
| CPU | *1 vCPU* | *2 vCPU* | *Pico medido 1,4 + 50 %* |
| RAM | | | |
| Disco | | | |
| Tipo de disco / IOPS | | | |
| Red | | | |
| Arquitectura | | | |
| Sistema operativo | | | |
| Docker / runtime | | | |
| Puertos | | | |

Crecimiento estimado de datos: <!-- registros/mes × tamaño promedio × meses -->

## 1.6 Plataforma física recomendada

<!-- 📝 Instrucción: si el cliente alojara el proyecto en sus instalaciones. -->

| Decisión | Elección | Justificación |
|---|---|---|
| Formato (torre / rack / blade) | | |
| Nivel RAID del servidor de base de datos | | |
| Plataforma de ejecución (bare metal / VM / contenedores) | | |

## 1.7 Verificación de requisitos

Script: `scripts/verificar-requisitos.sh` del repositorio del proyecto.

Servidor donde se ejecutó: <!-- ej. VM Ubuntu del laboratorio / contenedor ubuntu:24.04 -->

```
<!-- pega aquí la salida completa del script -->
```

Resultado: <!-- cumple / no cumple y qué se haría al respecto -->
