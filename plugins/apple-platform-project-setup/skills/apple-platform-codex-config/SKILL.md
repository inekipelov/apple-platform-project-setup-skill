---
name: apple-platform-codex-config
description: Use when the Apple setup flow needs to create or align project .codex/config.toml, official multi-agent runtime settings, and optional MCP integrations for an Apple repository.
---

# Apple Platform Codex Config

Use this skill after workspace choice and after the interview has settled config scope.

## When to Use

Use this skill when:

- the target repo should carry `.codex/config.toml`
- standard `setup`, `review`, and `release` profiles should be aligned
- official multi-agent runtime is under consideration
- `sosumi` or `xcode` MCP policy needs to be configured

## Config Baseline

Prefer project-scoped `.codex/config.toml` when the repo is meant to carry its own Codex setup.

If the target repository vendors this plugin locally, register the orchestration skill with:

```toml
[[skills.config]]
path = "plugins/apple-platform-project-setup/skills/apple-platform-project-setup-skill/SKILL.md"
enabled = true
```

If the repo relies on the plugin through Codex installation instead of a vendored plugin copy, skip the local `skills.config` entry and rely on the installed plugin surface.

Prefer:

- `profile = "setup"`
- `[profiles.setup]`
- `[profiles.review]`
- `[profiles.release]`

Keep these profiles separate from multi-agent runtime.

## Multi-Agent Runtime

If enabled, use the exact baseline:

```toml
[features]
multi_agent = true

[agents]
max_threads = 3
max_depth = 2
job_max_runtime_seconds = 900
```

Treat runtime config and installed project-local subagents as separate layers.

## Optional MCP Rules

- Prefer `sosumi` over remote HTTP MCP when Apple docs lookup is desired and the client supports remote MCP servers.
- Treat the `sosumi` CLI as optional.
- Offer `xcode` MCP only for `xcode` workspaces.
- For `XcodeGen`, require `xcodegen generate --spec project.yml` before `xcode` MCP setup.

## Optional Thin Wrapper

If the repo wants an always-on routing reminder, a thin wrapper may say:

```toml
developer_instructions = """
Use $apple-platform-project-setup-skill when bootstrapping or standardizing an Apple platform workspace.
"""
```

Do not replace the skill contract with a long inline prompt.

## References

- [`references/codex-config.md`](../../../../references/codex-config.md)
- [`references/mcp-setup.md`](../../../../references/mcp-setup.md)
- [`references/xcodegen-setup.md`](../../../../references/xcodegen-setup.md)
