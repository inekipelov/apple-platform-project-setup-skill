# SPM README Contract

Use this reference when the workspace shape is `SPM` and the repository is primarily a library or package that consumers integrate through Swift Package Manager.

Do not treat this as a universal README for every SwiftPM repository. Executable-first, CLI-first, and app-like SwiftPM repos often need a different onboarding flow and different section ordering.

## Goal

Generate a concise `README.md` in the style of [`inekipelov/swift-json-value`](https://github.com/inekipelov/swift-json-value/blob/main/README.md):

1. package name as the top-level heading
2. one-sentence package summary directly under the title
3. centered badge block for explicit support claims
4. `Usage` section with one minimal real example
5. `Installation` section with the SwiftPM dependency snippet

Keep the README short. Do not add sections such as architecture notes, release process, contribution guide, or changelog unless the repository already needs them and the user explicitly wants them.

## Scope

Use this baseline when all of these are true:

- the repo is `SPM`
- the repo is library-first or package-first
- the primary onboarding path is adding the package as a dependency

Adapt or skip this baseline when any of these are true:

- the repo is CLI-first or executable-first
- the repo is an app packaged through SwiftPM but not consumed mainly as a package dependency
- the repo has multiple products with equally important onboarding paths

## Required Inputs

Resolve these facts before generating or replacing `README.md`:

- package name
- one-sentence package summary
- explicit Swift compiler support claim, if any
- explicit Apple platform support claims, if any
- repository URL
- installation version strategy
- one real public API usage example

Prefer deriving them from the repository. Ask the user only for the missing or ambiguous facts.

## Input Derivation Rules

### Package name

- Prefer the package or primary library product name from `Package.swift`.
- If the public import name differs from the package name, use the public import name in the code example and keep the visible title aligned with the main product name the repo presents.

### Summary

- Keep it to one sentence.
- State what the package does and the practical value it provides.
- Avoid vague summaries such as "utilities for Swift projects" unless that breadth is truly the package contract.

### Swift badge

- Render the Swift badge only when compiler support is explicit in repo docs, CI, release notes, or user confirmation.
- Do not infer Swift compiler support solely from `swift-tools-version`.

### Platform badges

- Render only the platforms explicitly supported by `Package.swift` or another authoritative repo source.
- Keep one badge per supported Apple platform.
- Omit unknown platform claims instead of guessing them.

### Usage example

- The snippet must use real public API from the package.
- The snippet must be minimal and copyable.
- Prefer a single end-to-end example over a fragmented API catalog.
- If `Foundation` is not needed, do not import it.
- Do not invent convenience APIs, operators, or behavior that the package does not expose.

### Installation snippet

- Prefer `.package(url: "<repo-url>", from: "<latest-stable-version>")` when a stable tag exists.
- If the package is unreleased, do not fabricate a version number.
- Use a branch-based example only when unreleased branch consumption is an explicit repository policy.
- If no release/install policy is explicit yet, ask the user instead of shipping placeholders as if they were final documentation.

## Rendering Rules

- Keep section order exactly: title, summary, badge block, `Usage`, `Installation`.
- Use a centered HTML paragraph for badges.
- Keep badge styling consistent with Swift and Apple platform shields.
- Keep the README readable without scrolling through large examples.
- Do not duplicate the installation snippet elsewhere in the file.
- Do not add `Overview` if the summary sentence already does the job.

## Existing Repository Policy

For `existing_structured_repo`:

- read the current `README.md` first
- preserve package-specific documentation that is already correct
- replace only when the user explicitly wants alignment to the baseline
- if the current README contains additional valuable sections, compress or preserve them instead of deleting them blindly
