# Skill Verification

This file records the baseline failure evidence and the expected post-change behavior for this repository.

## RED Baseline Evidence

Initial repository state before this change:

- no `SKILL.md`
- no `catalog.yaml`
- no `references/`
- no `snippets/`
- no install policy
- no `AGENTS.md` bootstrap content
- no discovery metadata beyond a placeholder `README.md`

Because the repository had no workflow contract, each planned failure mode was effectively possible:

1. An agent could skip capability discovery and start proposing installs immediately.
2. An agent could install `gitlint` or `swiftlint` globally without an explicit policy telling it to stop.
3. An agent could generate `AGENTS.md` before the interview, installation choices, and final setup decisions are complete.
4. An agent could ignore `skills.sh` because no precedence rule existed.
5. An agent could choose `SPM` or `Xcode` without running a project interview.
6. An agent could present a recommended skill or subagent as if that recommendation overrode the user's final choice.
7. An agent could enable the `No raw SF Symbol strings` rule without asking whether the project should add `SFSafeSymbols`.
8. An agent could treat a relevant skills source link as a reason to install the whole catalog instead of choosing a category first.
9. An agent could guess a concrete skill or subagent id without a verified curated inventory entry.
10. An agent could overwrite or merge snippet-backed files without a declared target path or conflict policy.
11. An agent could invent project `.codex/config.toml` keys instead of following the official Codex config reference.
12. An agent could require the `sosumi` CLI even when `sosumi` HTTP MCP would have been enough.
13. An agent could configure `xcode` MCP for an `spm` workspace.
14. An agent could apply one shared SwiftLint config without respecting the chosen workspace shape.
15. An agent could ship GitHub Actions snippets without explicit permissions, concurrency, or deterministic CI behavior.
16. An agent could treat `XcodeGen` as a third workspace shape instead of an `Xcode` sub-mode.
17. An agent could suggest `XcodeGen` while the repo is on the `SPM` path.
18. An agent could choose `XcodeGen` and still apply native `Xcode` artifacts.
19. An agent could configure `xcode` MCP for an XcodeGen repo without requiring a generated project to be open in Xcode.
20. An agent could copy recommendations, alternatives, or selection rationale into the final `AGENTS.md` instead of recording only the final installed repo state.
21. An agent could omit `Agent Personalization`, use the wrong line prefixes, or fall back to free-form prose.
22. An agent could use first-person wording or the word `Report` inside the generated `AGENTS.md`.
23. An agent could duplicate the same behavioral rule in both `Agent Personalization` and `Repository Rules`.
24. An agent could skip asking which communication language should be fixed and silently invent a language policy.
25. An agent could mix the canonical `.codex/skills/` path with a legacy project-local skill path.
26. An agent could place commands in `Repository Rules` or duplicate them outside `Core Commands`.
27. A maintainer could publish directly from `main` or rely on a permanent `release` branch instead of a short-lived `release/x.y.z` branch.
28. The repo could treat `VERSION` files or `CHANGELOG.md` as required even though the intended version source is the tag plus GitHub Release only.
29. The repo could lack a manual release-preparation workflow and rely on ad-hoc local release steps.
30. Auto-generated GitHub Release notes could be left uncategorized because the repo has no release-note label taxonomy.
31. The `.codex/config.toml` guidance could omit the standard `setup`, `review`, and `release` profiles or recommend unsupported baseline keys.
32. Advanced config knobs such as MCP tool filtering, named permissions profiles, or telemetry could be treated as baseline defaults instead of optional hardening.
33. An agent could confuse official multi-agent runtime config in `.codex/config.toml` with installed project-local subagents in `.codex/agents/`.
34. An agent could enable multi-agent runtime and silently install subagents without a second explicit decision.
35. An agent could install project-local subagents and silently mutate `.codex/config.toml` to enable multi-agent runtime.
36. The interview could enable multi-agent runtime without recording whether project-local subagents were requested directly or only as a follow-up.
37. The config contract could blur profile operating modes and multi-agent runtime into one undifferentiated settings layer.
38. The skill could still reject already-structured repositories as out of scope instead of switching into an audit-and-align mode.
39. The skill could detect an existing `SPM`, native `Xcode`, or `XcodeGen` structure and still re-run bootstrap defaults as if the folder were empty.
40. The skill could overwrite existing `.gitignore`, `.swiftlint.yml`, `.gitlint`, workflows, `.codex/config.toml`, or `AGENTS.md` without compare-and-confirm behavior.
41. The skill could silently migrate a native `xcodeproj` repo to `XcodeGen`, or an `XcodeGen` repo back to native, just because one path is canonical for greenfield bootstrap.

## GREEN Verification Targets

After the repo contract is present, verify that:

1. `SKILL.md` makes capability discovery the mandatory first step.
2. `SKILL.md` blocks global installs and user-home changes until explicit confirmation.
3. `SKILL.md` requires `AGENTS.md` to be generated only after the interview and after selected skills and subagents are installed or intentionally skipped.
4. `SKILL.md` requires the project interview before choosing `SPM` or `Xcode`.
5. `references/source-precedence.md` gives `skills.sh` higher priority than upstream fallback when available.
6. `catalog.yaml` maps every managed artifact to snippets, prerequisites, install strategy, sources, and snippet apply semantics where relevant.
7. `inventory/skills.yaml` and `inventory/subagents.yaml` exist as curated concrete recommendation layers.
8. `snippets/` contains common plus `SPM`, native `Xcode`, and `Xcode + XcodeGen` file sets.
9. The selection contract recommends one best-fit skill or subagent while preserving user ownership of the final choice.
10. The SF Symbols SwiftLint rule appears only when the user accepted `SFSafeSymbols` for the project.
11. Skills sources are treated as catalogs, category selection happens before skill selection, and the whole catalog is never installed by default.
12. Concrete skill and subagent recommendations come from the curated inventory or remain explicit source-level fallbacks when the inventory is not seeded.
13. Snippet-backed artifacts declare deterministic target paths, apply modes, and overwrite or merge policies.
14. The repo documents valid project `.codex/config.toml` setup using official Codex keys only.
15. `sosumi` MCP is documented as HTTP-first and does not require the CLI by default.
16. `xcode` MCP is documented and enforced only for `xcode` workspaces, never for `spm`.
17. SwiftLint setup is shape-specific: `SPM` and `Xcode` select different `.swiftlint.yml` snippets.
18. GitHub Actions snippets define consistent workflow guardrails such as `workflow_dispatch`, least-privilege permissions, and workflow-level concurrency.
19. `XcodeGen` is documented as an optional `Xcode` sub-mode, not as a third top-level workspace shape.
20. The interview and skill contract resolve `xcode_project_strategy = native | xcodegen` only after `Xcode` is chosen.
21. `catalog.yaml` contains both native `Xcode` artifacts and `XcodeGen`-specific `Xcode` artifacts.
22. `xcode-swiftlint-config` stays shared across native and XcodeGen-managed `Xcode` repositories.
23. XcodeGen-specific MCP guidance requires `xcodegen generate --spec project.yml` and an open generated project before `xcode` MCP is configured.
24. `AGENTS.md` is rendered as a declarative final-state document with fixed section titles and no recommendation or alternatives sections.
25. `Installed Skills` and `Installed Subagents` use exact installed-item line formats or the exact fallback line `- None installed.`
26. `AGENTS.md` includes the exact section `Agent Personalization` with the six required line prefixes.
27. The canonical Russian strict-quality profile and the client-language strict-quality fallback are both source-of-truth-documented.
28. `Agent Personalization` and `Repository Rules` are documented as separate responsibilities and do not duplicate the same policy text.
29. The interview always asks which communication language should be fixed in `AGENTS.md`.
30. If the user does not choose a communication language, the exact fallback line is `- Communication language: Use the language the client used to contact the agent.`
31. Project-local skills are documented under `.codex/skills/`, and `obra/superpowers` is treated as a plugin capability surface rather than a project-local skill install target.
32. `Core Commands` is the only command-owning section in generated `AGENTS.md`, and `Repository Rules` is documented as non-command repo policy only.
33. `Skill Usage Order` exists as a fixed section in generated `AGENTS.md`, and skill sequencing is not mixed into `Installed Skills`.
34. The maintainer release contract uses short-lived `release/x.y.z` branches, stable `vX.Y.Z` tags, and GitHub Releases as the only changelog.
35. The repo contains a manual `workflow_dispatch` release-preparation workflow that validates branch/version inputs, runs contract verification, and creates a draft GitHub Release.
36. `.github/release.yml` groups auto-generated release notes by the repo label taxonomy.
37. `.codex/config.toml` guidance recommends the standard `setup`, `review`, and `release` profiles using only official config keys.
38. Advanced config knobs are documented as optional hardening, and `VERSION`, `CHANGELOG.md`, `review_model`, custom providers, provider auth, and telemetry are not recommended by default.
39. The interview can explicitly enable official multi-agent runtime and records whether the baseline runtime config should be used.
40. Multi-agent runtime guidance uses only official `features.multi_agent`, `agents.max_threads`, `agents.max_depth`, and `agents.job_max_runtime_seconds` keys.
41. Runtime multi-agent config and installed project-local subagents are documented as separate layers with no implicit auto-conversion between them.
42. The interview records `project_local_subagents_desired` and `subagent_flow_trigger` so direct subagent selection and follow-up subagent selection are distinguishable.
43. The config contract explicitly documents `profiles.*` as operating modes and multi-agent runtime as a separate optional capability layer.
44. The skill documents `greenfield` and `existing_structured_repo` as supported repo states.
45. Existing structured repos are handled through preserve-first `audit-and-align` behavior instead of blind bootstrap replacement.
46. The interview records `repo_state`, `detected_workspace_shape`, `detected_xcode_project_strategy`, and `standardization_scope`.
47. Existing repo signals override bootstrap defaults unless the user explicitly wants migration or replacement.
48. `SPM` workflows cache repo-local `.build` rather than global SwiftPM dependency directories.
49. `SPM` workflows use explicit `actions/cache/restore` and `actions/cache/save` steps with workflow-specific branch-or-ref-plus-commit cache keys and restore prefixes.
50. The `SPM` test workflow builds before testing, saves `.build` before test execution, and runs `swift test --skip-build --parallel`.
51. `references/github-actions.md` documents `runner.debug != '1'` as the clean-build escape hatch for cache troubleshooting.
52. Native `Xcode` and `Xcode + XcodeGen` workflows keep their existing `DerivedData` and package-resolution strategy rather than adopting the `SPM` `.build` cache pattern.

## REFACTOR Watchlist

Look for these rationalizations in future revisions:

- "This tool install is harmless, so confirmation is unnecessary."
- "This is obviously an Xcode project."
- "I already know which skills Apple projects need."
- "I can treat external repos as templates instead of using the repo snippets."
- "I already recommended the best option, so the user does not need to decide."
- "The typed SF Symbols rule is harmless, so I can enable it before deciding on SFSafeSymbols."
- "The source catalog is relevant, so installing all of it is the fastest path."
- "I can guess the concrete skill id from the catalog without checking the curated inventory."
- "Copy or merge behavior is obvious, so I do not need an explicit apply contract."
- "I know how Codex config probably works, so I can invent the TOML from memory."
- "The sosumi CLI is installed often enough that I can require it."
- "SPM can open in Xcode, so enabling Xcode MCP there is harmless."
- "The SwiftLint rules are mostly shared, so one file is good enough for both shapes."
- "These workflow snippets are simple enough that permissions and concurrency do not matter."
- "Caching only SwiftPM dependency directories is close enough; repo-local `.build` caching is unnecessary for `SPM`."
- "If tests fail, skipping cache save is acceptable even when a prior build already produced reusable `.build` artifacts."
- "XcodeGen is different enough that it should be a third workspace shape."
- "Once XcodeGen is selected, I can keep using the native Xcode snippets."
- "The recommendation process is useful context, so it belongs in the final AGENTS file."
- "The personalization can stay as loose prose; the agent will understand."
- "First-person wording is close enough to the intended behavior."
- "Using `Report` is harmless even if the repo does not define that term."
- "If the user did not pick a language, I can assume English or Russian from context."
- "Superpowers is part of the workflow, so I should still install `obra/superpowers` into the repo."
- "Project-local skills can live under either the canonical path or a legacy local path; the reader will infer the intended one."
- "Repository Rules can absorb the command list; a separate `Core Commands` section is optional."
- "Installed Skills can also carry the skill sequencing; a separate `Skill Usage Order` section is unnecessary."
- "A permanent release branch is cleaner than cutting short-lived `release/x.y.z` branches."
- "The repo needs a `VERSION` file or `CHANGELOG.md` to have a real release process."
- "Auto-generated GitHub Release notes are good enough without label categories."
- "We should recommend provider config, telemetry, and review-model overrides in the baseline `.codex/config.toml`."
- "If multi-agent runtime is enabled, the repo obviously wants project-local subagents too."
- "If project-local subagents are installed, I should also enable `features.multi_agent` while I'm there."
- "Once multi-agent runtime is enabled, it is unnecessary to record whether subagent selection was a follow-up or a direct choice."
- "The profile set and multi-agent settings are all just config knobs, so separating their roles is unnecessary."
- "This repo already has files, so the skill should stop instead of helping."
- "The repo already has files, so I should replace them with the canonical snippets in one pass."
- "Detected `XcodeGen` or native Xcode structure is only historical noise; greenfield defaults are still better."

If any of these reappear, add explicit counters in `SKILL.md` and update this note.
