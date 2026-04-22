# Source Precedence

This skill must resolve conflicts in the following order.

## 1. Official Codex Documentation

Use official Codex documentation first for storage locations and schemas:

- Skills storage: <https://developers.openai.com/codex/skills#where-to-save-skills>
- Subagent storage and schema: <https://developers.openai.com/codex/subagents#custom-agents>
- Config and `AGENTS.md` behavior: <https://developers.openai.com/codex/config-reference#configtoml>

These sources decide:

- where skills live
- where custom agents live
- which fields a custom agent file must define
- how project-level guidance is discovered
- which `config.toml` keys are valid for project config and MCP setup
- which `config.toml` keys are valid for official multi-agent runtime

Local repository state also matters once the skill is already running inside a structured repo:

- existing repo structure is a high-priority local signal
- discovered workspace shape and project strategy should override bootstrap defaults unless the user explicitly asks to migrate
- existing local files should be compared and confirmed, not blindly replaced

## 2. Current Codex Environment And Repo-Local Capability Surface

Inspect the current environment before proposing installs:

- plugin-provided skills already available in the current session
- project-local skills in `.codex/skills/`
- project-local subagents in `.codex/agents/`
- configured MCP servers in `.codex/config.toml`

This source decides:

- which workflow capabilities are already available
- which project-local skills are already installed
- which project-local subagents are already installed
- which MCP integrations are already configured
- which plugin-provided capabilities can be used immediately without any repo-local plugin install step

This source does not authorize:

- installing plugins into the repository
- cloning or mirroring plugin bundles into project-local paths
- treating plugin availability as the same thing as project-local skill installation

For this repository:

- Superpowers is treated as a Codex plugin capability surface
- `obra/superpowers` is not a project-local skill install target

## 3. `skills.sh` Installation Commands

When a selected community skill is available on `skills.sh`, prefer the published `npx skills add ...` command.

Use these source catalogs:

- <https://skills.sh/avdlee>
- <https://skills.sh/twostraws>
- <https://skills.sh/dimillian/skills>

This source decides:

- default install command
- installable skill names
- whether a bundle supports `skills.sh`

These links point to catalogs that may contain many skills.

They do not mean:

- install every skill from that source
- treat the source URL as one monolithic skill
- skip category selection

## 4. Upstream Repository Instructions

If `skills.sh` is unavailable or the source is not published there, fall back to upstream instructions.

Primary fallbacks for this repo:

- <https://github.com/twostraws/Swift-Agent-Skills>
- <https://github.com/dpearson2699/swift-ios-skills>
- <https://github.com/VoltAgent/awesome-codex-subagents>
- <https://github.com/SFSafeSymbols/SFSafeSymbols>
- <https://github.com/yonaskolb/XcodeGen>
- <https://docs.github.com/en/actions/tutorials/build-and-test-code/swift>
- <https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/controlling-permissions-for-github_token>
- <https://developer.apple.com/documentation/xcode/giving-external-agents-access-to-xcode>
- <https://sosumi.ai>

For external integrations:

- Apple decides how `xcrun mcpbridge` is exposed from Xcode.
- `sosumi.ai` decides the remote MCP endpoint and CLI usage.
- XcodeGen decides the supported install paths, generated-project workflow, and `project.yml` source-of-truth model for XcodeGen-managed Xcode repositories.
- GitHub decides the current workflow syntax, least-privilege token guidance, and Swift CI examples.
- This repo may narrow those options as policy. For v1, `xcode` MCP is only allowed for `xcode` workspaces, and `XcodeGen` is an `Xcode` sub-mode rather than a third top-level workspace shape.

## 5. Community Examples

Community examples are recommendation and curation inputs only.

They may influence:

- which skills to propose
- which subagents to copy
- which optional tools to mention
- which candidate items are worth comparing before the user confirms

They must not override:

- official Codex paths
- discovered current environment capabilities
- repo-local snippets
- explicit user preferences

## Selection Narrowing Rule

Source precedence resolves which catalog or upstream source to trust first.

It also does not mean the whole catalog should be installed.

After precedence is resolved:

- choose one capability category first
- use `coverage_tags` to narrow the interview signal inside that chosen category
- resolve one concrete candidate from `inventory/skills.yaml` or `inventory/subagents.yaml`
- choose one recommended `$skill-name` per capability gap
- choose one recommended `@agent-name` per capability gap
- keep the final decision with the user
- if the inventory is not seeded for that category yet, stop at the source-catalog recommendation level instead of inventing an id
- after the user confirms the final selection, write only that final installed state into `AGENTS.md`
- write skill timing and order only under the fixed `Skill Usage Order` section in `AGENTS.md`

## Artifact Apply Contract

Once the source is chosen and the repo shape is known, snippet-backed repo files must follow `catalog.yaml`.

For every snippet-backed artifact:

- `target_path` decides the output path in the target repo
- `apply_mode` decides whether the snippet is copied, copied as multiple named files, generated from a template, or merged
- `conflict_policy` decides whether an existing non-empty file requires confirmation before replace or merge
- `merge_strategy` exists only for merge-style artifacts

Do not invent overwrite or merge behavior outside this contract.

## Operational Rules

- Never invent skill names or custom agent names.
- Never infer `skills.sh` support without checking a source entry.
- Never auto-install global tools or make user-home changes.
- Never try to install `obra/superpowers` as a project-local skill.
- Prefer repo-local snippets for file content once the project shape is known.
- Never treat a relevant source link as permission to install the whole catalog.
- Never list multiple skills or subagents as equal defaults for the same capability gap.
- Never treat the recommendation as replacing the user's final choice.
- Never copy pre-install comparisons, alternatives, or recommendation rationale into `AGENTS.md`.
- `Agent Personalization` stores communication and behavior policy. `Core Commands` stores workflow commands. `Repository Rules` stores repo-specific constraints and process rules that are not commands.
- Never duplicate the same policy line in both `Agent Personalization` and `Repository Rules`.
- Never duplicate commands in `Repository Rules`.
- Never use first-person wording or the word `Report` in generated `AGENTS.md`.
- Never invent `config.toml` keys or MCP server fields outside the official Codex config reference.
- Never treat official multi-agent runtime config in `.codex/config.toml` as the same thing as installed project-local subagents in `.codex/agents/`.
- Never collapse profile operating modes and multi-agent runtime into one undifferentiated config layer.
- Never configure `xcode` MCP for an `spm` workspace in this skill.
- Never require the `sosumi` CLI when remote HTTP MCP is already available.
- Never treat `XcodeGen` as a third workspace shape in this repository.
