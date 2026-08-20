# Harness TODO implementation

## Objective

- Task: Implement AH-005 through AH-008.
- Expected outcome: enforce delegation contracts, role tool boundaries, task
  traceability, and closeout gates.
- Scope boundaries: agent harness configuration and documentation only.

## Ownership and contracts

| Agent | Owns | Inputs | Required output | Must not change |
| --- | --- | --- | --- | --- |
| main agent | integration and commit | harness TODOs and repository conventions | integrated diff and sign-off | unrelated application behavior |
| harness-retro | retrospective recommendations | completed task history and agent configuration | TODO recommendations | production code and CI |
| code-review | read-only integrated review | delegation brief and staged diff | findings, risks, and approval | production code, tests, CI, and config |

Shared contracts:

- Delegation contract: `.agents/DELEGATION_TEMPLATE.md`.
- Tool contract: `.agents/agent-tool-matrix.conf`.
- Closeout contract: `docs/agent-harness.md`.
- Persistence contract: this coordination record.

## Dependencies and stop conditions

1. Define the delegation and tool contracts before changing the validator.
2. Add the code-review role and closeout documentation.
3. Extend validation and run it against every agent definition.
4. Stop if an agent has undeclared tools or missing role documentation.

## Integration handoff

- Agent output references: `7c03246`, the prior harness-retro report, and the
  final code-review report from this task.
- Implementation commit: `67c2c73`.
- PR code review commit range: historical task review occurred before this
  post-commit gate was introduced; new tasks must review the implementation
  commit after it is created.
- Code review agent result: initial findings were fixed; final review result was
  `APPROVED` with no significant issues.
- Remediation commit: none for the historical task.
- Post-remediation validation commands: `npm run agents:validate` (passed, 6
  definitions); `npm run lint -- --no-fix` (passed);
  `bash -n scripts/agent-harness/validate-agent-config.sh` (passed);
  `git diff --check` (passed).
- Harness retro report: prior harness-retro report persisted in
  `TODO-AGENT-HARNESS.md`.
- Harness retro commit: `7c03246`.
- Final sign-off: main agent, approved for the historical task; the new cycle
  gate applies to subsequent tasks.
