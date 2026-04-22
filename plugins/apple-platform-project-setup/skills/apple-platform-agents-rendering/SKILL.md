---
name: apple-platform-agents-rendering
description: Use when the Apple setup flow needs to generate or align the final repo-local AGENTS.md after workspace, capability, config, and artifact decisions are settled.
---

# Apple Platform AGENTS Rendering

Generate `AGENTS.md` last.

## When to Use

Use this skill when:

- the project interview is complete
- workspace choice is final
- selected skills and subagents are installed or intentionally skipped
- common repo artifacts are already applied

## Rendering Contract

- Start from [`snippets/common/AGENTS.bootstrap.md`](../../../../snippets/common/AGENTS.bootstrap.md).
- Use `$writing-skills` when generating or reshaping the final repo-specific `AGENTS.md`.
- Reference skills as `$skill-name`.
- Reference subagents as `@agent-name`.
- Render a declarative final-state file only.

Use these exact sections in this exact order:

1. `Repository Purpose`
2. `Agent Personalization`
3. `Workspace`
4. `Project Structure Source Of Truth`
5. `Core Commands`
6. `Installed Skills`
7. `Skill Usage Order`
8. `Installed Subagents`
9. `Repository Rules`

## Content Rules

- `Installed Skills` records only final installed project-local skills.
- `Skill Usage Order` records only ordered usage instructions.
- `Installed Subagents` records only final installed project-local subagents.
- `Repository Rules` stores non-command repo policy only.
- Do not include recommendations, alternatives, or rationale.
- Do not use first-person wording.
- Do not use the word `Report`.

## Guardrails

- Do not generate `AGENTS.md` before the rest of setup is settled.
- Do not duplicate the same guidance across `Agent Personalization`, `Core Commands`, and `Repository Rules`.
- For `Xcode + XcodeGen`, state that `project.yml` is the source of truth and that `xcodegen generate --spec project.yml` may be required before opening in Xcode.

## References

- [`snippets/common/AGENTS.bootstrap.md`](../../../../snippets/common/AGENTS.bootstrap.md)
- [`references/agents-personalization.md`](../../../../references/agents-personalization.md)
- [`catalog.yaml`](../../../../catalog.yaml)
