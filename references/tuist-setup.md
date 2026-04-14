# Tuist Setup

Use this document only after the workspace choice is already `Xcode`.

## Repo Policy

- `Tuist` is an optional `Xcode` sub-mode in this repository.
- It is not a third top-level workspace shape.
- The default inside `Xcode` remains native checked-in `xcodeproj`.
- Offer `Tuist` when the repository wants generated projects and declarative manifests.

## Official Sources

- Install Tuist: <https://docs.tuist.dev/en/guides/install-tuist>
- Create a generated project: <https://docs.tuist.dev/en/guides/features/projects/adoption/new-project>
- Tuist CI guidance: <https://docs.tuist.dev/en/guides/automate/continuous-integration>
- `Tuist` manifest reference: <https://docs.tuist.dev/en/references/project-description/structs/tuist>

## Installation Paths

### Simplest local path

Use the official Homebrew route:

```bash
brew tap tuist/tuist
brew install --formula tuist
```

### Repo-pinned deterministic path

Use `mise` when the repository wants a tracked Tuist version:

```bash
mise use --pin tuist@latest
```

If the repository wants a specific version, replace `latest` with the chosen version.

## Project Structure Rule

For the Tuist path in this repository:

- `Project.swift` and `Tuist.swift` are the source of truth
- generated `xcodeproj` or `xcworkspace` files are outputs, not the canonical editable manifests

## Canonical v1 Files

The v1 Tuist path in this repository uses:

- `Project.swift`
- `Tuist.swift`

Do not add `Workspace.swift` or `Config.swift` in v1.

## CI Rule

For Tuist-managed `Xcode` repositories in this skill:

- install Tuist in CI
- run `tuist install`
- use `tuist build <scheme>` for build jobs
- use `tuist test <scheme>` for test jobs

If the repo pins Tuist through `.tool-versions`, prefer `jdx/mise-action@v2`. Otherwise use the Homebrew install path.

## Xcode MCP Rule

If the repository uses `Tuist` and the user wants `xcode` MCP:

1. run `tuist generate`
2. open the generated project or workspace in Xcode
3. then configure `xcode` MCP through `xcrun mcpbridge`
