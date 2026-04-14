# Project Interview

Run this interview before generating the repo-specific `AGENTS.md`.

## Interview Goals

Collect the information needed to decide:

- `SPM` vs `Xcode`
- if `Xcode`, `native xcodeproj` vs `Tuist-generated`
- which `Agent Personalization` profile applies
- which snippets apply
- which skill categories are relevant
- which subagent categories are relevant
- which concrete skills are worth installing
- which subagents are worth copying
- which skill and subagent should be recommended first
- whether the repo should carry a project `.codex/config.toml`
- which MCP integrations are useful
- which exact personalization lines and repo rules belong in `AGENTS.md`

## Required Questions

Ask about these topics in order.

### 1. Project Purpose

- What is this project for?
- Is it an app, library, package, CLI, internal tool, template, or mixed workspace?

### 2. Apple Platform Targets

- iOS
- macOS
- watchOS
- tvOS
- visionOS
- multi-platform

### 3. Workspace Shape

- package-first
- app-first
- mixed app plus packages
- Xcode-managed assets or schemes required?

### 4. Xcode Project Strategy

Ask this only after `Xcode` is the likely workspace choice.

- keep a checked-in `xcodeproj`?
- use a generated-project workflow through `Tuist`?
- is there pain around merge conflicts in Xcode project files?
- does the team want declarative manifests as the project source of truth?
- if `Tuist` is chosen, should the repo pin the version with `mise`, or is a simple local CLI install enough?

### 5. Priority Technologies

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

### 6. Repository and Team Policy

- commit convention
- branch strategy
- minimum OS versions
- review expectations
- release workflow
- dependency policy

### 7. Agent Personalization

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

### 8. Optional Tooling

- GitHub Actions required?
- `gitlint` required?
- `SwiftLint` required?
- Apple docs lookup via `sosumi` desired?
- configure a project `.codex/config.toml`?
- use `sosumi` via remote HTTP MCP?
- use `xcode` MCP via `xcrun mcpbridge`? Only ask this if the workspace shape is likely `Xcode`.
- project-local subagents desired?
- should the project add `SFSafeSymbols` and enforce typed SF Symbols?

## Decision Rules

### Choose `SPM` when:

- the project is library-first or package-first
- Xcode-managed assets are not central
- a lightweight workspace is preferred

### Choose `Xcode` when:

- the project is app-first
- app lifecycle targets matter
- asset catalogs, schemes, or project settings are central

### Choose `Tuist` inside `Xcode` when:

- the team wants generated projects instead of checked-in `xcodeproj` files
- declarative manifests are preferred as the project source of truth
- merge conflicts in project files are a meaningful pain point

### Keep native `xcodeproj` inside `Xcode` when:

- the repository wants the simplest Xcode setup
- the team does not want an extra project-generation tool
- there is no strong reason to move away from checked-in Xcode project files

## Outputs to Produce

After the interview, the skill should be able to produce:

- one workspace choice: `SPM` or `Xcode`
- if the workspace is `Xcode`, one Xcode project strategy: `native` or `tuist`
- the top 1-3 skill categories that matter for this project
- the top 1-3 subagent categories that matter for this project
- the final selected skills to install, if any
- the final selected subagents to copy, if any
- the final `Agent Personalization` lines
- the common snippets to apply
- which workspace-specific `SwiftLint` snippet applies
- which `Xcode` snippet set applies when the workspace is `Xcode`
- whether the repo should carry `.codex/config.toml`
- whether `sosumi` MCP should be configured
- whether `xcode` MCP is allowed and desired
- whether `SFSafeSymbols` should be added and whether the SF Symbols SwiftLint rule should exist
- the exact repository rules and command set that must appear in `Repository Rules`
- the final inputs needed to generate a declarative `AGENTS.md`
