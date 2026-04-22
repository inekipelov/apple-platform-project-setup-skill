# Skills Catalog

Use this document after the user interview is complete and before the final `AGENTS.md` is generated.

Concrete skill selection is inventory-backed. Use [`../inventory/skills.yaml`](../inventory/skills.yaml) as the curated list of verified skill ids this repo is currently willing to recommend directly.

## Selection Rules

1. Discover the current plugin, project-local skill, and project-local subagent surface before proposing any skill install.
2. Treat Superpowers as a plugin capability surface, not as a skill install target.
3. Prefer `skills.sh` installation commands when the chosen source supports them.
4. Treat every external skills source as a multi-skill catalog unless the source explicitly proves otherwise.
5. Recommend the smallest relevant set of missing skills.
6. Choose a capability category before choosing a concrete skill.
7. Do not install every skill from a relevant catalog.
8. Do not install skills before the project interview.
9. Prefer project-local install under `.codex/skills/` when the installer supports it.
10. If the installer only supports user-level install, explain that limitation and ask before proceeding.
11. In generated `AGENTS.md`, render skills as `$skill-name`.
12. Final selection happens before `AGENTS.md` is generated.
13. In `AGENTS.md`, list only installed project-local skills under `Installed Skills`.
14. Put skill timing and order only under `Skill Usage Order`.
15. If no verified concrete entry exists for a category, do not invent one. Keep the source catalog as a fallback recommendation path.
16. Do not force a skill install for needs that are already satisfied by repo artifacts such as `.swiftlint.yml`, `.gitlint`, workflows, or `.codex/config.toml`.

## Capability Categories

Use categories to decide which part of a catalog matters before you look for a concrete skill name.

| Category | Typical Need |
|---|---|
| `ui` | SwiftUI, UIKit, AppKit, view composition, Apple UI patterns |
| `persistence` | SwiftData, Core Data, schema design, storage lifecycle |
| `app-architecture` | feature boundaries, dependency injection, state ownership, app wiring |
| `package-design` | Swift Package Manager structure, modularization, library setup |
| `testing` | test strategy, XCTest patterns, verification helpers |
| `tooling` | Swift tooling, concurrency correctness, local quality workflow |
| `ci-automation` | GitHub Actions, CI workflows, automation runners |
| `release-automation` | release notes, App Store release workflow, release summary helpers |
| `repo-automation` | repository maintenance, contributor workflow, repo helpers |
| `networking` | URLSession, service integration, API-client structure |

## Skill Sources

| Source | Prefer When | Install Preference | Notes |
|---|---|---|---|
| `skills.sh/twostraws` | SwiftUI, persistence, testing, Apple platform patterns | `skills.sh` | Prefer this before manual repo fallback |
| `skills.sh/avdlee` | Swift engineering, UI, persistence, tooling, testing | `skills.sh` | Apple-focused catalog |
| `skills.sh/dimillian/skills` | SwiftUI app architecture, GitHub automation, release workflow, package-oriented helpers | `skills.sh` | Useful after CI, release, or SwiftUI architecture needs are known |
| `dpearson2699/swift-ios-skills` | Apple-focused fallback for networking, SwiftUI interop, and iOS architecture gaps | Upstream instructions | Use only when needed |

Interpret each source row above as a catalog, not as one skill.

## Inventory Contract

- [`../inventory/skills.yaml`](../inventory/skills.yaml) is a curated subset, not a full mirror of every upstream catalog.
- Each entry is a concrete recommendation target with an id, category, `coverage_tags`, source artifact, install metadata, verification metadata, and alternatives.
- `coverage_tags` map interview signals such as `swiftdata`, `dependency-injection`, `github-actions`, or `release-notes` to the strongest concrete candidate inside a category.
- `verified_on`, `platform_scope`, and `confidence` exist to make curation freshness and fit explicit.
- Only recommend inventory-backed skill ids as concrete defaults.
- If a useful source has no seeded entry for the current category, say so explicitly and leave it as a fallback path for manual exploration.

## Runtime Procedure

1. Finish the project interview.
2. Compare the interview result against the discovered capability surface.
3. Determine the top 1-3 capability categories or gaps that are still missing.
4. Map each missing category to a skill source catalog.
5. Resolve one concrete candidate from [`../inventory/skills.yaml`](../inventory/skills.yaml) for that source and category.
6. Use `coverage_tags` to narrow the candidate against the actual interview signal, such as `core-data`, `dependency-injection`, `github-actions`, or `release-notes`.
7. For each missing capability category, choose one recommended best-fit skill.
8. Explain why that skill is the strongest starting point for the current repository state.
9. If the same source exposes multiple relevant skills in that category, keep the strongest fit as the recommendation and move the rest into conditional alternatives.
10. If the category is already covered by a discovered plugin-provided skill, do not force a project-local install just to mirror that capability.
11. If the inventory has no verified match for a category, stop at the source-catalog recommendation level and do not invent a skill id.
12. Let the user confirm or override the final skill choice when multiple candidates are relevant.
13. For each selected missing skill:
   - prefer the exact `npx skills add ...` command when available
   - otherwise use the upstream installation method
14. Summarize proposed installs before executing them.

## AGENTS.md Rendering Rule

When this skill generates or refines `AGENTS.md` after the selected skills are installed:

- use `$skill-name` syntax
- use the section title `Installed Skills`
- list only installed project-local skills
- use the exact line format `- $skill-name: Use for <exact repository task>.`
- if no project-local skills were installed, use the exact line `- None installed.`
- use the section title `Skill Usage Order` for ordered skill instructions
- use the exact line format `- Step <n>: Use $skill-name when <exact repository situation>.`
- plugin-provided skills may appear in `Skill Usage Order` when they are part of the intended workflow
- do not include recommendation prose, alternatives, rationale, or user-choice notes
- do not mention skills that were considered but not installed

## Install Command Pattern

When a `skills.sh` entry exists, prefer the published pattern:

```bash
npx skills add <repo-url> --skill <skill-name>
```

If the installer supports an explicit project-local target, use that.

If it does not, stop and ask whether a user-level install is acceptable.

## Example Capability Mapping

| Need | Likely Source |
|---|---|
| SwiftUI view composition and patterns | `twostraws` |
| Dependency injection and SwiftUI app wiring | `dimillian` |
| SwiftData or Core Data persistence | `twostraws` or `avdlee` |
| Swift package design | `dimillian` |
| Swift tooling and concurrency guardrails | `avdlee` |
| App Store release notes and release summaries | `dimillian` |
| GitHub workflow and repo automation help | `dimillian` |
| iOS networking or Apple interop with no better `skills.sh` match | `dpearson2699` fallback |

If more than one catalog can help, narrow the comparison before install and keep only the final selected installed skill in `AGENTS.md`.

Do not install an entire source catalog just because its category is relevant.

## Installation Notes

- `npx` is the preferred installer path when available.
- If `npx` is missing, follow [`tool-install-policy.md`](tool-install-policy.md).
- Never invent a package name. Use the published catalog entry or upstream instructions.
