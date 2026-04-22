---
name: apple-platform-project-setup-skill
description: Use when bootstrapping or standardizing an Apple platform workspace end to end and you need the full setup flow orchestrated across discovery, interview, workspace selection, capability install, config, artifacts, AGENTS guidance, and verification.
---

# Apple Platform Project Setup

Run the Apple workspace setup flow in strict order.

This is the only plugin skill that should trigger implicitly. The leaf skills are narrow helpers for explicit use or for the orchestrated flow below.

## When to Use

Use this skill when:

- starting a new Apple platform repository or local workspace
- standardizing an existing Apple repository without skipping discovery
- choosing or confirming `SPM` versus `Xcode`
- aligning `.codex/config.toml`, MCP, lint, CI, README, and `AGENTS.md` in one pass

Do not use this skill for:

- non-Apple projects
- one-off cleanup unrelated to workspace bootstrap or standardization

## Shared Source Of Truth

Use these shared assets throughout the flow:

- [`catalog.yaml`](../../../../catalog.yaml)
- [`inventory/skills.yaml`](../../../../inventory/skills.yaml)
- [`inventory/subagents.yaml`](../../../../inventory/subagents.yaml)
- [`references/source-precedence.md`](../../../../references/source-precedence.md)
- [`references/capability-discovery.md`](../../../../references/capability-discovery.md)
- [`references/project-interview.md`](../../../../references/project-interview.md)
- [`references/codex-config.md`](../../../../references/codex-config.md)
- [`references/mcp-setup.md`](../../../../references/mcp-setup.md)
- [`references/github-actions.md`](../../../../references/github-actions.md)
- [`references/swiftlint-setup.md`](../../../../references/swiftlint-setup.md)
- [`references/spm-readme.md`](../../../../references/spm-readme.md)
- [`references/app-readme.md`](../../../../references/app-readme.md)
- [`references/xcodegen-setup.md`](../../../../references/xcodegen-setup.md)
- [`references/agents-personalization.md`](../../../../references/agents-personalization.md)
- [`references/skill-verification.md`](../../../../references/skill-verification.md)
- [`snippets/`](../../../../snippets/)

## Mandatory Execution Order

1. Use `$apple-platform-capability-discovery` to inspect session plugin surfaces, project-local capabilities, configured MCP, and repo state before proposing installs or migrations.
2. Use `$apple-platform-project-interview` to collect project role, platforms, policies, personalization, scope, config, MCP, and standardization decisions.
3. Use `$apple-platform-workspace-selection` to choose or confirm `SPM` versus `Xcode`, then `native xcodeproj` versus `XcodeGen` when the workspace is `Xcode`, and to check tool prerequisites.
4. Use `$apple-platform-capability-install` to map project needs to inventory-backed skills and subagents, recommend one best-fit option per gap, and install or copy only the confirmed missing capabilities.
5. Use `$apple-platform-codex-config` to create or align project `.codex/config.toml`, multi-agent runtime settings, and optional MCP integrations.
6. Use `$apple-platform-artifact-application` to apply or refine README, SwiftLint, `.gitignore`, workflows, XcodeGen specs, and other snippet-backed repo artifacts.
7. Use `$apple-platform-agents-rendering` to generate the final repo-local `AGENTS.md` only after workspace, capability, config, and artifact decisions are settled.
8. Use `$apple-platform-setup-verification` to validate the final state, run repository checks, and summarize configured versus pending items.

Never skip or reorder these steps.

## Cross-Phase Invariants

- discovery is mandatory before any install proposal
- the interview completes before workspace choice and artifact application
- existing structured repos use preserve-first `audit-and-align` behavior
- global installs and user-home changes always require explicit confirmation
- `AGENTS.md` is generated only after selected skills and subagents are installed or intentionally skipped
- verification is last

## Leaf Skills

- `$apple-platform-capability-discovery`: early environment and repo-state inspection
- `$apple-platform-project-interview`: intent, policy, and personalization collection
- `$apple-platform-workspace-selection`: workspace and toolchain decisions
- `$apple-platform-capability-install`: inventory-backed skill and subagent selection
- `$apple-platform-codex-config`: project config and MCP setup
- `$apple-platform-artifact-application`: snippet-backed repo artifacts
- `$apple-platform-agents-rendering`: final-state `AGENTS.md`
- `$apple-platform-setup-verification`: contract checks and final summary

## What Not To Do

- Do not install `obra/superpowers` as a project-local skill target.
- Do not choose `SPM` or `Xcode` before the interview.
- Do not generate `AGENTS.md` before final capability choices are installed or intentionally skipped.
- Do not replace structured repo files without compare-and-confirm behavior.
