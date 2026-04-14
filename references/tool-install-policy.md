# Tool Install Policy

This repository assumes prerequisite checks happen before the related tool is used.

## Tools to Check

- `npx`
- `gitlint`
- `swiftlint`
- `tuist`
- `gh`
- `xcrun`
- `sosumi`

## Global Install Rule

If one of these tools is missing, the skill must:

1. explain why the tool is needed
2. propose one concrete install command
3. wait for explicit confirmation

The skill must never auto-run global installs.

## Preferred Install Suggestions

Use the package manager already available on the machine when possible.

### `npx`

`npx` usually comes with Node.js.

Possible suggestion:

```bash
brew install node
```

### `gitlint`

Possible suggestions:

```bash
brew install gitlint
```

or:

```bash
pipx install gitlint
```

### `swiftlint`

Possible suggestion:

```bash
brew install swiftlint
```

### `tuist`

Simplest suggestion:

```bash
brew tap tuist/tuist
brew install --formula tuist
```

Deterministic repo-pinned suggestion when the project wants a tracked Tuist version:

```bash
brew install mise
mise use --pin tuist@latest
```

Do not require `mise` when the repository only needs the simplest Tuist install path.

### `gh`

Possible suggestion:

```bash
brew install gh
```

### `sosumi`

Possible suggestion:

```bash
npm i -g @nshipster/sosumi
```

### `xcrun`

Do not treat `xcrun` like a normal global package install.

If `xcrun` is missing when `xcode` MCP is requested:

- explain that `xcrun mcpbridge` comes from Xcode tooling
- point the user to install or update Xcode instead of inventing a package-manager install

## Fallback Rule

If no supported package manager is available, do not invent a workaround.

Instead:

- point the user to the upstream installation instructions
- continue without the optional tool when that is safe

## Optional vs Required

- `npx` is required only when the selected skill source uses `skills.sh` or when the user explicitly chooses an `mcp-remote` stdio proxy path.
- `gitlint` is required only when the gitlint repo artifacts are selected.
- `swiftlint` is required only when the chosen workspace-specific SwiftLint artifact is selected.
- `tuist` is required only when the selected `Xcode` project strategy is `Tuist`.
- `gh` is optional unless the user explicitly wants GitHub CLI workflow help.
- `xcrun` matters only when `xcode` MCP is selected for an `xcode` workspace.
- `sosumi` is optional unless the user explicitly wants Apple documentation lookup through that CLI.
- `sosumi` HTTP MCP does not require the `sosumi` CLI.
