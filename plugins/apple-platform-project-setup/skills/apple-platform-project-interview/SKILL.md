---
name: apple-platform-project-interview
description: Use when the Apple workspace setup flow needs project intent, platform targets, personalization, policy, config, CI, MCP, and standardization decisions collected before choosing repo changes.
---

# Apple Platform Project Interview

Run this interview after capability discovery and before workspace choice, installs, or artifact application.

## When to Use

Use this skill when:

- setup choices still depend on project role or policy
- the repo needs personalization and `AGENTS.md` inputs
- CI, MCP, and `.codex/config.toml` decisions are still open
- an existing repository needs scope confirmation before alignment work

## Required Topics

Collect, in order:

1. discovered plugin, project-local skill, subagent, and MCP surface
2. repo state and detected workspace hints
3. project purpose and delivery shape
4. Apple platform targets
5. workspace shape confirmation
6. if `Xcode`, project strategy confirmation
7. priority technologies
8. repo and team policy
9. package README inputs when the repo is package-first
10. app README inputs when the repo is app-first
11. `Agent Personalization`
12. optional tooling, `.codex/config.toml`, official multi-agent runtime, optional MCP, and `SFSafeSymbols`

## Agent Personalization Rules

- Always ask which communication language should be fixed in `AGENTS.md`.
- If the user does not choose one, use `Use the language the client used to contact the agent.`
- Keep the strict-quality baseline for pushback, quality, long-term priority, temporary-fix policy, and risk disclosure unless the user explicitly changes them.

## Multi-Agent Decision Order

Keep this order exact:

1. ask whether the repo should carry `.codex/config.toml`
2. if yes, ask whether the standard `setup` / `review` / `release` profiles should be used
3. ask whether official multi-agent runtime should be enabled
4. if runtime is enabled, ask separately whether to continue into project-local subagent selection
5. if runtime is not enabled, ask separately whether project-local subagents are still desired directly

## Outputs

Produce enough information to finalize:

- workspace choice
- Xcode strategy when relevant
- top skill and subagent categories
- final README inputs
- final `Agent Personalization` lines
- common and workspace-specific snippets
- `.codex/config.toml` and MCP decisions
- `standardization_scope`

## Guardrails

- Do not choose skills, subagents, MCP, or repo files before the interview is complete.
- For `existing_structured_repo`, confirm detected choices instead of asking from a blank slate.
- Derive README facts from repo evidence when available instead of asking every question directly.

## References

- [`references/project-interview.md`](../../../../references/project-interview.md)
- [`references/agents-personalization.md`](../../../../references/agents-personalization.md)
