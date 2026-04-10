# Tool Install Policy

This repository assumes prerequisite checks happen before the related tool is used.

## Tools to Check

- `npx`
- `gitlint`
- `swiftlint`
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
- `gitlint` and `swiftlint` are required only when those repo artifacts are selected.
- `gh` is optional unless the user explicitly wants GitHub CLI workflow help.
- `xcrun` matters only when `xcode` MCP is selected for an `xcode` workspace.
- `sosumi` is optional unless the user explicitly wants Apple documentation lookup through that CLI.
- `sosumi` HTTP MCP does not require the `sosumi` CLI.
