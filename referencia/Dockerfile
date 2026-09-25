# Imagen única de la app de referencia: el frontend React se compila en la primera
# etapa y la API FastAPI lo sirve junto con /api en la segunda.

# ---- Etapa 1: compilar el frontend ----
FROM node:22-alpine AS web
WORKDIR /web
COPY web/package.json web/package-lock.json ./
RUN npm ci --no-audit --no-fund
COPY web/ ./
RUN npm run build

# ---- Etapa 2: API + frontend compilado ----
FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY api/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY api/app ./app
COPY api/migrations ./migrations
COPY --from=web /web/dist ./static

# La versión se fija al construir: docker build --build-arg APP_VERSION=1.0.0
ARG APP_VERSION=dev
ENV APP_VERSION=${APP_VERSION}

# Usuario sin privilegios: el proceso no corre como root dentro del contenedor.
RUN useradd --create-home --uid 10001 app
USER app

EXPOSE 8000

HEALTHCHECK --interval=10s --timeout=3s --start-period=15s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8000/api/health', timeout=2)"

CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000} --proxy-headers --forwarded-allow-ips='*'"]
