# Apple Platform Project Setup Plugin

[![Codex Plugin](https://custom-icon-badges.demolab.com/badge/Codex-74aa9c?logo=openai&logoColor=black)](https://github.com/inekipelov/apple-platform-project-setup-skill)

Codex plugin for bootstrapping and standardizing Apple workspaces.

It ships one orchestration skill plus phase-based leaf skills for discovery, interview, workspace selection, capability install, `.codex/config.toml`, artifact application, `AGENTS.md`, and verification.

## Plugin Layout

- Plugin manifest: [plugins/apple-platform-project-setup/.codex-plugin/plugin.json](./plugins/apple-platform-project-setup/.codex-plugin/plugin.json)
- Repo marketplace for local testing: [.agents/plugins/marketplace.json](./.agents/plugins/marketplace.json)
- Orchestration skill: [plugins/apple-platform-project-setup/skills/apple-platform-project-setup-skill/SKILL.md](./plugins/apple-platform-project-setup/skills/apple-platform-project-setup-skill/SKILL.md)
- Leaf skills live under [plugins/apple-platform-project-setup/skills/](./plugins/apple-platform-project-setup/skills)

The orchestration skill is the only implicit entrypoint. The phase skills are explicit-use helpers with narrow trigger scopes.

## Install

For Codex, the shortest supported install path is to add this repository as a marketplace source:

```bash
codex plugin marketplace add inekipelov/apple-platform-project-setup-skill --ref main
```

This command loads [.agents/plugins/marketplace.json](./.agents/plugins/marketplace.json), which exposes the single bundled plugin at `./plugins/apple-platform-project-setup`.

For a pinned install, replace `main` with a release tag:

```bash
codex plugin marketplace add inekipelov/apple-platform-project-setup-skill --ref 0.1.2
```

After adding the marketplace, open the Plugin Directory and enable `Apple Platform Setup` if your Codex build does not surface it automatically.

## Local Development

To test the marketplace from a local checkout instead of GitHub:

```bash
codex plugin marketplace add .
```

Then open the Plugin Directory and enable `Apple Platform Setup` from the local marketplace.

## Source Of Truth

- [plugins/apple-platform-project-setup/.codex-plugin/plugin.json](./plugins/apple-platform-project-setup/.codex-plugin/plugin.json)
- [plugins/apple-platform-project-setup/skills/apple-platform-project-setup-skill/SKILL.md](./plugins/apple-platform-project-setup/skills/apple-platform-project-setup-skill/SKILL.md)
- [catalog.yaml](./catalog.yaml)
- [references/project-interview.md](./references/project-interview.md)
- [snippets/common/AGENTS.bootstrap.md](./snippets/common/AGENTS.bootstrap.md)

## Notes

- Vendored orchestration skill path for `[[skills.config]]`: `plugins/apple-platform-project-setup/skills/apple-platform-project-setup-skill/SKILL.md`
- This repository enforces `type(scope): summary` commits with mandatory repo-specific scopes via root `.gitlint`
- Advanced config and MCP guidance: [references/codex-config.md](./references/codex-config.md), [references/mcp-setup.md](./references/mcp-setup.md)
- Maintainer release contract: short-lived `release/x.y.z` branches, stable `vX.Y.Z` tags, and GitHub Releases as the changelog. See [references/release-management.md](./references/release-management.md)
