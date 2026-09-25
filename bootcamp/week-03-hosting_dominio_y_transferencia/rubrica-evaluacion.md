# 📊 Rúbrica de Evaluación — Semana 03

> **Semana 03**: Hosting, Dominio y Transferencia de Archivos
> **Criterios RAP evaluados**: CE-1

---

## Distribución de la Evaluación

| Tipo de Evidencia | Porcentaje | Instrumento |
|-------------------|-----------|-------------|
| 🧠 Conocimiento | 30% | Cuestionario de conceptos clave |
| 💪 Desempeño | 40% | Prácticas `2-practicas/01-dns-con-dig/`, `02-sitio-y-reverse-proxy/` y `03-transferencia-sftp/` |
| 📦 Producto | 30% | Estrategia de hosting y dominio del proyecto real |

**Nota mínima de aprobación por tipo: 70%**

---

## 🧠 Evidencia de Conocimiento (30%)

**Instrumento:** Cuestionario de 10 preguntas

1. ¿Qué administra el equipo y qué administra el proveedor en un VPS y en un PaaS?
2. ¿Qué es un gestor de contenidos y qué diferencia hay entre uno tradicional y uno headless?
3. Describe los pasos de la resolución DNS de un nombre que no está en caché.
4. ¿Para qué sirven los registros A, CNAME y TXT? ¿Por qué no se puede poner un CNAME en el dominio raíz?
5. ¿Qué es el TTL y qué harías con él antes de cambiar la IP de un servidor?
6. ¿Cómo atiende un mismo servidor varios sitios con la misma IP?
7. ¿Por qué el backend necesita el encabezado `X-Forwarded-For` cuando hay un reverse proxy?
8. ¿Qué requisitos debe cumplir un servidor para obtener un certificado de Let's Encrypt?
9. ¿Por qué FTP es inseguro y qué diferencia hay entre FTPS y SFTP?
10. ¿Qué archivo de un par de llaves SSH va al servidor y por qué el otro nunca se comparte?

### Criterios de Calificación

| Puntaje | Desempeño |
|---------|-----------|
| 9-10 correctas | Excelente |
| 7-8 correctas | Bueno |
| 5-6 correctas | Aceptable — requiere repaso |
| < 5 correctas | Insuficiente — revisar toda la teoría de la semana |

---

## 💪 Evidencia de Desempeño (40%)

**Instrumento:** prácticas 01, 02 y 03

| Criterio | Excelente (100%) | Bueno (80%) | Aceptable (60%) | Insuficiente (<60%) |
|----------|-----------------|-------------|-----------------|---------------------|
| **Consultas DNS** (práctica 01) | 6 tipos de registro interpretados, TTL y `+trace` explicados, pregunta de análisis correcta | 6 tipos sin analizar TTL o `+trace` | 3-5 tipos | Menos de 3 |
| **Virtual hosts y proxy** (práctica 02) | Explica `Host` y `X-Forwarded-*` con evidencia; certificado analizado | Explica uno de los dos | Ejecuta sin explicar | No ejecuta |
| **Sitio propio y recarga** (práctica 02) | Sitio agregado con `reload` y error provocado explicado | Sitio agregado sin probar el error | Sitio agregado reiniciando el contenedor | No agregado |
| **SFTP con llave** (práctica 03) | Publica con contraseña y con llave, transferencia no interactiva | Publica con llave | Publica solo con contraseña | No publica |
| **Límites de las herramientas** (práctica 03) | Explica `scp -s`, el fallo de `rsync` y el rechazo a FTP | Explica dos de los tres | Explica uno | Ninguno |

**Fórmula:** promedio de los 5 criterios (peso igual).

---

## 📦 Evidencia de Producto (30%)

**Instrumento:** sección 4 del Plan de Implantación (`entregable-s03-hosting-y-dominio.md`) +
configuración del reverse proxy en el repositorio del proyecto real

| Criterio | Puntaje Máx. | Qué se evalúa |
|----------|:---:|---|
| **CE-1** — Prepara la plataforma tecnológica, con base en las características del sistema operativo seleccionado | 100 | Tipo de hosting justificado por componente, con alternativa en servidor propio (25); dominio y registros DNS con TTL y responsable de renovación (20); camino de la petición y puertos abiertos justificados (15); reverse proxy configurado en el repositorio y probado localmente con evidencia (25); método de transferencia de archivos con autenticación por llave (15) |

**Total:** 100 puntos

**Condición adicional:** sin evidencia de la prueba local del reverse proxy, el Producto no
puede superar 60/100.

**Descuento:** −10 puntos si el entregable contiene IPs, nombres de host, usuarios o
contraseñas reales.

---

## 📈 Nota Final de la Semana

```
Nota = (Conocimiento × 0.30) + (Desempeño × 0.40) + (Producto × 0.30)
```

---

## 🔄 Criterios de Recuperación

Si alguna evidencia está entre 60% y 69%:

1. **Conocimiento:** repetir el cuestionario con preguntas distintas (plazo: 3 días)
2. **Desempeño:** completar lo que falte de las prácticas (plazo: 3 días)
3. **Producto:** completar la estrategia según observaciones (plazo: 5 días, sin retrasar la semana 4)

Si la nota es inferior al 60%, reunión con el instructor antes de iniciar la semana 4.

---

*Cadena de Formación · Implantación del Software · Semana 3 de 9 + 1 opcional*
