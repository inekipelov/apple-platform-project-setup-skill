# SwiftLint Setup

Use this document when deciding which SwiftLint snippet to apply.

## Shape-Specific Rule

Do not treat SwiftLint as a single shape-agnostic snippet in this repository.

After the workspace choice is known:

- use [`../snippets/spm/.swiftlint.yml`](../snippets/spm/.swiftlint.yml) for `SPM`
- use [`../snippets/xcode/.swiftlint.yml`](../snippets/xcode/.swiftlint.yml) for `Xcode`

## Shared Policy vs Applied Snippet

[`../snippets/common/.swiftlint.base.yml`](../snippets/common/.swiftlint.base.yml) is the shared policy reference.

It is not the default output file for the target repository.

The target repository should receive exactly one shape-specific `.swiftlint.yml`, then optional fragments may be merged on top.

## Existing-Repo Alignment

For `existing_structured_repo` runs:

- treat an existing `.swiftlint.yml` as current repo state, not as a missing bootstrap file
- compare it against the selected shape-specific snippet before proposing changes
- preserve repo-specific rules unless the user explicitly wants canonical replacement
- do not replace the file blindly just because the workspace shape is now known

## `SPM` SwiftLint

The `SPM` SwiftLint snippet should stay package-oriented:

- exclude SwiftPM build metadata and package manager state
- avoid Xcode-only folder assumptions
- avoid asset-catalog-specific string-literal rules by default

## `Xcode` SwiftLint

The `Xcode` SwiftLint snippet should stay app-oriented:

- exclude Xcode build folders and common dependency-manager folders
- include typed asset rules for `UIImage(named:)`, `Image("...")`, and `Color("...")`
- remain compatible with optional `SFSafeSymbols` merging

This same `Xcode` SwiftLint snippet is shared by both native `xcodeproj` repositories and `Tuist`-generated `Xcode` repositories.

## Optional SF Symbols Rule

The `SFSafeSymbols` fragment from [`../snippets/common/.swiftlint.sfsafesymbols.yml`](../snippets/common/.swiftlint.sfsafesymbols.yml) may be merged only after:

1. the user accepted `SFSafeSymbols`
2. the workspace-specific `.swiftlint.yml` is already selected

Do not merge the SF Symbols rule into an undefined or shape-agnostic SwiftLint file.
