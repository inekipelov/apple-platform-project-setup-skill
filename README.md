# Apple Platform Project Setup Skill

[![ChatGPT](https://custom-icon-badges.demolab.com/badge/Codex-74aa9c?logo=openai&logoColor=white)]()

Codex skill for bootstrapping and standardizing Apple workspaces.

It interviews the user, detects existing repo structure, chooses or confirms `SPM` vs `Xcode`, supports native `xcodeproj` or `XcodeGen`-generated `xcodeproj`, configures `.codex/config.toml` and optional MCP, applies repo snippets, and generates final-state `AGENTS.md`.

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

- [SKILL.md](/Users/inekipelov/Developer/apple-platform-project-setup-skill/SKILL.md)
- [catalog.yaml](/Users/inekipelov/Developer/apple-platform-project-setup-skill/catalog.yaml)
- [references/](/Users/inekipelov/Developer/apple-platform-project-setup-skill/references/project-interview.md)
- [snippets/](/Users/inekipelov/Developer/apple-platform-project-setup-skill/snippets/common/AGENTS.bootstrap.md)

## Notes

- Project-local install path: `.codex/skills/apple-platform-project-setup-skill`
- This repository enforces `type(scope): summary` commits with mandatory repo-specific scopes via root `.gitlint`
- Advanced config and MCP guidance: [codex-config.md](/Users/inekipelov/Developer/apple-platform-project-setup-skill/references/codex-config.md), [mcp-setup.md](/Users/inekipelov/Developer/apple-platform-project-setup-skill/references/mcp-setup.md)
- Maintainer release contract: [release-management.md](/Users/inekipelov/Developer/apple-platform-project-setup-skill/references/release-management.md)
