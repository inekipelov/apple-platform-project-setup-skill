---
name: apple-platform-workspace-selection
description: Use when the Apple setup flow needs to choose or confirm SPM versus Xcode, native versus XcodeGen, and the required tool prerequisites for the selected workspace shape.
---

# Apple Platform Workspace Selection

Use this skill after capability discovery and the project interview.

## When to Use

Use this skill when:

- the workspace shape is still undecided
- an existing repo needs its current workspace strategy confirmed
- `XcodeGen` versus native `xcodeproj` is still open
- tool prerequisites depend on the selected workspace path

## Workspace Rules

- If the repo already clearly uses `SPM`, keep `SPM` unless the user explicitly wants migration.
- If the repo already clearly uses native `xcodeproj`, keep native unless the user explicitly wants migration.
- If the repo already clearly uses `project.yml`, keep `XcodeGen` unless the user explicitly wants migration.
- Treat `XcodeGen` as an `Xcode` sub-mode, not as a third workspace shape.

Choose `SPM` when:

- the project is package-first, library-first, CLI-first, or intentionally lightweight

Choose `Xcode` when:

- the project is app-first
- app lifecycle targets matter
- asset catalogs, schemes, or Xcode project settings are central

Within `Xcode`:

- keep native checked-in `xcodeproj` as the default
- offer `XcodeGen` only when declarative manifests or project-file merge relief are explicit goals

## Tool Prerequisite Checks

Check for:

- `npx`
- `gitlint`
- `swiftlint`
- `xcodegen` when the selected strategy is `XcodeGen`
- `gh` when GitHub automation is requested
- `xcrun` when `xcode` MCP is requested for an `xcode` workspace
- `sosumi` only when the user explicitly wants the CLI
- `mcp-remote` only when the user wants the `sosumi` stdio fallback

If a required tool is missing:

- explain why it is needed
- propose one concrete global install command
- wait for explicit confirmation before running it

## Snippet Set Selection

Resolve one path only:

- `SPM`
- `Xcode + native`
- `Xcode + XcodeGen`

The selected path controls README baseline, `.gitignore`, SwiftLint snippet, workflow snippets, and Xcode generation behavior.

## References

- [`references/tool-install-policy.md`](../../../../references/tool-install-policy.md)
- [`references/xcodegen-setup.md`](../../../../references/xcodegen-setup.md)
- [`catalog.yaml`](../../../../catalog.yaml)
