# Apple Platform Project Setup Skill

Codex-first skill for bootstrapping Apple workspaces.

It does not ship a project template. It orchestrates setup: checks the baseline workflow, interviews the user, chooses `SPM` or `Xcode`, optionally chooses `native xcodeproj` or `Tuist-generated` inside the `Xcode` path, resolves concrete skills and subagents from a curated inventory, configures project `.codex/config.toml` and optional MCP, applies repo snippets with deterministic copy or merge rules, uses shape-specific `SwiftLint`, normalizes GitHub Actions guardrails, and generates the final `AGENTS.md`.

## Install

Keep the skill inside the target repository so the version stays pinned with the project.

```bash
mkdir -p .codex/skills
git clone https://github.com/inekipelov/apple-platform-project-setup-skill.git .codex/skills/apple-platform-project-setup-skill
```

Register it in `.codex/config.toml`:

```toml
#:schema https://developers.openai.com/codex/config-schema.json

[[skills.config]]
path = ".codex/skills/apple-platform-project-setup-skill"
enabled = true
```

Codex loads project-scoped `.codex/config.toml` only for trusted projects.

This is the only install path you need for this repo.

For advanced `.codex/config.toml`, MCP setup, or wrapper instructions, see [`references/codex-config.md`](references/codex-config.md) and [`references/mcp-setup.md`](references/mcp-setup.md).

## Configure MCP

### Recommended: `sosumi` over HTTP MCP

For Apple documentation lookup, prefer remote HTTP MCP:

```toml
[mcp_servers.sosumi]
url = "https://sosumi.ai/mcp"
```

This works for both `spm` and `xcode` workspaces and does not require the `sosumi` CLI.

### `xcode` MCP for `xcode` workspaces only

This skill treats `xcode` MCP as an `xcode`-only integration.

First enable external agents in Xcode:

1. Open the project in Xcode.
2. Go to `Xcode > Settings > Intelligence`.
3. Turn on `Allow external agents to use Xcode tools`.

Then configure the bridge:

```bash
codex mcp add xcode -- xcrun mcpbridge
```

Or register it in TOML:

```toml
[mcp_servers.xcode]
command = "xcrun"
args = ["mcpbridge"]
```

If the repository uses `Tuist`, run `tuist generate` first and open the generated project or workspace in Xcode before enabling `xcode` MCP.

Do not configure `xcode` MCP for `spm` workspaces in this repo contract.

## How it works

It starts with `obra/superpowers`. If that baseline is missing, the skill stops and asks for confirmation before any user-level install or home-directory change.

Once the baseline is available, the skill interviews the user about project purpose, agent personalization, Apple platforms, UI stack, CI needs, repository policy, project config, and MCP needs. Only then does it choose `SPM` or `Xcode`. If `Xcode` is selected, the skill keeps `native xcodeproj` as the default and offers an optional `Tuist-generated` path for app-first repositories that want declarative manifests and generated projects. After that it checks prerequisites such as `npx`, `gitlint`, `swiftlint`, and optionally `tuist`, maps the project to capability categories, resolves one inventory-backed best-fit `$skill-name` or `@agent-name` per capability gap, chooses the matching `SwiftLint` snippet, configures project `.codex/config.toml`, and leaves the final choice with the user.

After the selection is confirmed, the skill installs or copies only the chosen items, applies the repo snippets, and generates the repo-specific `AGENTS.md` from the bootstrap snippet.

## Rules

- `obra/superpowers` comes first.
- `skills.sh` is preferred when a community skill supports it.
- Upstream instructions are fallback only.
- Global installs and user-home changes always require explicit confirmation.
- Project-local skills and subagents are preferred by default.
- Prefer project `.codex/config.toml` for repo-local Codex setup.
- `sosumi` HTTP MCP is preferred over the `sosumi` CLI.
- `xcode` MCP is allowed only for `xcode` workspaces in this skill.
- `Tuist` is an optional `Xcode` sub-mode, not a third workspace shape.
- Inside `Xcode`, `native xcodeproj` stays the default and `Tuist` stays optional.
- `SwiftLint` is shape-specific: `SPM` and `Xcode` get different `.swiftlint.yml` snippets.
- GitHub Actions snippets include `workflow_dispatch`, least-privilege permissions, and workflow-level concurrency.
- Final selected skills come from `inventory/skills.yaml`.
- Final selected subagents come from `inventory/subagents.yaml`.
- `AGENTS.md` is declarative final-state only. It must reference skills as `$skill-name` and subagents as `@agent-name`.
- `AGENTS.md` uses fixed sections, including a required `Agent Personalization` section with exact line prefixes.
- The skill explicitly asks which communication language should be fixed in `AGENTS.md`; if the user does not choose one, the fallback is the language the client used to contact the agent.
- `AGENTS.md` lists only installed project-local skills and subagents.
- Snippet-backed files follow `target_path`, `apply_mode`, `conflict_policy`, and `merge_strategy` from `catalog.yaml`.

## Source of truth

- [`SKILL.md`](SKILL.md): orchestration and runtime order
- [`catalog.yaml`](catalog.yaml): machine-readable artifact contract
- [`inventory/`](inventory/): curated concrete skills and subagents
- [`references/`](references/): install policy, source precedence, config, MCP, interview, and selection rules
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
