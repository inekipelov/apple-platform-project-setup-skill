# Subagents Catalog

This skill recommends project-local subagents only after the project interview and before the final `AGENTS.md` is generated.

Concrete subagent selection is inventory-backed. Use [`../inventory/subagents.yaml`](../inventory/subagents.yaml) as the curated list of verified subagent ids this repo is currently willing to recommend directly.

## Official Codex Rules

Use these official references first:

- Custom agents overview: <https://developers.openai.com/codex/subagents#custom-agents>
- Custom agent file schema: <https://developers.openai.com/codex/subagents#custom-agent-file-schema>

Default storage locations:

- project-local: `.codex/agents/`
- user-level: `~/.codex/agents/`

For this skill, prefer `.codex/agents/` unless the user explicitly asks for global agents.

## Community Source

Curated external source:

- <https://github.com/VoltAgent/awesome-codex-subagents>

Treat it as a catalog, not a bundle to install wholesale.

## Capability Categories

| Category | Typical Need |
|---|---|
| `review` | correctness, regression, and missing-test review |
| `research` | upstream lookup, source-backed investigation, framework validation |
| `docs` | README, `AGENTS.md`, and setup documentation refinement |
| `workflow` | sequencing, orchestration, or task-splitting support |
| `search` | high-signal repo or source search |

## Recommendation Rules

- Copy only selected `.toml` files.
- Keep the set small and role-driven.
- Skip subagents entirely when the repo is tiny or the user does not want them.
- Resolve concrete subagent ids from [`../inventory/subagents.yaml`](../inventory/subagents.yaml).
- In generated `AGENTS.md`, render subagents as `@agent-name`.
- Final selection happens before `AGENTS.md` is generated.
- In `AGENTS.md`, list only installed project-local subagents.
- Every installed `@agent-name` must include a short “when to use” rule.
- If no verified concrete entry exists for a category, do not invent one. Keep the source catalog as a fallback recommendation path.

## Suggested Roles for Apple Workspace Bootstraps

| Role | Why It Helps |
|---|---|
| `reviewer` | correctness, risk, and missing-test review |
| `docs-researcher` | framework and API lookup |
| `workflow-orchestrator` | multi-step setup and sequencing |
| `technical-writer` | refining `AGENTS.md`, README, and setup docs |
| `search-specialist` | finding relevant repo context and source files |

## Installation Procedure

1. Finish the interview.
2. Determine the top 1-3 subagent categories that actually help this repo.
3. Resolve one concrete candidate from [`../inventory/subagents.yaml`](../inventory/subagents.yaml) for each relevant category.
4. Explain why each proposed subagent is useful.
5. Choose one recommended best-fit subagent for each capability gap.
6. Explain why that subagent is the strongest starting point for the current repository state.
7. Move any other relevant candidates into conditional alternatives for client choice.
8. If the inventory has no verified match for a category, stop at the source-catalog recommendation level and do not invent a subagent id.
9. Let the user confirm or override the final subagent choice when multiple candidates are relevant.
10. Copy only the chosen `.toml` files into `.codex/agents/`.
11. Keep names and schemas aligned with the official Codex format.

## AGENTS.md Rendering Rule

When this skill generates or refines `AGENTS.md` after the selected subagents are copied:

- use `@agent-name` syntax
- use the section title `Installed Subagents`
- list only installed project-local subagents
- use the exact line format `- @agent-name: Use for <exact repository task>.`
- if no project-local subagents were copied, use the exact line `- None installed.`
- do not include recommendation prose, alternatives, rationale, or user-choice notes
- do not mention subagents that were considered but not copied

## Things This Skill Must Not Do

- Do not install every agent from an external collection.
- Do not default to user-level `~/.codex/agents/`.
- Do not invent custom agent file schemas.
- Do not copy pre-install comparisons or alternatives into `AGENTS.md`.
