---
name: apple-platform-capability-install
description: Use when the Apple setup flow needs to map project needs to inventory-backed skills or subagents and install or copy only the confirmed missing capabilities.
---

# Apple Platform Capability Install

Use this skill after discovery, interview, and workspace selection.

## When to Use

Use this skill when:

- the project still has skill or subagent capability gaps
- you need one concrete recommendation per missing category
- you need to install only confirmed missing project-local skills
- you need to copy only chosen subagents into `.codex/agents/`

## Selection Model

- Compare project needs against discovered plugin surfaces and project-local capabilities first.
- Prefer already available plugin-provided skills or already installed project-local skills when they already cover the need.
- Use [`inventory/skills.yaml`](../../../../inventory/skills.yaml) and [`inventory/subagents.yaml`](../../../../inventory/subagents.yaml) as the concrete recommendation layer.
- Choose one capability category first, then use `coverage_tags` in the inventory to resolve the best-fit concrete skill.
- Recommend one best-fit skill or subagent per capability gap.
- Keep alternatives only as conditional fallbacks with explicit `choose instead if ...` guidance.
- The user still confirms or overrides the final selection.
- Do not turn artifact-driven needs such as SwiftLint, gitlint, workflows, or `.codex/config.toml` into fake skill-install gaps.

## Skill Install Rules

- Prefer `skills.sh` install commands when available.
- Fall back to upstream instructions only when `skills.sh` is not available or not supported.
- Treat every external source as a catalog, not a single install target.
- Install community skills project-locally by default when the installer supports it.
- If the installer only supports user-level install, explain the limitation and ask before proceeding.
- If a discovered plugin-provided skill already covers an AppKit, SwiftUI, or other Apple-platform gap, do not mirror it as a project-local install unless the user explicitly wants that duplication.

## Subagent Rules

- Copy only the chosen subagent files into `.codex/agents/`.
- Never dump a whole external collection into the repo.
- If a selected subagent is already present, keep it as existing repo state and carry it forward.

## Skill Usage Order

Build the final `Skill Usage Order` section from the effective skill surface the repo will rely on after setup.

That ordered list may include:

- project-local skills installed in the repo
- plugin-provided skills already available in the active session when they are part of the intended workflow order

## Guardrails

- Do not invent concrete skills or subagents outside the curated inventories.
- Do not install plugin-provided skills as project-local skills just because they are part of the workflow.
- Do not reinstall already present project-local skills or subagents.

## References

- [`references/skills-catalog.md`](../../../../references/skills-catalog.md)
- [`references/subagents-catalog.md`](../../../../references/subagents-catalog.md)
- [`inventory/skills.yaml`](../../../../inventory/skills.yaml)
- [`inventory/subagents.yaml`](../../../../inventory/subagents.yaml)
