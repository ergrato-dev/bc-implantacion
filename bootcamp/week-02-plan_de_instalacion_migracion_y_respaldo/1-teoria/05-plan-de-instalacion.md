# Diseño del Plan de Instalación

## 🎯 Objetivos

- Identificar las secciones de un plan de instalación
- Escribir pasos verificables que otra persona pueda seguir sin ayuda
- Integrar requisitos, migración y respaldo en un solo plan
- Redactar la versión 0 del plan de instalación del proyecto real

## 📋 Contenido

### 1. ¿Para qué sirve?

El plan de instalación responde: **¿cómo pone en funcionamiento este software una persona que
no lo construyó?** Si la respuesta es "llamando al desarrollador", no hay plan.

Prueba de fuego del bootcamp: en la semana 9 **otro equipo** instalará tu proyecto siguiendo
solo tu plan.

### 2. Estructura

| # | Sección | Contenido |
|---|---|---|
| 1 | Alcance | Qué se instala (componentes, versión) y qué **no** |
| 2 | Ambientes | Desarrollo, pruebas, producción: dónde está cada uno |
| 3 | Roles | Quién ejecuta, quién aprueba, quién valida (roles, no nombres) |
| 4 | Prerrequisitos | Requisitos de hardware y software (semana 1), accesos, cuentas |
| 5 | Preparación | Respaldo previo, ventana acordada, comunicación a usuarios |
| 6 | Procedimiento | Pasos numerados con comandos exactos y resultado esperado |
| 7 | Migración de datos | Referencia al plan de migración |
| 8 | Verificación | Pruebas que confirman que quedó funcionando |
| 9 | Rollback | Cómo volver al estado anterior si algo falla |
| 10 | Cronograma | Duración estimada de cada fase |

### 3. Pasos verificables

Cada paso tiene **acción**, **comando** y **resultado esperado**:

| ❌ Paso ambiguo | ✅ Paso verificable |
|---|---|
| "Instalar Docker" | `docker --version` → muestra 24.0 o superior |
| "Configurar la base de datos" | `docker compose up -d db --wait` → el servicio aparece `healthy` |
| "Verificar que funciona" | `curl -fsS https://<dominio>/health` → `{"status":"ok"}` |

Reglas:

- Un paso = una acción
- Comandos copiables, con variables marcadas (`<dominio>`) — nunca valores reales de producción
- Si un paso puede fallar, indica qué hacer
- Sin "etc.", sin "configurar según corresponda"

### 4. Punto de no retorno y rollback

Identifica el **punto de no retorno**: el paso después del cual volver atrás es costoso (por
ejemplo, cuando los usuarios empiezan a escribir datos en el sistema nuevo). Antes de ese punto,
el rollback es simple; después, requiere el plan de respaldo.

### 5. Cronograma de la ventana

Ejemplo **ilustrativo**:

| Fase | Duración | Acumulado |
|---|---|---|
| Aviso a usuarios y parada del sistema anterior | 15 min | 0:15 |
| Respaldo previo y verificación | 20 min | 0:35 |
| Instalación de servicios | 30 min | 1:05 |
| Migración y validación | 40 min | 1:45 |
| Pruebas de verificación | 20 min | 2:05 |
| **Punto de no retorno**: apertura a usuarios | — | 2:05 |
| Margen para imprevistos | 55 min | 3:00 |

### 6. Un plan que evoluciona

| Versión | Semana | Qué agrega |
|---|:---:|---|
| v0 | 2 | Estructura completa, prerrequisitos, pasos generales |
| v1 | 4 | Procedimiento de despliegue local y en la nube con comandos reales |
| v2 | 7 | Despliegue automatizado (CI/CD) |
| Final | 9 | Validado por otro equipo en simulacro |

La v0 puede tener pasos de alto nivel, pero **ninguna sección vacía**.

### 7. Aplicación al proyecto real

Redacta la v0 del plan de instalación de tu proyecto con las diez secciones.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
