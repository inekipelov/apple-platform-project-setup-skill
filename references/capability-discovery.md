# Capability Discovery

Run this step before the project interview and before proposing any install.

## What To Discover

Inspect the current environment and repo-local setup for:

- plugin-provided skills already available in the active Codex session
- project-local skills under `.codex/skills/`
- project-local subagents under `.codex/agents/`
- configured MCP servers in `.codex/config.toml`, when present

Record:

- `discovered_plugins`
- `discovered_project_local_skills`
- `discovered_project_local_subagents`
- `discovered_mcp_servers`

## Superpowers Policy

For this repository:

- Superpowers is treated as a Codex plugin capability surface
- `obra/superpowers` is not a project-local skill install target
- do not clone, symlink, or otherwise install `obra/superpowers` as part of this skill flow

If the active Codex environment already exposes skills such as `$brainstorming` or `$writing-skills`, treat them as available workflow capabilities and continue.

## Why This Comes First

This step prevents two classes of mistakes:

- proposing installs for capabilities the environment or repo already provides
- confusing plugin-provided skills with project-local installed skills

The skill should only install missing project-local skills or copy missing project-local subagents after this discovery step and after the project interview.
