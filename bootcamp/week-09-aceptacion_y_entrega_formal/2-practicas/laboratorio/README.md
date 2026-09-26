# 🧪 Laboratorio de la Semana 9

La "producción" del equipo que entrega la app de referencia (versión 1.0.0) y el script que arma
el paquete de entrega del simulacro. Lo usan las prácticas
[01](../01-pruebas-de-aceptacion/README.md) y [02](../02-simulacro-con-la-app-de-referencia/README.md).

| Elemento | Qué es |
|---|---|
| `db` + `app` | App de referencia 1.0.0 con su base, en <http://localhost:8000> |
| [`preparar-entrega.sh`](preparar-entrega.sh) | Genera `entrega/`: respaldo cifrado con restic, huella y versión. Muestra la contraseña de restic para entregarla por otro canal |

```
laboratorio/
├── compose.yaml
├── .env.example
├── preparar-entrega.sh
└── entrega/            ← lo genera preparar-entrega.sh (ignorado por Git)
    ├── restic/         ← repositorio cifrado con un respaldo de la base
    ├── huella.txt
    └── version.txt
```

## Comandos

Desde esta carpeta:

```bash
cp .env.example .env
docker compose up -d --build --wait
bash preparar-entrega.sh
docker compose down -v && rm -rf entrega     # al terminar
```

`preparar-entrega.sh` usa restic dentro de un contenedor (`restic/restic`): no hace falta
instalarlo. El equipo que instala tampoco lo necesita; el plan de la app de referencia usa el
mismo contenedor para restaurar.
