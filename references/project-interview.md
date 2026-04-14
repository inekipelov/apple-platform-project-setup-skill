# Project Interview

Run this interview before generating the repo-specific `AGENTS.md`.

## Interview Goals

Collect the information needed to decide:

- `SPM` vs `Xcode`
- which snippets apply
- which skill categories are relevant
- which subagent categories are relevant
- which concrete skills are worth installing
- which subagents are worth copying
- which skill and subagent should be recommended first
- whether the repo should carry a project `.codex/config.toml`
- which MCP integrations are useful
- which rules and constraints belong in `AGENTS.md`

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

### 4. Priority Technologies

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

### 5. Repository and Team Policy

- commit convention
- branch strategy
- minimum OS versions
- review expectations
- release workflow
- dependency policy

### 6. Optional Tooling

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

## Outputs to Produce

After the interview, the skill should be able to produce:

- one workspace choice: `SPM` or `Xcode`
- the top 1-3 skill categories that matter for this project
- the top 1-3 subagent categories that matter for this project
- one recommended skill per capability gap, with rationale and conditional alternatives
- one recommended subagent per capability gap, with rationale and conditional alternatives
- the common snippets to apply
- which workspace-specific `SwiftLint` snippet applies
- whether the repo should carry `.codex/config.toml`
- whether `sosumi` MCP should be configured
- whether `xcode` MCP is allowed and desired
- whether `SFSafeSymbols` should be added and whether the SF Symbols SwiftLint rule should exist
- a point where the user can confirm or override the final selection
- the final inputs needed to generate `AGENTS.md`
