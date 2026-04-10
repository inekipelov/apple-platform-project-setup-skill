# Apple Platform Project Setup Skill

Codex-first skill for bootstrapping Apple workspaces.

It does not ship a project template. It orchestrates setup: checks the baseline workflow, interviews the user, chooses `SPM` or `Xcode`, resolves concrete skills and subagents from a curated inventory, applies repo snippets with deterministic copy or merge rules, and generates the final `AGENTS.md`.

## How it works

It starts with `obra/superpowers`. If that baseline is missing, the skill stops and asks for confirmation before any user-level install or home-directory change.

Once the baseline is available, the skill interviews the user about project purpose, Apple platforms, UI stack, CI needs, and repository policy. Only then does it choose `SPM` or `Xcode`, check prerequisites such as `npx`, `gitlint`, and `swiftlint`, map the project to capability categories, resolve one inventory-backed best-fit `$skill-name` or `@agent-name` per capability gap, and leave the final choice with the user.

After the selection is confirmed, the skill installs or copies only the chosen items, applies the repo snippets, and generates the repo-specific `AGENTS.md` from the bootstrap snippet.

## Rules

- `obra/superpowers` comes first.
- `skills.sh` is preferred when a community skill supports it.
- Upstream instructions are fallback only.
- Global installs and user-home changes always require explicit confirmation.
- Project-local skills and subagents are preferred by default.
- Concrete recommended skills come from `inventory/skills.yaml`.
- Concrete recommended subagents come from `inventory/subagents.yaml`.
- `AGENTS.md` must reference skills as `$skill-name` and subagents as `@agent-name`.
- If multiple options fit, the skill recommends one best-fit option and explains why, but the user makes the final decision.
- Snippet-backed files follow `target_path`, `apply_mode`, `conflict_policy`, and `merge_strategy` from `catalog.yaml`.

## Source of truth

- [`SKILL.md`](SKILL.md): orchestration and runtime order
- [`catalog.yaml`](catalog.yaml): machine-readable artifact contract
- [`inventory/`](inventory/): curated concrete skills and subagents
- [`references/`](references/): install policy, source precedence, interview, and selection rules
- [`snippets/`](snippets/): canonical files for `AGENTS.md`, linting, ignore rules, and GitHub Actions

## Repository layout

```text
apple-platform-project-setup-skill/
  SKILL.md
  catalog.yaml
  inventory/
  agents/
  references/
  snippets/
```

## Development

This repository is maintained as a skill contract, not a template bundle.

Use [`references/skill-verification.md`](references/skill-verification.md) for the recorded RED/GREEN expectations.
