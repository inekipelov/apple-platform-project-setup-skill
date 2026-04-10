# SFSafeSymbols Decision Rule

Use this reference only when Swift source is in scope and the project is expected to use SF Symbols.

## Required Question

Before enabling the `No raw SF Symbol strings` rule, ask:

- should this project add `SFSafeSymbols` via Swift Package Manager?

If the user says no:

- do not add the package dependency
- do not add the `No raw SF Symbol strings` SwiftLint rule

If the user says yes:

- add the `SFSafeSymbols` package dependency
- add the optional SwiftLint fragment from [`../snippets/common/.swiftlint.sfsafesymbols.yml`](../snippets/common/.swiftlint.sfsafesymbols.yml)

## Install Source

Upstream source:

- <https://github.com/SFSafeSymbols/SFSafeSymbols>

## Workspace-Specific Setup

### Xcode project using Xcode-integrated Swift Package Manager

Add the package dependency:

- URL: `https://github.com/SFSafeSymbols/SFSafeSymbols`
- product: `SFSafeSymbols`

### Standalone Swift Package Manager project

Add this package dependency to `Package.swift`:

```swift
.package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols.git", .upToNextMajor(from: "7.0.0"))
```

Then add `SFSafeSymbols` to the target dependencies that should use typed SF Symbols.

## SwiftLint Coupling

The `No raw SF Symbol strings` rule is intentionally optional.

Only add it when `SFSafeSymbols` is present or being added as part of the same setup run.
