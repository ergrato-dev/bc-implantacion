# 🔒 Política de Seguridad

## Versiones Soportadas

Este es un repositorio de **contenido educativo** (documentos Markdown, plantillas, diagramas SVG y recursos de referencia). No contiene código ejecutable en producción ni maneja datos de usuarios.

| Versión | Soportada |
|---|---|
| `main` (rama principal) | ✅ |
| Ramas de trabajo (`feature/*`, `fix/*`) | ⚠️ En revisión |

---

## Reportar una Vulnerabilidad

Aunque este repositorio no contiene aplicaciones en producción, existen aspectos de seguridad relevantes para un proyecto educativo:

### ¿Qué reportar?

- 🔗 **Enlace malicioso**: Un enlace en el material que apunte a contenido dañino o de phishing
- 📋 **Contenido engañoso**: Material que pueda inducir a aprendices a prácticas inseguras en proyectos reales (secretos en el repo, credenciales hardcodeadas, etc.)
- 🔒 **Información sensible**: Datos personales o credenciales expuestas accidentalmente en el repositorio
- ⚠️ **Contenido inapropiado**: Cualquier contenido que vulnere el [Código de Conducta](CODE_OF_CONDUCT.md)

### ¿Cómo reportar?

1. **NO** abras un issue público para vulnerabilidades de seguridad
2. Reporta directamente abriendo un **issue privado** o contactando a los mantenedores:
   - Usa el botón **"Report a vulnerability"** en la pestaña **Security** del repositorio
   - O envía un mensaje privado vía [GitHub](https://github.com/ergrato-dev)

### Proceso de Respuesta

| Paso | Tiempo estimado |
|---|---|
| Confirmación de recepción | 48 horas |
| Evaluación inicial | 5 días hábiles |
| Resolución o plan de acción | 15 días hábiles |

---

## Seguridad en los Proyectos de los Equipos

Los proyectos reales de cada equipo (no este repositorio de contenido) sí manejan código ejecutable. Recomendaciones obligatorias:

- ✅ Nunca commitear archivos `.env` con credenciales reales — usar `.env.example`
- ✅ Nunca usar datos reales de aprendices, instructores o terceros en pruebas — solo datos sintéticos
- ✅ Revisar dependencias antes de agregarlas (evitar paquetes sin mantenimiento o con vulnerabilidades conocidas)
- ✅ Nunca publicar IPs, hosts ni credenciales de servidores reales en el Plan de Implantación

---

## Limitaciones de Responsabilidad

Este repositorio es un recurso **exclusivamente educativo**. El equipo no se responsabiliza por:

- Implementaciones de proyectos reales basadas en este material
- Decisiones técnicas tomadas con base en las plantillas o ejemplos
- El uso del material fuera del contexto educativo para el que fue diseñado



---

_Última actualización: septiembre 2026_
