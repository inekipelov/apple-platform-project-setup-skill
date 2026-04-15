# Codex Project Config

Use this document when the target repository should carry a project-local `.codex/config.toml`.

## Official Rules

Per the official Codex config reference:

- user-level config lives in `~/.codex/config.toml`
- project-scoped overrides live in `.codex/config.toml`
- project-scoped config loads only when the project is trusted
- valid keys include `skills.config`, `developer_instructions`, `model_instructions_file`, `features.multi_agent`, `agents.*`, and `mcp_servers.*`

Reference:

- <https://developers.openai.com/codex/config-reference#configtoml>
- Schema: <https://developers.openai.com/codex/config-schema.json>

## Recommended Project Config

Use a project-local `.codex/config.toml` with:

```toml
#:schema https://developers.openai.com/codex/config-schema.json

profile = "setup"

[[skills.config]]
path = ".codex/skills/apple-platform-project-setup-skill"
enabled = true

[profiles.setup]
personality = "pragmatic"
approval_policy = "on-request"
sandbox_mode = "workspace-write"
web_search = "cached"
model_reasoning_effort = "medium"

[profiles.review]
personality = "pragmatic"
approval_policy = "on-request"
sandbox_mode = "workspace-write"
web_search = "cached"
model_reasoning_effort = "high"
plan_mode_reasoning_effort = "high"

[profiles.release]
personality = "pragmatic"
approval_policy = "on-request"
sandbox_mode = "workspace-write"
web_search = "live"
model_reasoning_effort = "high"
plan_mode_reasoning_effort = "high"
```

This is the preferred baseline when the repo carries the skill locally.

Use this profile set as follows:

- `setup`: default day-to-day repository setup and bootstrap work
- `review`: deeper contract, code, or documentation review with higher reasoning effort
- `release`: release preparation and final verification with live web search enabled for up-to-date release and docs checks

Keep these profiles separate from multi-agent runtime:

- `profiles.*` define repo-local operating modes
- `features.multi_agent` and `agents.*` define optional orchestration capability
- enabling one does not implicitly require the other

## Optional Multi-Agent Runtime

If the interview says the repository should enable official multi-agent runtime, extend the project config with this exact baseline:

```toml
[features]
multi_agent = true

[agents]
max_threads = 3
max_depth = 2
job_max_runtime_seconds = 900
```

Use this baseline as follows:

- `features.multi_agent = true` enables the official multi-agent collaboration tools.
- `agents.max_threads = 3` keeps concurrency conservative for repo-local work.
- `agents.max_depth = 2` permits coordination without encouraging deep nesting.
- `agents.job_max_runtime_seconds = 900` sets a bounded worker timeout for delegated work.

Keep this layer separate from project-local subagent installation:

- multi-agent runtime config belongs in `.codex/config.toml`
- installed subagent files belong in `.codex/agents/`
- enabling runtime config does not install subagents automatically
- installing project-local subagents does not enable runtime config automatically
- project-local subagents may still be selected directly even when runtime config stays disabled

Do not add `agents.<name>.*` to the baseline. Treat named agent-role config as advanced-only.

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

## Optional Hardening Knobs

These keys are useful, but they are not part of the baseline default:

- `agents.<name>.config_file`
- `agents.<name>.description`
- `agents.<name>.nickname_candidates`
- `mcp_servers.<id>.enabled_tools`
- `mcp_servers.<id>.disabled_tools`
- `mcp_servers.<id>.required`
- `default_permissions`
- `permissions.<name>`
- `notify`
- `shell_environment_policy.*`

Use them only when the repository has a concrete need for tighter MCP tool filtering, named permissions profiles, notifications, or subprocess environment controls.

## Not Recommended By Default

Do not add these to the default project config for this skill:

- `VERSION` files or `CHANGELOG.md` as version sources
- `review_model`
- `model_provider`
- `openai_base_url`
- provider auth configuration
- telemetry or analytics configuration

## What Not To Do

- Do not invent config keys outside the official Codex config reference.
- Do not assume project config loads in untrusted projects.
- Do not treat `features.multi_agent` or `agents.*` as a replacement for installed project-local subagents.
- Do not put the full skill body into `developer_instructions`.
- Do not treat `model_instructions_file` as required when `AGENTS.md` or a thin wrapper is enough.
- Do not replace the standard `setup`, `review`, and `release` profiles with ad-hoc names unless the repo has a strong reason to diverge.
