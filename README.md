# Apple Platform Project Setup Skill

[![Codex Skill](https://custom-icon-badges.demolab.com/badge/Codex-74aa9c?logo=openai&logoColor=black)](https://github.com/inekipelov/apple-platform-project-setup-skill)

Codex skill for bootstrapping and standardizing Apple workspaces.

It discovers the current Codex capability surface, interviews the user, detects existing repo structure, chooses or confirms `SPM` vs `Xcode`, supports native `xcodeproj` or `XcodeGen`-generated `xcodeproj`, configures `.codex/config.toml` and optional MCP, applies repo snippets, and generates final-state `AGENTS.md`.

## Install

Recommended for Codex:

```bash
npx skills add inekipelov/apple-platform-project-setup-skill -a codex
```

GitHub URL fallback:

```bash
npx skills add https://github.com/inekipelov/apple-platform-project-setup-skill -a codex
```

## Source Of Truth

- [SKILL.md](./SKILL.md)
- [catalog.yaml](./catalog.yaml)
- [references/project-interview.md](./references/project-interview.md)
- [snippets/common/AGENTS.bootstrap.md](./snippets/common/AGENTS.bootstrap.md)

## Notes

- Project-local install path: `.codex/skills/apple-platform-project-setup-skill`
- This repository enforces `type(scope): summary` commits with mandatory repo-specific scopes via root `.gitlint`
- Advanced config and MCP guidance: [references/codex-config.md](./references/codex-config.md), [references/mcp-setup.md](./references/mcp-setup.md)
- Maintainer release contract: short-lived `release/x.y.z` branches, stable `vX.Y.Z` tags, and GitHub Releases as the changelog. See [references/release-management.md](./references/release-management.md)
