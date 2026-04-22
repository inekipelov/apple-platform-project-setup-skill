# Release Management

Use this document when cutting releases for this repository.

## Release Model

This repository uses a manual maintainer-focused release flow:

- `main` is the integration branch
- each release uses a short-lived `release/x.y.z` branch
- the version source is the stable git tag `vX.Y.Z` plus the matching GitHub Release
- GitHub Releases are the only changelog
- release notes start as auto-generated draft notes and are edited manually before publication

Do not use:

- a permanent `release` branch
- direct publishing from `main`
- `VERSION` files
- `CHANGELOG.md` as a second changelog
- prerelease version strings such as `-rc.1`, `-beta`, or `-alpha`

## Naming Rules

- release branch: `release/x.y.z`
- tag: `vX.Y.Z`
- stable version input: `x.y.z`

The release branch name and version input must match exactly.

## Release Gates

Before creating the tag and draft GitHub Release, require all of these:

- CI workflows are green
- repo contract verification is green
- YAML parse checks are green
- manual review of `README.md`, `plugins/apple-platform-project-setup/.codex-plugin/plugin.json`, `plugins/apple-platform-project-setup/skills/`, `catalog.yaml`, and contract/reference docs is complete

The maintainer release workflow enforces the version and branch rules and requires explicit confirmation of CI and manual review before it proceeds.

## Maintainer Workflow

1. Branch from `main` into `release/x.y.z`.
2. Finish any release-only stabilization on that branch.
3. Ensure the repo validation workflow is green.
4. Run the manual `Prepare Release` workflow from that release branch.
5. Provide the stable `x.y.z` version input and confirm CI and manual review.
6. Let the workflow create the `vX.Y.Z` tag and a draft GitHub Release with generated notes.
7. Review the draft notes in GitHub, edit them manually, and publish the release.
8. Merge or fast-forward the short-lived release branch back into `main` if it contains release-only fixes.

## Release Notes Taxonomy

Use `.github/release.yml` to group auto-generated release notes by these labels:

- `breaking`
- `contract`
- `docs`
- `ci`
- `lint`
- `skills`
- `mcp`
- `release`

Use `breaking` only for backward-incompatible changes to the skill contract or maintainer workflow.
