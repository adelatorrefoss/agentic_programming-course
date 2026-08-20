# Agent harness and configuration

This guide covers the harness used to configure and coordinate agents. It is intentionally separate from the [test infrastructure](test-infrastructure.md), which covers Jest, PostgreSQL, Ollama, and test execution dependencies.

## Agent configuration

Agent definitions live in `.agents/agents/`. Each definition should declare:

- A stable `name` and clear `description`.
- An `argument-hint` when the agent needs structured input.
- The `tools` it is allowed to use, limited to the task.
- Whether it is `user-invocable`.

Skills live in `.agents/skills/` and should be focused on a repeatable workflow rather than a project role.

## Coordination best practices

- Define shared contracts before starting parallel work.
- Give each delegated agent a bounded objective, ownership, and stop condition.
- Keep database, backend, and testing responsibilities separate.
- Ask the main agent to review the integrated diff, not only isolated agent results.
- Preserve existing user changes and avoid unrelated production edits.
- Record agent-harness recommendations in `TODO-AGENT-HARNESS.md`.
- Record test infrastructure recommendations in `TODO-TEST-INFRASTRUCTURE.md`.

## `harness-retro`

`.agents/agents/harness-retro.agent.md` handles post-run retrospectives for agent harness configuration. Agent-harness recommendations are persisted in `TODO-AGENT-HARNESS.md`.

The agent may update that TODO file, but it must not modify production code or CI configuration unless explicitly authorized.
