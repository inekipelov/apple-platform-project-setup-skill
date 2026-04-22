# App README Contract

Use this reference when the repository is app-first and the primary onboarding goal is to explain what the app is, where it runs, where it is distributed, and where deeper project documentation lives.

In this skill, app-first repositories normally map to the `Xcode` workspace path, including both native checked-in `xcodeproj` repositories and `XcodeGen`-generated repositories.

## Goal

Generate a concise app-first `README.md` that contains:

1. app name as the top-level heading
2. one short summary of what the app does
3. centered badges for the minimum supported Apple platforms
4. App Store link when a real production URL exists
5. a short `Technical Stack` section
6. a `Documentation` section with links to internal project docs

Do not force package-installation instructions into an app README unless the repository genuinely needs them.

## Scope

Use this baseline when all of these are true:

- the repo is app-first
- the workspace shape is `Xcode`
- the app itself is the main product the repository presents

Adapt or skip this baseline when any of these are true:

- the repo is package-first or library-first
- the repo is primarily a CLI or developer tool
- the repo has multiple equally important products and needs a broader landing page

## Required Inputs

Resolve these facts before generating or replacing `README.md`:

- app name
- one-sentence summary
- minimum supported Apple platforms
- App Store URL, if any
- actual project technical stack
- internal documentation links

Prefer deriving them from the repository. Ask the user only for the missing or ambiguous facts.

## Input Derivation Rules

### App name

- Prefer the visible product or scheme name the repository presents.
- If the marketing name differs from the target name, use the name the repository documentation consistently uses.

### Summary

- Keep it to one short paragraph or one sentence.
- State what the app is for and who or what it helps.
- Avoid feature dumps in the opening summary.

### Platform badges

- Render only the minimum Apple platforms the project explicitly supports.
- Prefer deployment targets from the checked-in `.xcodeproj`, `project.yml`, or equivalent project source of truth.
- Keep one badge per supported platform.
- Omit uncertain platform claims instead of guessing them.

### App Store link

- Add it only when a real App Store URL exists.
- Prefer the production App Store URL already present in repo docs, release metadata, or user confirmation.
- Never emit a placeholder App Store link.

### Technical Stack

- Keep it short and factual.
- List the primary UI framework, persistence layer, networking layer, architecture style, and notable tooling only when they are actually part of the project.
- Do not include aspirational or optional future technologies.

### Documentation links

- Link to real in-repo documentation such as `docs/`, `Documentation/`, architecture notes, setup guides, or product docs.
- Prefer relative markdown links for repo-local docs.
- If no internal docs exist yet, do not invent a docs link.

## Rendering Rules

- Keep section order exactly: title, summary, badge block, optional App Store line, `Technical Stack`, `Documentation`.
- Use a centered HTML paragraph for badges.
- Keep the README readable without scrolling through implementation details.
- Do not add placeholder sections just to satisfy the template.
- Omit the App Store line when no real URL exists.
- Omit empty documentation bullets instead of linking to non-existent files.

## Existing Repository Policy

For `existing_structured_repo`:

- read the current `README.md` first
- preserve app-specific documentation that is already correct
- replace only when the user explicitly wants alignment to the baseline
- if the current README contains valuable onboarding or release information, preserve or compress it instead of deleting it blindly
