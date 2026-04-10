# Apple Platform Project Setup Skill

Codex-first skill for bootstrapping Apple workspaces.

It does not ship a project template. It orchestrates setup: checks the baseline workflow, interviews the user, chooses `SPM` or `Xcode`, resolves concrete skills and subagents from a curated inventory, configures project `.codex/config.toml` and optional MCP, applies repo snippets with deterministic copy or merge rules, and generates the final `AGENTS.md`.

## Install

### Recommended: project-local skill

Keep the skill inside the target repository so the version is pinned with the project.

```bash
mkdir -p .codex/skills
git clone https://github.com/inekipelov/apple-platform-project-setup-skill.git .codex/skills/apple-platform-project-setup-skill
```

Register it in the project config:

```toml
[[skills.config]]
path = ".codex/skills/apple-platform-project-setup-skill"
enabled = true
```

Codex loads project-scoped `.codex/config.toml` only for trusted projects.

## Configure project `.codex/config.toml`

### Recommended: minimal project config

Use the official Codex project config format:

```toml
#:schema https://developers.openai.com/codex/config-schema.json

[[skills.config]]
path = ".codex/skills/apple-platform-project-setup-skill"
enabled = true
```

This keeps the skill project-local and matches the OpenAI `config.toml` reference.

### Alternative config options

#### Thin wrapper with `developer_instructions`

Use this only for a short routing reminder:

```toml
developer_instructions = """
Use $apple-platform-project-setup-skill when bootstrapping or standardizing an Apple platform workspace.
"""
```

#### Dedicated `model_instructions_file`

Use this when the repo wants a separate reusable instruction document:

```toml
model_instructions_file = ".codex/instructions/apple-workspace-setup.md"
```

## Configure MCP

### Recommended: `sosumi` over HTTP MCP

For Apple documentation lookup, prefer remote HTTP MCP:

```toml
[mcp_servers.sosumi]
url = "https://sosumi.ai/mcp"
```

This works for both `spm` and `xcode` workspaces and does not require the `sosumi` CLI.

### Alternative MCP methods

#### `sosumi` stdio proxy

Use this only when HTTP MCP is not a viable client path:

```toml
[mcp_servers.sosumi]
command = "npx"
args = ["-y", "mcp-remote", "https://sosumi.ai/mcp"]
```

#### `xcode` MCP for `xcode` workspaces only

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

Do not configure `xcode` MCP for `spm` workspaces in this repo contract.

### Alternative install methods

#### User-level install

Install once for your local Codex environment:

```bash
mkdir -p ~/.codex/skills
git clone https://github.com/inekipelov/apple-platform-project-setup-skill.git ~/.codex/skills/apple-platform-project-setup-skill
```

```toml
[[skills.config]]
path = "/absolute/path/to/.codex/skills/apple-platform-project-setup-skill"
enabled = true
```

#### Existing checkout or symlink

Any local directory that contains [`SKILL.md`](SKILL.md) can be registered directly:

```toml
[[skills.config]]
path = "/absolute/path/to/apple-platform-project-setup-skill"
enabled = true
```

#### Git submodule

If you want project-local pinning without copying the repo:

```bash
git submodule add https://github.com/inekipelov/apple-platform-project-setup-skill.git .codex/skills/apple-platform-project-setup-skill
```

Use the same project-local `skills.config` entry shown above.

#### Published catalog installer

This repo is not currently published as a `skills.sh` package. If that changes, documenting the published `npx skills add ...` command would become another supported install path.

## Use as remote instruction

### Recommended: project `AGENTS.md` wrapper

Use `AGENTS.md` as the thin routing layer and keep this repo as the real skill implementation:

```md
Use $apple-platform-project-setup-skill when bootstrapping or standardizing an Apple platform workspace. Install `obra/superpowers` first, interview before choosing `SPM` or `Xcode`, prefer `skills.sh` when available, and generate `AGENTS.md` last.
```

### Alternative remote instruction methods

#### Project `.codex/config.toml`

Use project-scoped `developer_instructions` when you want the reminder outside `AGENTS.md`:

```toml
developer_instructions = """
Use $apple-platform-project-setup-skill when bootstrapping or standardizing an Apple platform workspace.
"""
```

#### Project or user `model_instructions_file`

Use an instructions file when your team wants a dedicated reusable wrapper document:

```toml
model_instructions_file = ".codex/instructions/apple-workspace-setup.md"
```

The file can contain the same thin routing instruction that points back to `$apple-platform-project-setup-skill`.

#### User or profile-level wrapper

Use `~/.codex/config.toml` or a profile-specific config when you want this reminder available in every Apple repo you open.

## How it works

It starts with `obra/superpowers`. If that baseline is missing, the skill stops and asks for confirmation before any user-level install or home-directory change.

Once the baseline is available, the skill interviews the user about project purpose, Apple platforms, UI stack, CI needs, repository policy, project config, and MCP needs. Only then does it choose `SPM` or `Xcode`, check prerequisites such as `npx`, `gitlint`, and `swiftlint`, map the project to capability categories, resolve one inventory-backed best-fit `$skill-name` or `@agent-name` per capability gap, configure project `.codex/config.toml`, and leave the final choice with the user.

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
- Concrete recommended skills come from `inventory/skills.yaml`.
- Concrete recommended subagents come from `inventory/subagents.yaml`.
- `AGENTS.md` must reference skills as `$skill-name` and subagents as `@agent-name`.
- If multiple options fit, the skill recommends one best-fit option and explains why, but the user makes the final decision.
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
