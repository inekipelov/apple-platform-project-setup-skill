# Codex Project Config

Use this document when the target repository should carry a project-local `.codex/config.toml`.

## Official Rules

Per the official Codex config reference:

- user-level config lives in `~/.codex/config.toml`
- project-scoped overrides live in `.codex/config.toml`
- project-scoped config loads only when the project is trusted
- valid keys include `skills.config`, `developer_instructions`, `model_instructions_file`, and `mcp_servers.*`

Reference:

- <https://developers.openai.com/codex/config-reference#configtoml>
- Schema: <https://developers.openai.com/codex/config-schema.json>

## Recommended Project Config

Use a project-local `.codex/config.toml` with:

```toml
#:schema https://developers.openai.com/codex/config-schema.json

[[skills.config]]
path = ".codex/skills/apple-platform-project-setup-skill"
enabled = true
```

This is the preferred baseline when the repo carries the skill locally.

## Optional Thin Wrapper

If the project wants an always-on routing reminder, add:

```toml
developer_instructions = """
Use $apple-platform-project-setup-skill when bootstrapping or standardizing an Apple platform workspace.
"""
```

Use this as a thin wrapper only. Do not replace the skill contract with a long inline prompt.

## Alternative: Dedicated Instruction File

If the project wants a dedicated reusable instruction document, use:

```toml
model_instructions_file = ".codex/instructions/apple-workspace-setup.md"
```

Use this only as an explicit alternative to inline wrapper text.

## What Not To Do

- Do not invent config keys outside the official Codex config reference.
- Do not assume project config loads in untrusted projects.
- Do not put the full skill body into `developer_instructions`.
- Do not treat `model_instructions_file` as required when `AGENTS.md` or a thin wrapper is enough.
