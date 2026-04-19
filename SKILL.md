---
name: apple-platform-project-setup-skill
description: Use when bootstrapping or standardizing an Apple platform workspace, choosing between Swift Package Manager and Xcode setup, optionally choosing a native or XcodeGen-generated Xcode path, and establishing project-local skills, subagents, lint, CI, and AGENTS guidance.
---

# Apple Platform Project Setup

Bootstrap Apple workspaces in a strict order so the repo gets the right foundation before any project-specific customization.

**Core principle:** install the baseline workflow first, then interview and specialize, then generate `AGENTS.md` after the selected skills and subagents are already in place.

**Source of truth:** This skill must follow [`catalog.yaml`](catalog.yaml), [`inventory/skills.yaml`](inventory/skills.yaml), [`inventory/subagents.yaml`](inventory/subagents.yaml), [`references/source-precedence.md`](references/source-precedence.md), [`references/codex-config.md`](references/codex-config.md), [`references/mcp-setup.md`](references/mcp-setup.md), [`references/github-actions.md`](references/github-actions.md), [`references/swiftlint-setup.md`](references/swiftlint-setup.md), [`references/xcodegen-setup.md`](references/xcodegen-setup.md), [`references/agents-personalization.md`](references/agents-personalization.md), and the files under [`snippets/`](snippets/).

## When to Use

Use this skill when:

- starting a new Apple platform repository or local workspace
- standardizing or auditing an existing Apple platform repository
- deciding between `SPM` and `Xcode`
- if `Xcode`, deciding between native `xcodeproj` and `XcodeGen-generated`
- setting up `AGENTS.md`, `.codex/config.toml`, MCP, `gitlint`, `SwiftLint`, GitHub Actions, skills, or subagents for Apple development
- standardizing repository bootstrap for iOS, macOS, watchOS, tvOS, or visionOS work

Do not use this skill for:

- non-Apple projects
- one-off repo cleanup unrelated to bootstrap

## Mandatory Order

```dot
digraph setup_order {
    rankdir=LR;
    superpowers [label="Check superpowers"];
    confirm [label="Need install or home-dir change?", shape=diamond];
    stop [label="Propose official install\nand wait for confirmation"];
    state [label="Detect repo state"];
    interview [label="Interview user"];
    choose [label="Choose SPM or Xcode"];
    xcodestrategy [label="If Xcode, choose\nnative or XcodeGen"];
    tools [label="Check tool prerequisites"];
    install [label="Install skills / copy subagents\nwith confirmation rules"];
    config [label="Configure .codex/config.toml\nand optional MCP"];
    apply [label="Apply snippets"];
    agents [label="Create AGENTS.md\nfrom bootstrap snippet"];
    summary [label="Summarize configured vs pending"];

    superpowers -> confirm;
    confirm -> stop [label="yes"];
    confirm -> state [label="no"];
    stop -> state [label="after confirmation"];
    state -> interview;
    interview -> choose;
    choose -> xcodestrategy;
    xcodestrategy -> tools;
    tools -> install;
    install -> config;
    config -> apply;
    apply -> agents;
    agents -> summary;
}
```

Never reorder these steps.

## Quick Reference

| Topic | Rule |
|---|---|
| Baseline prerequisite | `obra/superpowers` always comes first |
| Repo modes | detect `greenfield` vs `existing_structured_repo` before the interview |
| AGENTS timing | generate after selected skills and subagents are installed |
| AGENTS syntax | skills as `$skill-name`, subagents as `@agent-name` |
| AGENTS mode | declarative final-state only; no recommendations or alternatives |
| AGENTS personalization | fixed `Agent Personalization` section with exact prefixes and strict-quality fallback |
| Selection model | recommend one best-fit option, user keeps the final choice |
| Concrete selection source | `inventory/skills.yaml` and `inventory/subagents.yaml` |
| Skill install preference | `skills.sh` first, upstream instructions second |
| Subagent install location | `.codex/agents/` by default |
| Project config | prefer project `.codex/config.toml` for skill registration, optional wrappers, and the standard `setup` / `review` / `release` profile set |
| Multi-agent runtime | optional `.codex/config.toml` layer using official `features.multi_agent` and `agents.*` keys |
| Sosumi integration | prefer HTTP MCP; CLI is optional |
| Xcode MCP policy | only for `xcode` workspaces, never for `spm` |
| Xcode strategy | after `Xcode` is chosen, default to native `xcodeproj` unless `XcodeGen` is explicitly selected or clearly justified |
| XcodeGen policy | `XcodeGen` is an optional `Xcode` sub-mode, not a third workspace shape |
| SwiftLint policy | choose the `SPM` or `Xcode` SwiftLint snippet after the workspace shape is known |
| GitHub Actions policy | every workflow keeps `workflow_dispatch`, least-privilege permissions, and concurrency |
| Global tool install policy | propose only, never auto-install |
| Project choice | decide `SPM` vs `Xcode` after interview, not before |
| Existing repo policy | preserve first, standardize second |
| Snippet application | obey `target_path`, `apply_mode`, `conflict_policy`, and `merge_strategy` from `catalog.yaml` |

## Workflow

### 1. Check baseline prerequisites

- Confirm whether `superpowers` is already installed.
- If not installed, use [`references/install-superpowers.md`](references/install-superpowers.md).
- If the step requires cloning into `~/.codex`, creating `~/.agents/skills` for the upstream `superpowers` symlink, changing dotfiles, or installing a global tool, stop and ask for confirmation.

**No exceptions.**

### 2. Detect repository state

- Explore the repository before choosing setup mode.
- Classify the repository as:
  - `greenfield` when the folder is empty or lacks meaningful project structure
  - `existing_structured_repo` when structural signals already exist
- Treat these as structural signals:
  - `Package.swift`
  - `*.xcodeproj`
  - `*.xcworkspace`
  - `project.yml`
  - `.gitignore`
  - `.swiftlint.yml`
  - `.gitlint`
  - `.github/workflows/`
  - `.codex/config.toml`
  - `AGENTS.md`
- Record `repo_state = greenfield | existing_structured_repo`.
- If `repo_state = existing_structured_repo`, switch to `audit-and-align` mode:
  - preserve existing structure first
  - confirm detected choices through the interview
  - propose targeted standardization instead of blind bootstrap replacement

### 3. Run the project interview

- Ask questions from [`references/project-interview.md`](references/project-interview.md).
- Use [`references/agents-personalization.md`](references/agents-personalization.md) to collect and render the final `Agent Personalization` section.
- Determine:
  - repo state
  - detected workspace shape
  - if `Xcode`, detected Xcode project strategy
  - project role
  - agent personalization profile
  - target platforms
  - delivery shape
  - if `Xcode`, the Xcode project strategy
  - preferred UI stack
  - priority technologies
  - typed SF Symbols policy
  - testing and CI expectations
  - project `.codex/config.toml` expectations
  - whether official multi-agent runtime should be enabled in project `.codex/config.toml`
  - whether multi-agent runtime should use the repository baseline config
  - whether project-local subagents are desired directly or as a follow-up to multi-agent runtime activation
  - standardization scope for existing repositories
  - optional MCP integrations
  - policy constraints

For communication language:

- always ask which language should be fixed in `AGENTS.md`
- if the user does not choose a preferred communication language, set `- Communication language: Use the language the client used to contact the agent.`

Do not choose skills, subagents, or repo files before the interview is complete.

### 4. Choose workspace type

- If `repo_state = existing_structured_repo`, treat detected repo structure as the strongest default signal.
- Use `SPM` when the project is package-first, library-first, CLI-first, or intentionally lightweight.
- Use `Xcode` when the project is app-first, uses app lifecycle targets, or depends on Xcode-managed assets and schemes.
- If the user already made a valid choice, honor it and continue.
- If the repo already clearly uses `SPM`, do not re-choose `Xcode` without explicit user intent.
- If the repo already clearly uses native `xcodeproj`, do not suggest `XcodeGen` as the implicit default.
- If the repo already clearly uses `project.yml` for `XcodeGen`, keep `XcodeGen` as the detected strategy unless the user explicitly wants migration.

If the workspace choice is `Xcode`:

- Keep native checked-in `xcodeproj` as the default.
- Offer `XcodeGen` only as an optional Xcode strategy for generated-`xcodeproj` workflows.
- Use `XcodeGen` when the repository wants declarative project specs, generated projects, or relief from project-file merge conflicts.
- Do not treat `XcodeGen` as a third workspace shape.

Then use the matching snippet set:

- `SPM`: [`snippets/spm/.gitignore`](snippets/spm/.gitignore), [`snippets/spm/.swiftlint.yml`](snippets/spm/.swiftlint.yml), [`snippets/spm/workflows/build.yml`](snippets/spm/workflows/build.yml), [`snippets/spm/workflows/test.yml`](snippets/spm/workflows/test.yml)
- `Xcode + native`: [`snippets/xcode/.gitignore`](snippets/xcode/.gitignore), [`snippets/xcode/.swiftlint.yml`](snippets/xcode/.swiftlint.yml), [`snippets/xcode/workflows/build.yml`](snippets/xcode/workflows/build.yml), [`snippets/xcode/workflows/test.yml`](snippets/xcode/workflows/test.yml)
- `Xcode + XcodeGen`: [`snippets/xcode-xcodegen/.gitignore`](snippets/xcode-xcodegen/.gitignore), [`snippets/xcode-xcodegen/project.yml`](snippets/xcode-xcodegen/project.yml), [`snippets/xcode/.swiftlint.yml`](snippets/xcode/.swiftlint.yml), [`snippets/xcode-xcodegen/workflows/build.yml`](snippets/xcode-xcodegen/workflows/build.yml), [`snippets/xcode-xcodegen/workflows/test.yml`](snippets/xcode-xcodegen/workflows/test.yml)

### 5. Check tool prerequisites

Check for:

- `npx`
- `gitlint`
- `swiftlint`
- `xcodegen` when the selected Xcode strategy is `XcodeGen`
- `gh` when GitHub automation is requested
- `xcrun` when `xcode` MCP is selected for an `xcode` workspace
- `sosumi` only when the user explicitly wants the CLI
- `npx` with `mcp-remote` only when the user wants the `sosumi` stdio proxy fallback

Use [`references/tool-install-policy.md`](references/tool-install-policy.md).

If a required tool is missing:

- explain why it is needed
- propose one concrete global install command
- wait for explicit confirmation before running it

### 6. Install skills and subagents

- Follow [`references/skills-catalog.md`](references/skills-catalog.md) and [`references/subagents-catalog.md`](references/subagents-catalog.md).
- Resolve concrete choices from [`inventory/skills.yaml`](inventory/skills.yaml) and [`inventory/subagents.yaml`](inventory/subagents.yaml).
- Prefer `skills.sh` install commands whenever available.
- Fall back to upstream instructions only when `skills.sh` is not available or not supported for the selected source.
- Treat every external skills source as a catalog that may contain multiple skills, not as a single install target.
- First map the project needs to one or more capability categories such as UI, architecture, package design, testing, tooling, CI, or repository automation.
- Then map each selected category to a source catalog and resolve one concrete inventory-backed choice from that category.
- Install community skills project-locally by default under `.codex/skills/` when the installer supports it.
- If the installer only supports user-level install, explain the limitation and ask before proceeding.
- Do not install an entire catalog because its source link is relevant. Only inspect and recommend skills from the categories that match the project.
- If a category has no verified concrete entry in the inventory, do not invent one. Keep the source as a fallback recommendation path and tell the user the inventory is not seeded for that case yet.
- Copy only the chosen subagent files into `.codex/agents/`; never dump an entire external collection into the repo.
- If a source exposes multiple relevant skills or subagents, narrow them to one recommended best-fit option per capability gap.
- Explain why that recommended `$skill-name` or `@agent-name` is the strongest fit for the current repository state.
- List other relevant candidates only as alternatives with explicit `choose instead if ...` rules.
- Final selection still belongs to the user. The skill recommends; the user confirms or overrides.
- Once the user confirms the selection, treat that installed set as final repo state and carry only that final state into `AGENTS.md`.

### 7. Configure project `.codex/config.toml` and optional MCP

- Follow [`references/codex-config.md`](references/codex-config.md) and [`references/mcp-setup.md`](references/mcp-setup.md).
- If the selected Xcode strategy is `XcodeGen`, also follow [`references/xcodegen-setup.md`](references/xcodegen-setup.md).
- Prefer a project-scoped `.codex/config.toml` when the repo is meant to carry its own Codex setup.
- Register the skill with `[[skills.config]]` using the installed local path.
- Use `profile = "setup"` as the default entrypoint when the repo carries the standard project-local Codex profile set.
- Prefer the standard profile names `setup`, `review`, and `release` for repos that want project-local Codex operating modes.
- In that standard profile set:
  - `setup` should use pragmatic personality, `on-request` approvals, `workspace-write`, cached web search, and medium reasoning effort
  - `review` should keep the same approval and sandbox policy but raise reasoning and plan-mode reasoning effort to high
  - `release` should keep the same approval and sandbox policy, use live web search, and keep reasoning and plan-mode reasoning effort high
- Use `developer_instructions` only as a thin wrapper when the repo wants a short always-on reminder.
- Use `model_instructions_file` only as an explicit alternative when the repo wants a dedicated instruction file instead of relying on `AGENTS.md`.
- If the interview enables official multi-agent runtime, add the exact baseline:
  - `[features] multi_agent = true`
  - `[agents] max_threads = 3`
  - `[agents] max_depth = 2`
  - `[agents] job_max_runtime_seconds = 900`
- Treat multi-agent runtime as a config capability layer, not as a replacement for project-local subagents.
- Treat the standard `setup`, `review`, and `release` profiles as operating modes and keep them separate from `features.multi_agent` and `agents.*`.
- If multi-agent runtime is enabled, ask whether to continue into the existing project-local subagent selection flow.
- Record `subagent_flow_trigger = after_multi_agent_runtime` only when that second interview decision is yes.
- If multi-agent runtime stays disabled and the user still wants project-local subagents, record `project_local_subagents_desired = true` and `subagent_flow_trigger = direct`.
- Do not auto-install project-local subagents just because multi-agent runtime was enabled.
- Do not auto-enable multi-agent runtime just because the user wants project-local subagents.
- Treat `review_model`, custom model providers, provider auth config, telemetry, analytics, `VERSION`, and `CHANGELOG.md` as non-default choices. Do not recommend them in the baseline project config.
- Prefer `sosumi` over HTTP MCP when Apple docs lookup is desired and the client supports remote MCP servers.
- Treat the `sosumi` CLI as optional. Do not require a global CLI install when HTTP MCP already solves the need.
- Offer `xcode` MCP only when the workspace shape is `xcode`.
- Before configuring `xcode` MCP:
  - require the user to enable external agents in `Xcode > Settings > Intelligence`
  - require the project to be open in Xcode
  - if the repo uses `XcodeGen`, require `xcodegen generate --spec project.yml` first and an open generated `.xcodeproj`
  - use the Apple-supported `xcrun mcpbridge` integration path
- Never configure `xcode` MCP for `spm` workspaces in this skill, even if the package could be opened in Xcode manually.

### 8. Apply common artifacts

Apply or refine:

- [`snippets/common/.gitlint`](snippets/common/.gitlint)
- the selected workspace SwiftLint snippet from [`references/swiftlint-setup.md`](references/swiftlint-setup.md) when Swift source is in scope
- [`snippets/common/.swiftlint.sfsafesymbols.yml`](snippets/common/.swiftlint.sfsafesymbols.yml) only when the user chose `SFSafeSymbols`
- [`snippets/common/workflows/gitlint.yml`](snippets/common/workflows/gitlint.yml)
- if `Xcode + XcodeGen`, the selected XcodeGen spec from [`references/xcodegen-setup.md`](references/xcodegen-setup.md)
- the selected `.gitignore`
- the selected build and test workflows

Use [`references/github-actions.md`](references/github-actions.md) when refining the workflow snippets.

Always apply snippet-backed artifacts using the contract in [`catalog.yaml`](catalog.yaml):

- `target_path` decides where the artifact lands in the target repo.
- `apply_mode` decides whether the artifact is copied, copied as multiple named files, generated from a template, or merged as a fragment.
- `conflict_policy` decides whether existing non-empty files require confirmation before replace or merge.
- `merge_strategy` is used only when the artifact is merged into an existing file.

Do not improvise target paths, overwrite behavior, or merge behavior outside that contract.

For `existing_structured_repo`, add this policy layer before applying any artifact:

- preserve first, standardize second
- detect whether the target file already exists and treat it as current repo state, not as missing bootstrap output
- compare the existing file against the selected canonical snippet or config intent
- propose only the aligned change set the user actually wants
- do not replace `.gitignore`, `.swiftlint.yml`, `.gitlint`, workflows, `.codex/config.toml`, or `AGENTS.md` without explicit confirmation
- do not migrate native `xcodeproj` to `XcodeGen` or `XcodeGen` to native `xcodeproj` without explicit confirmation
- do not auto-enable MCP, multi-agent runtime, skills, or subagents just because the repo already exists

Before adding the `No raw SF Symbol strings` SwiftLint rule:

- ask whether the project should add `SFSafeSymbols` via Swift Package Manager
- use [`references/sfsafesymbols.md`](references/sfsafesymbols.md) for the install path that matches the chosen workspace shape
- select the workspace-specific `.swiftlint.yml` before merging any optional fragments
- if the user says yes:
  - add the `SFSafeSymbols` package dependency
  - merge the `snippets/common/.swiftlint.sfsafesymbols.yml` fragment into the final `.swiftlint.yml`
- if the user says no:
  - do not add the package dependency
  - do not add the `No raw SF Symbol strings` rule

### 9. Create `AGENTS.md` last

- Start from [`snippets/common/AGENTS.bootstrap.md`](snippets/common/AGENTS.bootstrap.md).
- Use **REQUIRED SUB-SKILL:** `superpowers:writing-skills` when generating or reshaping the repo-specific `AGENTS.md`.
- Do this only after:
  - the project interview is complete
  - the workspace shape is chosen
  - the selected skills and subagents are installed or intentionally skipped
  - the common repo artifacts are already applied
- Treat the bootstrap file as the starting structure for the final repo-local `AGENTS.md`, not as an early placeholder.
- Any generated `AGENTS.md` must reference skills as `$skill-name` and subagents as `@agent-name`.
- `AGENTS.md` is a declarative document about the final chosen repo state, not a recommendation document.

When refining `AGENTS.md`, use this rendering contract:

- Use these exact section titles in this exact order:
  - `Repository Purpose`
  - `Agent Personalization`
  - `Workspace`
  - `Project Structure Source Of Truth`
  - `Core Commands`
  - `Installed Skills`
  - `Installed Subagents`
  - `Repository Rules`
- Under `Repository Purpose`, use the exact line prefix `- Purpose:`.
- Under `Agent Personalization`, use these exact line prefixes in this exact order:
  - `- Communication language:`
  - `- Pushback policy:`
  - `- Quality priority:`
  - `- Long-term priority:`
  - `- Temporary fixes policy:`
  - `- Risk disclosure:`
- If no preferred communication language was explicitly chosen, the exact fallback line must be `- Communication language: Use the language the client used to contact the agent.`
- Under `Workspace`, use the exact line prefixes:
  - `- Shape:`
  - `- Target platforms:`
  - `- Xcode project strategy:` only when the shape is `Xcode`
- Under `Project Structure Source Of Truth`, use the exact line prefixes:
  - `- Source of truth:`
  - `- Xcode generation:`
- Under `Core Commands`, use the exact line prefixes:
  - `- Setup:`
  - `- Build:`
  - `- Test:`
  - `- Lint:`
  - `- Project generation:`
- Under `Installed Skills`, each installed skill line must use the exact format `- $skill-name: Use for <exact repository task>.`
- If no project-local skills were installed, `Installed Skills` must contain the exact line `- None installed.`
- Under `Installed Subagents`, each installed subagent line must use the exact format `- @agent-name: Use for <exact repository task>.`
- If no project-local subagents were installed, `Installed Subagents` must contain the exact line `- None installed.`
- Under `Repository Rules`, every rule line must use the exact prefix `- Rule:`.
- `Agent Personalization` stores communication and behavior policy. `Core Commands` stores workflow commands. `Repository Rules` stores repo-specific constraints and operating rules that are not commands.
- Do not duplicate the same rule in both `Agent Personalization` and `Repository Rules`.
- Do not repeat a command under `Repository Rules`.
- Do not include `Recommended Skills`, `Recommended Subagents`, `Optional Alternatives`, `Decision Note`, `Why recommended now`, or any equivalent recommendation section.
- Do not mention candidates that were considered but not installed.
- Do not include user-choice language in `AGENTS.md`; by this stage the choice has already been made.
- Do not use first-person wording inside `Agent Personalization`.
- Do not use the word `Report` anywhere in `AGENTS.md`.
- For `Xcode + XcodeGen`, `Project Structure Source Of Truth` must explicitly say that `project.yml` is the project-structure source of truth and that `xcodegen generate --spec project.yml` may be required before opening the project in Xcode.

### 10. Summarize clearly

End by separating:

- what was installed
- what was configured
- what still needs user confirmation
- what still needs project-specific decisions

## Common Mistakes

### Installing anything before `superpowers`

Wrong. This skill must establish the baseline workflow first or stop for confirmation.

### Choosing `SPM` or `Xcode` before interviewing the user

Wrong. The project role and technology priorities determine the correct shape.

### Treating an existing structured repo like an empty folder

Wrong. Existing structure is a discovery signal. Confirm it first, then align only what the user wants standardized.

### Treating `XcodeGen` as a third workspace shape

Wrong. In this repository, `XcodeGen` is an optional strategy inside the `Xcode` path.

### Installing missing tools automatically

Wrong. Global installs must always be user-confirmed.

### Inventing Codex config keys or paths

Wrong. Use the official `config.toml` reference and the repo config guidance documents.

### Treating external catalogs as templates

Wrong. External skills and subagents are recommendation sources. Repo truth still comes from `catalog.yaml`, `references/`, and `snippets/`.

### Installing every skill or subagent from a source

Wrong. Select the smallest relevant set after the interview.

### Treating a skills catalog link as one thing to install wholesale

Wrong. A relevant source link may contain many skills. Choose a useful category first, then recommend one concrete skill from that category.

### Guessing a concrete skill or subagent without the inventory

Wrong. Resolve verified concrete choices from `inventory/skills.yaml` and `inventory/subagents.yaml` or keep the source as an explicit fallback.

### Generating `AGENTS.md` before setup decisions are settled

Wrong. `AGENTS.md` should describe the setup that was actually chosen and installed, not a temporary guess.

### Enabling the SF Symbols lint rule without the typed symbols dependency

Wrong. The `No raw SF Symbol strings` rule only makes sense after the user accepts `SFSafeSymbols` for the project.

### Applying one shared SwiftLint snippet to both `SPM` and `Xcode`

Wrong. SwiftLint selection is shape-specific in this repository. Choose the workspace first, then apply the matching `.swiftlint.yml`.

### Applying native Xcode artifacts after choosing `XcodeGen`

Wrong. Once `XcodeGen` is selected inside `Xcode`, apply the XcodeGen spec and XcodeGen workflows instead of the native Xcode project snippets.

### Listing multiple relevant skills or subagents as equal defaults

Wrong. Recommend one best-fit option for the current task and move the rest into conditional alternatives.

### Improvising snippet copy or merge behavior

Wrong. `catalog.yaml` defines the target path, apply mode, conflict policy, and merge strategy for snippet-backed artifacts.

### Copying recommendations or alternatives into `AGENTS.md`

Wrong. `AGENTS.md` must list only the final installed repo state, not the earlier comparison process.

### Mixing personalization rules into `Repository Rules`

Wrong. `Agent Personalization` and `Repository Rules` have different jobs. Keep communication and pushback policy separate from repo operating rules.

### Putting commands inside `Repository Rules`

Wrong. All workflow commands belong in `Core Commands`. Keep `Repository Rules` for non-command repo policy only.

### Using first-person wording or `Report` in `AGENTS.md`

Wrong. The generated file must stay declarative and repo-local. Use exact prefixes and final-response wording instead.

### Configuring `xcode` MCP for an `spm` workspace

Wrong. In this skill, `xcode` MCP is a policy-approved path only for `xcode` workspaces.

### Configuring `xcode` MCP for an XcodeGen repo before `xcodegen generate`

Wrong. The generated project or workspace must exist and be open in Xcode first.

### Treating the `sosumi` CLI as required for `sosumi` MCP

Wrong. Prefer HTTP MCP first. The CLI is optional and should be suggested only when that specific path is wanted.

## Red Flags

- "I can skip `superpowers` because the user only asked for SwiftLint."
- "I already know this is an Xcode project."
- "The repo already has files, so this skill is no longer useful."
- "The repo already has files, so I can replace them with the canonical snippets in one pass."
- "XcodeGen is different enough that I should treat it as a third workspace shape."
- "I'll install `gitlint` first and ask later."
- "I'll install all suggested subagents now and clean up later."
- "This `skills.sh` link is relevant, so I should install the whole catalog."
- "I can infer the right skills without asking about the project."
- "I'll list three relevant skills and let the client decide without a recommendation."
- "I picked the best option, so the user does not need to decide anymore."
- "I can keep the recommendation language in `AGENTS.md`; the reader will infer what is actually installed."
- "I can put personalization anywhere in the file; the intent is obvious."
- "Using first-person voice will make the file feel more personal."
- "I can keep the word `Report`; people will understand what it means."
- "I can enable the SF Symbols string rule now and decide about typed symbols later."

**All of these mean: stop and return to the mandatory order.**

## Rationalization Counter Table

| Excuse | Reality |
|---|---|
| "This repo only needs one config file, so I can skip the bootstrap." | The bootstrap still matters because `AGENTS.md` must capture the final chosen setup, not a guess. |
| "I know which skills Apple projects usually need." | This skill must personalize recommendations after the interview, not before. |
| "The install is harmless, so I can do it without asking." | Any global install or user-home change requires explicit confirmation. |
| "The upstream repo is enough; I do not need local snippets." | This repo stores the canonical snippets and policies the skill must apply. |
| "The source link looks relevant, so I can install everything it exposes." | External skill links are catalogs. Choose a category first, then one concrete skill. |
| "All three skills are relevant, so I should list all three as peers." | Recommend one best-fit option and keep the others as conditional alternatives. |
| "I already recommended the best skill, so I can decide for the user." | The skill recommends one; the final decision stays with the user. |
| "The recommendation process is useful context, so it should stay in `AGENTS.md`." | `AGENTS.md` records only the final installed repo state. Keep selection reasoning out of it. |
| "Repository Rules can absorb the personalization text." | Personalization must live in the fixed `Agent Personalization` section, not as free-form rules. |
| "Repository Rules can absorb the command list." | Commands must live in `Core Commands`. Keep `Repository Rules` for non-command repo policy only. |
| "First-person voice is harmless in AGENTS." | The contract is declarative. Keep the file repo-local and exact. |
| "The word `Report` is close enough." | Use the exact risk-disclosure line and refer to the final response, not an undefined report artifact. |
| "Typed SF Symbols are a pure lint concern, so I can enable the rule without asking." | Ask about `SFSafeSymbols` first. Add the rule only if the dependency is accepted. |

## Example

User request:

> Set up a new Apple workspace for a UIKit-heavy iOS app with strict repo conventions.

Correct response shape:

1. Check whether `superpowers` is present.
2. If missing, propose the official install and wait.
3. Ask about platform targets, repo role, UI stack, testing, and CI expectations.
4. Choose `Xcode`.
5. Keep native `xcodeproj` as the default unless the interview clearly points to `XcodeGen`.
6. Check `npx`, `gitlint`, `swiftlint`, `xcodegen`, and optionally `gh`, `xcrun`, or `sosumi` based on the chosen integrations.
7. Ask whether typed SF Symbols should use `SFSafeSymbols`.
8. Recommend one best-fit `$skill-name` and one best-fit `@agent-name` where needed, each with a short usage rule and rationale.
9. Ask the user to confirm the final selection when multiple candidates are relevant.
10. Install or copy only the confirmed skills and subagents.
11. Configure project `.codex/config.toml` and any approved MCP servers.
12. If the user accepted `SFSafeSymbols`, add that package dependency and merge the SF Symbols SwiftLint rule.
13. If the workspace is `Xcode` and the user wants Xcode tools, configure `xcode` MCP through `xcrun mcpbridge`. If the repo uses `XcodeGen`, require `xcodegen generate --spec project.yml` first.
14. Apply common snippets plus either the native `Xcode` snippets or the `XcodeGen` Xcode snippets, including the shared `Xcode` SwiftLint snippet and the matching workflow guardrails.
15. Generate the repo-specific `AGENTS.md` from the bootstrap snippet.
