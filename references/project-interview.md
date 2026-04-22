# Project Interview

Run this interview before generating the repo-specific `AGENTS.md`.

## Interview Goals

Collect the information needed to decide:

- which plugins, project-local skills, project-local subagents, and MCP servers are already available
- whether this is a `greenfield` or `existing_structured_repo` run
- whether current repo structure already reveals the workspace choice
- `SPM` vs `Xcode`
- if `Xcode`, `native xcodeproj` vs `XcodeGen-generated`
- which `Agent Personalization` profile applies
- which snippets apply
- which skill categories are relevant
- which subagent categories are relevant
- which concrete skills are worth installing
- which subagents are worth copying
- which ordered skill instructions should appear in final `AGENTS.md`
- whether the repo should carry a project `.codex/config.toml`
- whether the repo should enable official multi-agent runtime in project `.codex/config.toml`
- which MCP integrations are useful
- which parts of an existing repo should be standardized now
- which exact personalization lines and repo rules belong in `AGENTS.md`

## Required Questions

Ask about these topics in order.

### 1. Capability Discovery And Repository State

Before asking for new setup choices, inspect the current Codex and repo-local capability surface:

- plugin-provided skills already available in the current session
- project-local skills under `.codex/skills/`
- project-local subagents under `.codex/agents/`
- configured MCP servers in `.codex/config.toml`, when present

Record:

- `discovered_plugins`
- `discovered_project_local_skills`
- `discovered_project_local_subagents`
- `discovered_mcp_servers`

Treat Superpowers as a plugin capability surface, not as a skill install target.

Before asking for new setup choices, inspect the repository and classify it:

- `greenfield`
- `existing_structured_repo`

Use structural signals such as:

- `Package.swift`
- `*.xcodeproj`
- `*.xcworkspace`
- `project.yml`
- `.gitignore`
- `.swiftlint.yml`
- `.gitlint`
- `.github/workflows/`
- `.codex/config.toml`
- `AGENTS.md`

If the repo is already structured, start the interview by confirming detected choices instead of asking from a blank slate.

### 2. Project Purpose

- What is this project for?
- Is it an app, library, package, CLI, internal tool, template, or mixed workspace?

### 3. Apple Platform Targets

- iOS
- macOS
- watchOS
- tvOS
- visionOS
- multi-platform

### 4. Workspace Shape

- package-first
- app-first
- mixed app plus packages
- Xcode-managed assets or schemes required?

For `existing_structured_repo`:

- first confirm the detected workspace shape
- do not re-choose `SPM` vs `Xcode` from defaults when the repo already makes that clear

### 5. Xcode Project Strategy

Ask this only after `Xcode` is the likely workspace choice.

- keep a checked-in `xcodeproj`?
- use a generated-project workflow through `XcodeGen`?
- is there pain around merge conflicts in Xcode project files?
- does the team want declarative manifests as the project source of truth?
- if `XcodeGen` is chosen, is the simple local Homebrew install path enough?

For `existing_structured_repo`:

- if the repo already uses `project.yml` for `XcodeGen`, confirm that `XcodeGen` remains the source of truth unless the user explicitly wants migration
- if the repo already uses native `xcodeproj`, confirm that native remains the source of truth unless the user explicitly wants migration

### 6. Priority Technologies

- SwiftUI
- UIKit
- AppKit
- SwiftData
- Core Data
- networking stack
- dependency injection
- testing stack
- automation and CI tools
- typed SF Symbols via `SFSafeSymbols`

### 7. Repository and Team Policy

- commit convention
- branch strategy
- minimum OS versions
- review expectations
- release workflow
- dependency policy
- for existing repos, which areas should be aligned now: config, agents, lint, CI, or targeted fixes only

### 8. Package README Inputs

Ask this only when the workspace is likely `SPM` and the repository is library-first or package-first.

- should the repo use the concise library-style `README.md` baseline?
- what one-sentence summary should appear under the package title?
- which Swift compiler support claim is explicit enough to show as a badge?
- which Apple platform minimum versions are explicit enough to show as badges?
- what installation example should be documented: latest stable tag or an explicit unreleased branch policy?
- which minimal public API example should lead the `Usage` section?

If the repo already exposes these facts through `Package.swift`, tags, CI, or existing docs, derive them instead of asking every question directly.

### 9. App README Inputs

Ask this only when the workspace is likely `Xcode` and the repository is app-first.

- should the repo use the app-first `README.md` baseline?
- what short summary should appear under the app title?
- which minimum Apple platform versions are explicit enough to show as badges?
- is there a real App Store URL that should be linked?
- which technologies belong in the technical stack because the project actually uses them now?
- which internal project docs should be linked from the README?

If the repo already exposes these facts through deployment targets, existing docs, release metadata, or project structure, derive them instead of asking every question directly.

### 10. Agent Personalization

- which communication language should be fixed in `AGENTS.md`?
- should the agent challenge hacks, security weaknesses, and long-term technical debt?
- should quality, security, and maintainability outrank speed?
- should temporary fixes require an explicit cleanup plan?
- should risky shortcuts always be called out in the final response?

If the user gives no explicit communication-language answer:

- use `- Communication language: Use the language the client used to contact the agent.`
- keep the strict-quality baseline for the other five personalization lines

If the user gives no other explicit personalization answers:

- keep the strict-quality baseline for the other five personalization lines

### 11. Optional Tooling

- GitHub Actions required?
- `gitlint` required?
- `SwiftLint` required?
- Apple docs lookup via `sosumi` desired?
- configure a project `.codex/config.toml`?
- if `.codex/config.toml` is desired, use the standard `setup` / `review` / `release` profile set?
- if `.codex/config.toml` is desired, enable official multi-agent runtime with the baseline `features.multi_agent` and `agents.*` keys?
- if multi-agent runtime is enabled, continue into the project-local subagent selection flow?
- use `sosumi` via remote HTTP MCP?
- use `xcode` MCP via `xcrun mcpbridge`? Only ask this if the workspace shape is likely `Xcode`.
- if multi-agent runtime is not enabled, are project-local subagents still desired directly?
- should the project add `SFSafeSymbols` and enforce typed SF Symbols?

For the multi-agent branch, keep this order exact:

1. ask whether the repo should carry `.codex/config.toml`
2. if yes, ask whether the standard `setup` / `review` / `release` profiles should be used
3. if yes or the repo still wants project config, ask whether official multi-agent runtime should be enabled
4. if multi-agent runtime is enabled, record the runtime baseline and then ask separately whether to continue into the project-local subagent flow
5. if multi-agent runtime is not enabled, ask separately whether project-local subagents are still desired directly

## Decision Rules

### Choose `SPM` when:

- the project is library-first or package-first
- Xcode-managed assets are not central
- a lightweight workspace is preferred

### Choose `Xcode` when:

- the project is app-first
- app lifecycle targets matter
- asset catalogs, schemes, or project settings are central

### Choose `XcodeGen` inside `Xcode` when:

- the team wants generated projects instead of checked-in `xcodeproj` files
- declarative manifests are preferred as the project source of truth
- merge conflicts in project files are a meaningful pain point

### Keep native `xcodeproj` inside `Xcode` when:

- the repository wants the simplest Xcode setup
- the team does not want an extra project-generation tool
- there is no strong reason to move away from checked-in Xcode project files

## Outputs to Produce

After the interview, the skill should be able to produce:

- `discovered_plugins`
- `discovered_project_local_skills`
- `discovered_project_local_subagents`
- `discovered_mcp_servers`
- `repo_state = greenfield | existing_structured_repo`
- `detected_workspace_shape = spm | xcode | unknown`
- `detected_xcode_project_strategy = native | xcodegen | unknown`
- one workspace choice: `SPM` or `Xcode`
- if the workspace is `Xcode`, one Xcode project strategy: `native` or `xcodegen`
- the top 1-3 skill categories that matter for this project
- the top 1-3 subagent categories that matter for this project
- the final selected skills to install, if any
- the final selected subagents to copy, if any
- the ordered skill instructions that should appear in `Skill Usage Order`
- whether the concise `SPM` README baseline applies
- the package README inputs: package name, summary, explicit Swift support claim, explicit Apple platform claims, installation coordinates, and usage example
- whether the app-first README baseline applies
- the app README inputs: app name, summary, minimum Apple platform claims, App Store URL if any, technical stack list, and internal documentation links
- the final `Agent Personalization` lines
- the common snippets to apply
- which workspace-specific `SwiftLint` snippet applies
- which `Xcode` snippet set applies when the workspace is `Xcode`
- whether the repo should carry `.codex/config.toml`
- whether the standard `setup` / `review` / `release` `.codex/config.toml` profiles should be used
- whether official multi-agent runtime should be enabled in `.codex/config.toml`
- whether the multi-agent runtime should use the repository baseline config
- whether project-local subagents are desired
- whether project-local subagent selection was requested directly or as a follow-up to multi-agent runtime activation
- `standardization_scope = full_bootstrap | config_only | agents_only | lint_only | ci_only | targeted_alignment`
- whether `sosumi` MCP should be configured
- whether `xcode` MCP is allowed and desired
- whether `SFSafeSymbols` should be added and whether the SF Symbols SwiftLint rule should exist
- the exact command set that must appear in `Core Commands`
- the exact repository rules that must appear in `Repository Rules`
- the final inputs needed to generate a declarative `AGENTS.md`

Use these exact internal decision outputs for the multi-agent branch:

- `multi_agent_runtime_enabled = true | false`
- `multi_agent_runtime_config_mode = baseline | none`
- `multi_agent_runtime_config = { features.multi_agent: true, agents.max_threads: 3, agents.max_depth: 2, agents.job_max_runtime_seconds: 900 } | none`
- `project_local_subagents_desired = true | false`
- `subagent_flow_trigger = direct | after_multi_agent_runtime | none`

Use these exact internal decision outputs for repo-state handling:

- `repo_state = greenfield | existing_structured_repo`
- `detected_workspace_shape = spm | xcode | unknown`
- `detected_xcode_project_strategy = native | xcodegen | unknown`
- `standardization_scope = full_bootstrap | config_only | agents_only | lint_only | ci_only | targeted_alignment`
