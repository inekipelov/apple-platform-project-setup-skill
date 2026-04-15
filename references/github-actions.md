# GitHub Actions Setup

Use this document when applying or refining the canonical GitHub Actions snippets in this repository.

## Source Preference

For workflow structure and permissions, prefer official GitHub documentation:

- <https://docs.github.com/en/actions/tutorials/build-and-test-code/swift>
- <https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/controlling-permissions-for-github_token>

For selecting Xcode on GitHub-hosted macOS runners, use the `setup-xcode` action documentation:

- <https://github.com/maxim-lobanov/setup-xcode>

## Common Workflow Guardrails

Every workflow snippet in this repository should include:

- `workflow_dispatch` in addition to the normal repository events
- top-level `permissions` with the least privilege needed; use `contents: read` by default
- top-level `concurrency` so older runs for the same branch or PR are cancelled
- an explicit shell for run steps
- a job-level timeout

Keep these guardrails aligned across:

- `gitlint`
- `SPM` build and test
- native `Xcode` build and test
- `Xcode + Tuist` build and test

## Existing-Repo Alignment

For `existing_structured_repo` runs:

- treat existing workflow files as current repo state, not missing bootstrap outputs
- compare the existing workflow against the selected canonical snippet before proposing changes
- preserve repo-specific jobs, triggers, or environment details unless the user explicitly wants canonical replacement
- replace or rewrite workflow files only after explicit confirmation

## `gitlint` Workflow

The `gitlint` workflow should:

- fetch full history
- lint the pushed commit range on `push`
- lint the PR commit range on `pull_request`
- handle the initial push case where `github.event.before` is all zeros

## `SPM` Build and Test Workflows

The `SPM` workflow snippets should:

- run on `macos-15`
- select the latest stable Xcode
- cache SwiftPM dependency directories, not arbitrary derived build products
- use `swift build --build-tests` for the build workflow
- use `swift test --parallel` for the test workflow

These snippets are package-first and should stay free of Xcode-project-specific assumptions.

## Native `Xcode` Build and Test Workflows

The native `Xcode` workflow snippets should:

- run on `macos-15`
- select the latest stable Xcode
- keep `DerivedData` inside the repository workspace for deterministic CI paths
- resolve Swift package dependencies into a known source packages directory before build or test
- disable code signing in CI by passing `CODE_SIGNING_ALLOWED=NO`

These snippets are app-first and may assume checked-in Xcode project or scheme inputs.

## `Xcode + Tuist` Build and Test Workflows

The `Xcode + Tuist` workflow snippets should:

- run on `macos-15`
- select the latest stable Xcode
- install Tuist before invoking Tuist commands
- use `jdx/mise-action@v2` when the repo pins Tuist through `.tool-versions`
- use the Homebrew install path when the repo does not pin Tuist
- run `tuist install` before `tuist build` or `tuist test`
- use explicit env vars such as `TUIST_SCHEME` instead of relying on all-schemes behavior

For this repo contract, the Tuist workflow path uses `tuist build <scheme>` and `tuist test <scheme>` as the default CI commands for generated-project repositories.

## Maintainer Release Workflow For This Repository

This repository also maintains its own release-preparation workflow in `.github/workflows/prepare-release.yml`.

That maintainer workflow should:

- use `workflow_dispatch` only
- run from a short-lived `release/x.y.z` branch, not directly from `main`
- accept a stable `x.y.z` version input without a `v` prefix
- reject non-stable version strings such as prereleases
- require explicit confirmation that CI is green and manual doc review is complete
- run the repo contract verification script before tagging
- create the `vX.Y.Z` tag
- create a draft GitHub Release with auto-generated notes
- leave final note editing and publication to the maintainer in GitHub

Use `.github/release.yml` to keep the generated release notes grouped by the repo label taxonomy.
