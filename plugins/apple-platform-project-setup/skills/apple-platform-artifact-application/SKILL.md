---
name: apple-platform-artifact-application
description: Use when the Apple setup flow needs to apply or align README, SwiftLint, workflows, .gitignore, XcodeGen, and other snippet-backed repository artifacts after setup decisions are final.
---

# Apple Platform Artifact Application

Apply or refine repo artifacts only after discovery, interview, workspace choice, and capability decisions are settled.

## When to Use

Use this skill when:

- snippet-backed artifacts need to be applied to a new repo
- an existing repo needs targeted preserve-first alignment
- README shape depends on whether the repo is package-first or app-first
- SwiftLint, workflows, `.gitignore`, or XcodeGen files need shape-specific handling

## Artifact Scope

Apply or refine:

- package-first `README.md` from [`snippets/spm/README.md`](../../../../snippets/spm/README.md) using [`references/spm-readme.md`](../../../../references/spm-readme.md)
- app-first `README.md` from [`snippets/xcode/README.md`](../../../../snippets/xcode/README.md) using [`references/app-readme.md`](../../../../references/app-readme.md)
- [`snippets/common/.gitlint`](../../../../snippets/common/.gitlint)
- workspace-specific SwiftLint
- optional `SFSafeSymbols` SwiftLint fragment
- [`snippets/common/workflows/gitlint.yml`](../../../../snippets/common/workflows/gitlint.yml)
- selected build and test workflows
- selected `.gitignore`
- `project.yml` when the chosen path is `Xcode + XcodeGen`

## Catalog Contract

Always apply snippet-backed artifacts using the contract in [`catalog.yaml`](../../../../catalog.yaml):

- `target_path`
- `apply_mode`
- `conflict_policy`
- `merge_strategy`

Do not improvise paths, overwrite behavior, or merge behavior outside that contract.

## Existing Repository Policy

For `existing_structured_repo`:

- preserve first, standardize second
- compare existing files against the selected canonical intent
- propose only the aligned change set the user actually wants
- do not replace `.gitignore`, `.swiftlint.yml`, `.gitlint`, workflows, `.codex/config.toml`, or `AGENTS.md` without explicit confirmation

## SwiftLint And README Rules

- choose the SwiftLint snippet only after the workspace shape is known
- ask about `SFSafeSymbols` before adding the `No raw SF Symbol strings` rule
- use the concise package README baseline only for library-first or package-first repos
- use the app-first README baseline only for app-first repos
- never emit placeholder App Store links

## References

- [`catalog.yaml`](../../../../catalog.yaml)
- [`references/github-actions.md`](../../../../references/github-actions.md)
- [`references/swiftlint-setup.md`](../../../../references/swiftlint-setup.md)
- [`references/spm-readme.md`](../../../../references/spm-readme.md)
- [`references/app-readme.md`](../../../../references/app-readme.md)
- [`references/xcodegen-setup.md`](../../../../references/xcodegen-setup.md)
