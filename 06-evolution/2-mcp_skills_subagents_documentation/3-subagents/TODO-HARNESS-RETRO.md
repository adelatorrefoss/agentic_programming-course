# Harness Retro TODO

Actionable recommendations from `harness-retro` live here so they remain visible across runs.

## 🚨 Pending recommendations

| ID | Priority | Recommendation | Owner | Status |
| --- | --- | --- | --- | --- |
| HR-001 | High | Preload and pin the Ollama model `qwen3-embedding:0.6b` in the development and CI harness. | Platform | Pending |
| HR-002 | High | Add an Ollama healthcheck that verifies both service availability and the required model before running tests. | Platform | Pending |
| HR-003 | Medium | Cache the required Ollama model between runs and document the cache invalidation policy. | Platform | Pending |
| HR-004 | Medium | Document PostgreSQL and Ollama as explicit prerequisites for the integration test suite. | Engineering | Pending |
| HR-005 | Low | Add a no-cache execution path and monitoring to detect missing external dependencies early. | Testing | Pending |

## Maintenance rules

- `harness-retro` must update this file after every retrospective.
- Keep recommendations in the table above, assign stable IDs, and do not duplicate equivalent items.
- Use `Done`, `Blocked`, or `Pending` in the `Status` column.
- Proposed changes to production code, CI configuration, or developer workflows remain proposals until explicitly approved.
