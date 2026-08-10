# Neveraly | What to Cook Today

Aplicación Next.js que propone platos con IA local a partir de ingredientes y
recuerda los platos cocinados mediante búsqueda vectorial.

## Arrancar toda la aplicación con Docker

```bash
docker compose up --build
```

La primera ejecución descarga las imágenes y los modelos de Ollama, por lo que
puede tardar varios minutos. Cuando el servicio `app` esté listo, abre:

<http://localhost:3000>

Los datos de PostgreSQL y los modelos de Ollama se conservan en volúmenes de
Docker. Las siguientes ejecuciones serán más rápidas.

Para ejecutar en segundo plano:

```bash
docker compose up --build -d
docker compose logs -f app
```

Para detener los contenedores sin borrar datos:

```bash
docker compose down
```

## Servicios

| Servicio | Puerto | Función |
| --- | ---: | --- |
| `app` | 3000 | Frontend y API de Next.js |
| `postgres` | 5432 | PostgreSQL con pgvector |
| `ollama` | 11434 | API de IA local |
| `ollama-models` | — | Descarga inicial de los modelos |

## Desarrollo local

También puedes ejecutar únicamente las dependencias en Docker y Next.js en el
host:

```bash
docker compose up -d postgres ollama ollama-models
npm install
npm run dev
```

La configuración local usa por defecto `localhost`, mientras que Compose
inyecta los nombres internos de los servicios.

## Comprobaciones

```bash
npm run checks
```
