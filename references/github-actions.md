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
- `Xcode` build and test

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

## `Xcode` Build and Test Workflows

The `Xcode` workflow snippets should:

- run on `macos-15`
- select the latest stable Xcode
- keep `DerivedData` inside the repository workspace for deterministic CI paths
- resolve Swift package dependencies into a known source packages directory before build or test
- disable code signing in CI by passing `CODE_SIGNING_ALLOWED=NO`

These snippets are app-first and may assume Xcode project or scheme inputs.
