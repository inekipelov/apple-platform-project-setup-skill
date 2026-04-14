# AGENTS.md

This repository is an Apple platform workspace.

Use this bootstrap template to generate the repo-specific `AGENTS.md` after the project interview and after the selected skills and subagents are already in place.

## Bootstrap Rules

- Treat this file as the repo-local guidance source until richer project documentation exists.
- Use `$writing-skills` when drafting or restructuring future versions of this file.
- Do not install global tools or modify user-home directories without explicit confirmation.
- Prefer project-local skills and project-local subagents unless the user explicitly wants global setup.

## Reference Syntax

- Reference skills as `$skill-name`.
- Reference subagents as `@agent-name`.
- This file must describe only the final installed repo state.
- Do not include recommendation prose, alternatives, rationale, or user-choice notes.
- Every installed `$skill-name` or `@agent-name` must include a short rule that says when to apply it.

## Current Unknowns To Resolve

- final project purpose
- agent personalization profile
- target Apple platforms
- `SPM` vs `Xcode`
- if `Xcode`, native `xcodeproj` vs `Tuist-generated`
- UI stack and priority technologies
- testing strategy
- CI expectations
- commit and review policy

## Default Workflow

- Explore the repository before making changes.
- Resolve the unknowns above through direct user dialogue before generating this file.
- Keep setup decisions reversible until the project interview is complete and the selected skills and subagents are confirmed.
- Run relevant verification before claiming setup is complete.

## Local Skill and Subagent Locations

- Project-local skills: `.agents/skills/`
- Project-local subagents: `.codex/agents/`

## Required AGENTS.md Structure

Use these exact section titles in this exact order.

### Repository Purpose

- `- Purpose: <one-sentence repository purpose>`

### Agent Personalization

- `- Communication language: <final chosen language or Use the language the client used to contact the agent.>`
- `- Pushback policy: Challenge user decisions that introduce hacks, security weaknesses, or long-term technical debt; do not silently agree with them.`
- `- Quality priority: Favor quality, security, and maintainability over speed.`
- `- Long-term priority: Prefer scalable and maintainable solutions over short-term speed.`
- `- Temporary fixes policy: Do not accept "temporary" solutions without an explicit cleanup plan.`
- `- Risk disclosure: If a risky shortcut is chosen, state the risks explicitly in the final response.`

### Workspace

- `- Shape: SPM` or `- Shape: Xcode`
- `- Target platforms: <platform list>`
- `- Xcode project strategy: native xcodeproj` or `- Xcode project strategy: Tuist-generated` only when the shape is `Xcode`

### Project Structure Source Of Truth

- `- Source of truth: <exact project-structure source of truth>`
- `- Xcode generation: Not required.` or `- Xcode generation: Run \`tuist generate\` before opening in Xcode when needed.`

### Core Commands

- `- Setup: <command>` or `- Setup: Not defined.`
- `- Build: <command>`
- `- Test: <command>`
- `- Lint: <command>` or `- Lint: Not configured.`
- `- Project generation: Not required.` or `- Project generation: tuist generate`

### Installed Skills

- Exact line format for each installed skill: `- $skill-name: Use for <exact repository task>.`
- If none were installed: `- None installed.`

### Installed Subagents

- Exact line format for each installed subagent: `- @agent-name: Use for <exact repository task>.`
- If none were installed: `- None installed.`

### Repository Rules

- Exact line prefix for every rule: `- Rule: <non-negotiable repository rule>`

## Follow-Up

After the interview and after the selected skills and subagents are installed or intentionally skipped, turn this bootstrap template into a project-specific `AGENTS.md` that captures:

- repo purpose
- final agent personalization lines
- workspace shape
- if `Xcode`, the chosen Xcode project strategy
- core commands
- installed project-local skills
- installed project-local subagents
- non-negotiable repo rules

For Tuist-based repositories, the final `AGENTS.md` should also capture:

- that `Project.swift` and `Tuist.swift` are the project-structure source of truth
- that `tuist generate` may be required before working in Xcode
- that build and test commands go through `tuist build` and `tuist test`
