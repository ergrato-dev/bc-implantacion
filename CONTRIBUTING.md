# 🤝 Guía de Contribución

¡Gracias por tu interés en contribuir al **Bootcamp Implantación del Software**! Este es un proyecto educativo de código abierto dirigido a la comunidad SENA ADSO en Colombia.

---

## 📋 Código de Conducta

Al participar en este proyecto, te comprometes a respetar el [Código de Conducta](CODE_OF_CONDUCT.md). Por favor léelo antes de contribuir.

---

## 🚀 ¿Cómo Contribuir?

### 1. Reportar un Error o Sugerencia

Antes de abrir un issue, verifica que no exista uno similar:

1. Ve a [GitHub Issues](https://github.com/ergrato-dev/bc-implantacion/issues)
2. Busca el problema que quieres reportar
3. Si no existe, abre un nuevo issue

**Tipos de issues:**
- 🐛 **Bug**: Error en contenido (dato incorrecto, enlace roto, etc.)
- ✨ **Feature**: Sugerencia de nuevo contenido o mejora
- 📚 **Docs**: Mejora de documentación o redacción
- 🎨 **Design**: Mejora de recursos visuales (SVG, diagramas)

### 2. Hacer una Contribución de Contenido

```bash
# 1. Fork del repositorio en GitHub

# 2. Clonar tu fork
git clone https://github.com/TU_USUARIO/bc-implantacion.git
cd bc-implantacion

# 3. Crear una rama descriptiva desde main
git checkout -b feature/week-03-dns-checklist
# o
git checkout -b fix/week-02-broken-link
# o
git checkout -b docs/improve-week01-glossary

# 4. Hacer tus cambios (ver sección de estándares abajo)

# 5. Commit con Conventional Commits
git add .
git commit -m "feat(week-03): add dns checklist"

# 6. Push a tu fork
git push origin feature/week-03-dns-checklist

# 7. Abrir un Pull Request contra main
```

---

## 📏 Estándares de Commits

Usa [Conventional Commits](https://www.conventionalcommits.org/):

```
<tipo>(<alcance>): <descripción en inglés, imperativo, minúsculas>
```

**Tipos:**

| Tipo | Uso |
|---|---|
| `feat` | Nuevo contenido (ejercicio, teoría, plantilla, semana) |
| `fix` | Corrección de errores en contenido existente |
| `docs` | Mejoras de documentación (README, instrucciones) |
| `style` | Formato, ortografía, sin cambio de contenido |
| `refactor` | Reorganización de carpetas o reestructuración |
| `chore` | Tareas de mantenimiento (.gitignore, configs) |
| `ci` | Cambios en workflows de GitHub Actions |

**Ejemplos:**

```bash
feat(week-02): add pg_dump restore drill
fix(week-04): correct render deploy steps
docs(readme): update week table
chore: update .gitignore
```

---

## 📂 Estándares de Contenido

### Nomenclatura de Archivos

- Kebab-case, sin tildes, sin espacios
- Teoría: `01-nombre-del-tema.md`
- Plantillas: `plantilla-nombre.md`
- Entregables: `entregable-nombre.md`
- Glosario: `README.md` dentro de `5-glosario/`

### Estructura de Semana

Toda semana nueva debe seguir la estructura estándar:

```
week-XX-tema_principal/
├── README.md
├── rubrica-evaluacion.md
├── 0-assets/
├── 1-teoria/
├── 2-practicas/
├── 3-proyecto/
│   ├── README.md
│   ├── starter/
│   └── solution/      ← NUNCA se sube al repo (está en .gitignore)
├── 4-recursos/
│   ├── ebooks-free/
│   ├── videografia/
│   └── webgrafia/
└── 5-glosario/
    └── README.md
```

### Idioma

- ✅ Documentación, teoría y guías: **español**
- ✅ Nomenclatura técnica (código, ramas, commits): **inglés**
- ❌ No mezclar idiomas dentro de un mismo párrafo

### Recursos Visuales (SVG)

- ✅ Tema dark, sin degradés, fuentes sans-serif (Inter, Roboto, Open Sans, System UI)
- ✅ La cantidad de assets por semana depende de cuántos conceptos se benefician de un diagrama — no hay cuota fija, no rellenar por rellenar
- ✅ Todo SVG debe estar vinculado en al menos un archivo de `1-teoria/` (o `2-practicas/`) donde se explica el concepto que representa
- ❌ Sin ASCII art como sustituto de diagrama real
- ❌ Sin asset huérfano (creado pero no enlazado desde ningún `.md`)

### Herramientas

- ✅ Solo open source o free tier (ver `docs/plan-curricular.md`)
- ❌ Sin Windows Server, CMS prehechos ni Heroku en prácticas
- ❌ Sin IPs, hosts ni credenciales reales — solo datos sintéticos

---

## 📋 Checklist de Pull Request

Antes de abrir un PR verifica:

- [ ] El contenido está en español (documentación y teoría); nomenclatura técnica en inglés
- [ ] Las plantillas tienen instrucciones claras y ejemplos (sin secciones vacías)
- [ ] La carpeta `solution/` NO está incluida en el PR
- [ ] Los archivos SVG están vinculados en al menos un `.md`
- [ ] Los commits siguen Conventional Commits
- [ ] El README de semana tiene navegación (← anterior / siguiente →)
- [ ] La rúbrica de evaluación tiene los 3 tipos de evidencia (conocimiento/desempeño/producto) y referencia el criterio de evaluación del RAP correspondiente
- [ ] Las prácticas usan la app de referencia y los entregables el proyecto real

---

## 📋 Áreas donde más se Necesita Ayuda

- 🧪 **App de referencia** (`referencia/`)
- 📚 **Teoría y prácticas** de cada semana
- 🎨 **Diagramas SVG** (RAID, DNS, pipelines)
- 🔗 **Webgrafía** con documentación oficial

---

## ❓ Preguntas

- 💬 [GitHub Discussions](https://github.com/ergrato-dev/bc-implantacion/discussions)
- 🐛 [GitHub Issues](https://github.com/ergrato-dev/bc-implantacion/issues)

---

_Gracias por contribuir a la educación de la comunidad SENA ADSO 🇨🇴_
