# Demo
1. `docker compose up`
2. `npm run configure-rabbitmq`
3. `npm run publish-outbox`
4. `npm run consume-rabbitmq`
5. `npm run insert-duplicate-events -- 100`

## Test harness

See [`docs/harness.md`](docs/harness.md) for PostgreSQL and Ollama prerequisites, healthchecks, cache policy, and no-cache validation.
