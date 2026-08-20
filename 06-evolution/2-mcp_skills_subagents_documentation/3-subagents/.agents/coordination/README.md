# Agent coordination records

Create one Markdown record per multi-agent task from
[DELEGATION_TEMPLATE.md](../DELEGATION_TEMPLATE.md).

The record is the handoff contract for the task. It must preserve:

- named ownership and shared contracts before parallel work;
- dependency order and stop conditions;
- agent run or output references;
- implementation commit and PR code-review commit range;
- code-review-agent result and remediation commit using the `code-review:` prefix;
- post-remediation validation, harness-retro report, and final sign-off.

Records are part of the agent harness, not test infrastructure. Do not store
secrets or credentials in them.
