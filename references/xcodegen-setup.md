# XcodeGen Setup

Use this document only after the workspace choice is already `Xcode`.

## Repo Policy

- `XcodeGen` is an optional `Xcode` sub-mode in this repository.
- It is not a third top-level workspace shape.
- The default inside `Xcode` remains native checked-in `xcodeproj`.
- Offer `XcodeGen` when the repository wants generated `xcodeproj` files and a declarative project spec.

## Official Sources

- XcodeGen repository and usage: <https://github.com/yonaskolb/XcodeGen>
- XcodeGen releases: <https://github.com/yonaskolb/XcodeGen/releases>

## Installation Path

Use the official Homebrew route:

```bash
brew install xcodegen
```

## Project Structure Rule

For the XcodeGen path in this repository:

- `project.yml` is the source of truth
- generated `.xcodeproj` files are outputs, not the canonical editable project definition

## Canonical v1 Files

The v1 XcodeGen path in this repository uses:

- `project.yml`

Do not add extra project spec files in v1 unless the repository explicitly needs them.

## CI Rule

For XcodeGen-managed `Xcode` repositories in this skill:

- install `xcodegen` in CI
- run `xcodegen generate --spec project.yml`
- then run `xcodebuild` build and test commands against the generated `.xcodeproj`

## Xcode MCP Rule

If the repository uses `XcodeGen` and the user wants `xcode` MCP:

1. run `xcodegen generate --spec project.yml`
2. open the generated `.xcodeproj` in Xcode
3. then configure `xcode` MCP through `xcrun mcpbridge`
