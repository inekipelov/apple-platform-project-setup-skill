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

1. An agent could skip `superpowers` and start workspace setup immediately.
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
16. An agent could treat `Tuist` as a third workspace shape instead of an `Xcode` sub-mode.
17. An agent could suggest `Tuist` while the repo is on the `SPM` path.
18. An agent could choose `Tuist` and still apply native `Xcode` artifacts.
19. An agent could configure `xcode` MCP for a Tuist repo without requiring a generated project to be open in Xcode.
20. An agent could copy recommendations, alternatives, or selection rationale into the final `AGENTS.md` instead of recording only the final installed repo state.
21. An agent could omit `Agent Personalization`, use the wrong line prefixes, or fall back to free-form prose.
22. An agent could use first-person wording or the word `Report` inside the generated `AGENTS.md`.
23. An agent could duplicate the same behavioral rule in both `Agent Personalization` and `Repository Rules`.
24. An agent could skip asking which communication language should be fixed and silently invent a language policy.

## GREEN Verification Targets

After the repo contract is present, verify that:

1. `SKILL.md` makes `superpowers` the mandatory first step.
2. `SKILL.md` blocks global installs and user-home changes until explicit confirmation.
3. `SKILL.md` requires `AGENTS.md` to be generated only after the interview and after selected skills and subagents are installed or intentionally skipped.
4. `SKILL.md` requires the project interview before choosing `SPM` or `Xcode`.
5. `references/source-precedence.md` gives `skills.sh` higher priority than upstream fallback when available.
6. `catalog.yaml` maps every managed artifact to snippets, prerequisites, install strategy, sources, and snippet apply semantics where relevant.
7. `inventory/skills.yaml` and `inventory/subagents.yaml` exist as curated concrete recommendation layers.
8. `snippets/` contains common plus `SPM`, native `Xcode`, and `Xcode + Tuist` file sets.
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
19. `Tuist` is documented as an optional `Xcode` sub-mode, not as a third top-level workspace shape.
20. The interview and skill contract resolve `xcode_project_strategy = native | tuist` only after `Xcode` is chosen.
21. `catalog.yaml` contains both native `Xcode` artifacts and `Tuist`-specific `Xcode` artifacts.
22. `xcode-swiftlint-config` stays shared across native and Tuist-managed `Xcode` repositories.
23. Tuist-specific MCP guidance requires `tuist generate` and an open generated project or workspace before `xcode` MCP is configured.
24. `AGENTS.md` is rendered as a declarative final-state document with fixed section titles and no recommendation or alternatives sections.
25. `Installed Skills` and `Installed Subagents` use exact installed-item line formats or the exact fallback line `- None installed.`
26. `AGENTS.md` includes the exact section `Agent Personalization` with the six required line prefixes.
27. The canonical Russian strict-quality profile and the client-language strict-quality fallback are both source-of-truth-documented.
28. `Agent Personalization` and `Repository Rules` are documented as separate responsibilities and do not duplicate the same policy text.
29. The interview always asks which communication language should be fixed in `AGENTS.md`.
30. If the user does not choose a communication language, the exact fallback line is `- Communication language: Use the language the client used to contact the agent.`

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
- "Tuist is different enough that it should be a third workspace shape."
- "Once Tuist is selected, I can keep using the native Xcode snippets."
- "The recommendation process is useful context, so it belongs in the final AGENTS file."
- "The personalization can stay as loose prose; the agent will understand."
- "First-person wording is close enough to the intended behavior."
- "Using `Report` is harmless even if the repo does not define that term."
- "If the user did not pick a language, I can assume English or Russian from context."

If any of these reappear, add explicit counters in `SKILL.md` and update this note.
