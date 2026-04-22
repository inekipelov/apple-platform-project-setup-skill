---
name: apple-platform-capability-discovery
description: Use when you need to inspect the current Codex plugin surface, project-local skills, subagents, MCP configuration, and repository state before proposing Apple workspace setup changes.
---

# Apple Platform Capability Discovery

Run this step before the project interview and before proposing any install.

## When to Use

Use this skill when:

- starting Apple workspace setup from an unknown environment
- auditing an existing Apple repository before standardization
- checking whether plugin-provided capabilities already cover the need
- determining whether the repo is `greenfield` or `existing_structured_repo`

## Discovery Checklist

Inspect:

- plugin-provided skills already available in the active Codex session
- project-local skills under `.codex/skills/`
- project-local subagents under `.codex/agents/`
- configured MCP servers in `.codex/config.toml`, when present

Record:

- `discovered_plugins`
- `discovered_project_local_skills`
- `discovered_project_local_subagents`
- `discovered_mcp_servers`

Treat plugins discovered here as session-level capability surfaces, not project-local artifacts.

## Repository State Detection

Inspect the target repository before asking for setup choices.

Classify:

- `greenfield`
- `existing_structured_repo`

Use structural signals such as:

- `Package.swift`
- `*.xcodeproj`
- `*.xcworkspace`
- `project.yml`
- `.gitignore`
- `.swiftlint.yml`
- `.gitlint`
- `.github/workflows/`
- `.codex/config.toml`
- `AGENTS.md`

If the repo is already structured, switch the overall run to preserve-first `audit-and-align` behavior.

## Apple Plugin Surface Rules

- Treat `Build iOS Apps`, `Build macOS Apps`, and `Expo` as preferred plugin capability surfaces when they are already available in the active session.
- Treat Superpowers as a Codex plugin capability surface.
- Do not install, clone, or mirror `obra/superpowers` as a project-local skill target.

For Expo iOS loops:

- prefer `expo start`
- for simulator launch, prefer `expo start --ios` or a matching Codex `Run iOS` action
- do not default to `expo run:ios`, prebuild, or `eas build` just to get a simulator loop

## Guardrails

- Do not propose new skills, subagents, or MCP until the current capability surface is known.
- Do not confuse plugin-provided skills with project-local installed skills.
- Do not skip repo-state detection after environment discovery.

## References

- [`references/capability-discovery.md`](../../../../references/capability-discovery.md)
- [`references/source-precedence.md`](../../../../references/source-precedence.md)
- [`catalog.yaml`](../../../../catalog.yaml)
