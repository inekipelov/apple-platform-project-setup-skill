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

## 2. Official `obra/superpowers` Installation

Use the official `obra/superpowers` install instructions before any other workspace setup:

- Repository: <https://github.com/obra/superpowers>
- Codex install instructions: <https://raw.githubusercontent.com/obra/superpowers/refs/heads/main/.codex/INSTALL.md>

This source decides:

- clone location
- symlink location
- update path

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
- <https://docs.github.com/en/actions/tutorials/build-and-test-code/swift>
- <https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/controlling-permissions-for-github_token>
- <https://developer.apple.com/documentation/xcode/giving-external-agents-access-to-xcode>
- <https://sosumi.ai>

For external integrations:

- Apple decides how `xcrun mcpbridge` is exposed from Xcode.
- `sosumi.ai` decides the remote MCP endpoint and CLI usage.
- GitHub decides the current workflow syntax, least-privilege token guidance, and Swift CI examples.
- This repo may narrow those options as policy. For v1, `xcode` MCP is only allowed for `xcode` workspaces.

## 5. Community Examples

Community examples are recommendation and curation inputs only.

They may influence:

- which skills to propose
- which subagents to copy
- which optional tools to mention
- which alternative recommendations are worth surfacing

They must not override:

- official Codex paths
- official `superpowers` installation
- repo-local snippets
- explicit user preferences

## Recommendation Collapsing Rule

Source precedence resolves which catalog or upstream source to trust first.

It does not mean every relevant item from that source should appear as a peer in `AGENTS.md`.
It also does not mean the whole catalog should be installed.

After precedence is resolved:

- choose one capability category first
- resolve one concrete candidate from `inventory/skills.yaml` or `inventory/subagents.yaml`
- choose one recommended `$skill-name` per capability gap
- choose one recommended `@agent-name` per capability gap
- attach a short usage rule and short rationale to each recommendation
- list other relevant candidates only as conditional alternatives for client choice
- keep the final decision with the user
- if the inventory is not seeded for that category yet, stop at the source-catalog recommendation level instead of inventing an id

## Artifact Apply Contract

Once the source is chosen and the repo shape is known, snippet-backed repo files must follow `catalog.yaml`.

For every snippet-backed artifact:

- `target_path` decides the output path in the target repo
- `apply_mode` decides whether the snippet is copied, generated from a template, or merged
- `conflict_policy` decides whether an existing non-empty file requires confirmation before replace or merge
- `merge_strategy` exists only for merge-style artifacts

Do not invent overwrite or merge behavior outside this contract.

## Operational Rules

- Never invent skill names or custom agent names.
- Never infer `skills.sh` support without checking a source entry.
- Never auto-install global tools or make user-home changes.
- Prefer repo-local snippets for file content once the project shape is known.
- Never treat a relevant source link as permission to install the whole catalog.
- Never list multiple skills or subagents as equal defaults for the same capability gap.
- Never treat the recommendation as replacing the user's final choice.
- Never invent `config.toml` keys or MCP server fields outside the official Codex config reference.
- Never configure `xcode` MCP for an `spm` workspace in this skill.
- Never require the `sosumi` CLI when remote HTTP MCP is already available.
