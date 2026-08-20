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
  final pre-commit code-review report from this task.
- Integrated diff reviewed by: main agent.
- Code review agent result: initial findings were fixed; final review result was
  `APPROVED` with no significant issues.
- Validation commands: `npm run agents:validate` (passed, 6 definitions);
  `npm run lint -- --no-fix` (passed);
  `bash -n scripts/agent-harness/validate-agent-config.sh` (passed);
  `git diff --check` (passed).
- Final sign-off: main agent, approved for commit.
