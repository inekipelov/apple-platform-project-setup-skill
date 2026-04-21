# Capability Discovery

Run this step before the project interview and before proposing any install.

## What To Discover

Inspect the current environment and repo-local setup for:

- plugin-provided skills already available in the active Codex session
- project-local skills under `.codex/skills/`
- project-local subagents under `.codex/agents/`
- configured MCP servers in `.codex/config.toml`, when present

Record:

- `discovered_plugins`
- `discovered_project_local_skills`
- `discovered_project_local_subagents`
- `discovered_mcp_servers`

Plugins discovered in this step are session-level capabilities, not project-local
repository artifacts. Do not install, clone, copy, or mirror a plugin into the
target repository as part of this skill flow.

## Recommended Plugin Surfaces For Apple Projects

When these plugins are already available in the active Codex session, treat them
as the default plugin capability surfaces to compare before proposing project-local
installs:

- `Build iOS Apps` for native iOS app build, run, simulator, and debugging work
- `Build macOS Apps` for native macOS build, run, test, and debugging work
- `Expo` for Expo and React Native app workflows, including Codex run wiring and
  Expo-managed iOS simulator loops

## Superpowers Policy

For this repository:

- Superpowers is treated as a Codex plugin capability surface
- `obra/superpowers` is not a project-local skill install target
- do not clone, symlink, or otherwise install `obra/superpowers` as part of this skill flow

If the active Codex environment already exposes skills such as `$brainstorming` or `$writing-skills`, treat them as available workflow capabilities and continue.

## Expo iOS Simulator Guidance

For Expo projects, keep the default local loop on the Expo-managed path:

- prefer Expo Go with `expo start` first
- for iOS simulator launch, prefer `expo start --ios` or a project-local Codex
  `Run iOS` action that resolves to the same path
- do not default to `expo run:ios`, prebuild, or `eas build` just to get a
  simulator loop
- use `expo-dev-client` only when custom native code, Apple targets, or native
  modules outside Expo Go require a development client
- when a dev client is required, start Metro with `npx expo start --dev-client`
  and use a simulator install path such as `xcrun simctl install booted <App.app>`

## Why This Comes First

This step prevents two classes of mistakes:

- proposing installs for capabilities the environment or repo already provides
- confusing plugin-provided skills with project-local installed skills
- skipping a lower-risk Expo simulator workflow and jumping straight to native
  project generation or cloud build steps

The skill should only install missing project-local skills or copy missing project-local subagents after this discovery step and after the project interview.
