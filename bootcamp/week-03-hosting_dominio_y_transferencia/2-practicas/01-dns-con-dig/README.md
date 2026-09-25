# Práctica 01 — Consultas DNS con `dig`

<!-- 📝 Instrucción: práctica individual. Requiere conexión a Internet. Cada aprendiz anota sus
propios resultados: las IP y los TTL cambian con el tiempo y según la red. -->

## Objetivo

Consultar e interpretar registros DNS reales para entender cómo un nombre de dominio llega a
una dirección IP, y qué registros necesitará tu proyecto.

## Duración estimada

90 minutos.

## Preparación

```bash
dig -v || sudo apt install -y dnsutils
```

## 1. Registro A: nombre → IPv4

```bash
dig example.com A
```

Ubica en la salida la sección `ANSWER SECTION`. Cada línea tiene:

| Columna | Ejemplo | Significado |
|---|---|---|
| Nombre | `example.com.` | Nombre consultado (el punto final es la raíz) |
| TTL | `300` | Segundos que la respuesta puede guardarse en caché |
| Clase | `IN` | Internet |
| Tipo | `A` | Tipo de registro |
| Valor | `104.20.x.x` | Dirección IPv4 |

Versión corta, solo el valor:

```bash
dig +short example.com A
dig +short example.com AAAA
```

## 2. CNAME: un nombre que apunta a otro

```bash
dig +noall +answer www.github.com
```

- [ ] ¿Qué devuelve primero: un `CNAME` o un `A`? ¿Por qué hay dos líneas?

## 3. Otros registros

| Consulta | Qué buscar |
|---|---|
| `dig +short NS wikipedia.org` | Servidores de nombres autoritativos del dominio |
| `dig +short MX gmail.com` | Servidores de correo y su prioridad |
| `dig +short TXT example.com` | Textos: verificación de dominio, políticas de correo (SPF) |

## 4. TTL y caché

Ejecuta dos veces seguidas y compara el TTL:

```bash
dig +noall +answer github.com A
sleep 10
dig +noall +answer github.com A
```

- [ ] ¿El TTL bajó? ¿Qué significa sobre de dónde viene la respuesta?

Ahora pregunta directo a un resolvedor público:

```bash
dig @1.1.1.1 +noall +answer github.com A
dig @8.8.8.8 +noall +answer github.com A
```

## 5. El camino completo

```bash
dig +trace example.com A
```

Identifica los tres saltos: servidores raíz (`.`), servidores del TLD (`com.`) y servidores
autoritativos del dominio. Compáralo con el diagrama de
[`02-dominios-y-dns.md`](../../1-teoria/02-dominios-y-dns.md).

## 6. Pregunta de análisis

Vas a cambiar la IP del servidor de tu proyecto y el registro A tiene TTL de 86400. ¿Cuánto
tiempo podrían algunos usuarios seguir llegando al servidor viejo? ¿Qué harías **antes** del
cambio para reducir ese tiempo?

## ✅ Checklist

- [ ] Consulté registros A, AAAA, CNAME, NS, MX y TXT e interpreté cada salida
- [ ] Observé la caché a través del TTL
- [ ] Identifiqué los tres saltos de `+trace`
- [ ] Respondí la pregunta de análisis
