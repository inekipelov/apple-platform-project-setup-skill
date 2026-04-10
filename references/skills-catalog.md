# Skills Catalog

Use this document after the user interview is complete and before the final `AGENTS.md` is generated.

Concrete skill selection is inventory-backed. Use [`../inventory/skills.yaml`](../inventory/skills.yaml) as the curated list of verified skill ids this repo is currently willing to recommend directly.

## Selection Rules

1. `obra/superpowers` is mandatory baseline and always comes first.
2. Prefer `skills.sh` installation commands when the chosen source supports them.
3. Treat every external skills source as a multi-skill catalog unless the source explicitly proves otherwise.
4. Recommend the smallest relevant set of skills.
5. Choose a capability category before choosing a concrete skill.
6. Do not install every skill from a relevant catalog.
7. Do not install skills before the project interview.
8. Prefer project-local install under `.agents/skills/` when the installer supports it.
9. If the installer only supports user-level install, explain that limitation and ask before proceeding.
10. In generated `AGENTS.md`, render skills as `$skill-name`.
11. For each capability gap, recommend one best-fit skill and move other relevant candidates into conditional alternatives.
12. Every recommended `$skill-name` must include a short “when to use” rule.
13. Every recommended `$skill-name` must include a short “why recommended now” explanation.
14. The skill helps the user choose one, but the final choice remains with the user.
15. If no verified concrete entry exists for a category, do not invent one. Keep the source catalog as a fallback recommendation path.

## Capability Categories

Use categories to decide which part of a catalog matters before you look for a concrete skill name.

| Category | Typical Need |
|---|---|
| `ui` | SwiftUI, UIKit, AppKit, view composition, Apple UI patterns |
| `architecture` | feature boundaries, project structure, dependency flow |
| `package-design` | Swift Package Manager structure, modularization, library setup |
| `testing` | test strategy, XCTest patterns, verification helpers |
| `tooling` | Swift tooling, local dev utilities, lint-related workflow |
| `ci-automation` | GitHub Actions, automation workflows, release helpers |
| `repo-automation` | repository maintenance, contributor workflow, repo helpers |
| `apple-fallback` | Apple-specific patterns when no better catalog match exists |

## Skill Sources

| Source | Prefer When | Install Preference | Notes |
|---|---|---|---|
| `obra/superpowers` | Every setup run | Official install flow | Baseline prerequisite |
| `skills.sh/twostraws` | SwiftUI, Apple UI, app architecture, Apple platform patterns | `skills.sh` | Prefer this before manual repo fallback |
| `skills.sh/avdlee` | Swift engineering, UI, tooling, testing, architecture | `skills.sh` | Apple-focused catalog |
| `skills.sh/dimillian/skills` | GitHub automation, repo automation, package-oriented workflow helpers | `skills.sh` | Useful after CI or repo automation needs are known |
| `dpearson2699/swift-ios-skills` | Apple-focused fallback when a suitable `skills.sh` entry is not available | Upstream instructions | Use only when needed |

Interpret each source row above as a catalog, not as one skill.

## Inventory Contract

- [`../inventory/skills.yaml`](../inventory/skills.yaml) is a curated subset, not a full mirror of every upstream catalog.
- Each entry is a concrete recommendation target with an id, category, source artifact, install metadata, and alternatives.
- Only recommend inventory-backed skill ids as concrete defaults.
- If a useful source has no seeded entry for the current category, say so explicitly and leave it as a fallback path for manual exploration.

## Runtime Procedure

1. Finish the project interview.
2. Determine the top 1-3 capability categories or gaps.
3. Map each category to a skill source catalog.
4. Resolve one concrete candidate from [`../inventory/skills.yaml`](../inventory/skills.yaml) for that source and category.
5. For each capability category, choose one recommended best-fit skill.
6. Explain why that skill is the strongest starting point for the current repository state.
7. If the same source exposes multiple relevant skills in that category, keep the strongest fit as the recommendation and move the rest into conditional alternatives.
8. If the inventory has no verified match for a category, stop at the source-catalog recommendation level and do not invent a skill id.
9. Let the user confirm or override the final skill choice when multiple candidates are relevant.
10. For each selected skill:
   - prefer the exact `npx skills add ...` command when available
   - otherwise use the upstream installation method
11. Summarize proposed installs before executing them.

## AGENTS.md Rendering Rule

When this skill generates or refines `AGENTS.md` after the selected skills are installed:

- use `$skill-name` syntax
- list one recommended skill per capability gap
- attach one short usage rule to that recommendation
- attach one short “why recommended now” explanation
- list other relevant skills only in `Optional Alternatives` with `choose instead if ...` conditions
- add one short note that the user makes the final skill choice
- do not present multiple skills as equal defaults for the same need

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
| Swift package design | `dimillian` |
| Swift tooling and concurrency guardrails | `avdlee` |
| GitHub workflow and repo automation help | `dimillian` |
| Apple mobile patterns with no matching `skills.sh` entry | `dpearson2699` fallback |

If more than one catalog can help, choose the strongest fit as the recommendation, explain why, and keep the rest as conditional alternatives. The final decision still belongs to the user.

Do not install an entire source catalog just because its category is relevant.

## Installation Notes

- `npx` is the preferred installer path when available.
- If `npx` is missing, follow [`tool-install-policy.md`](tool-install-policy.md).
- Never invent a package name. Use the published catalog entry or upstream instructions.
