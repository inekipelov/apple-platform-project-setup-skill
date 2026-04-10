# AGENTS.md

This repository is an Apple platform workspace.

Use this bootstrap template to generate the repo-specific `AGENTS.md` after the project interview and after the selected skills and subagents are already in place.

## Bootstrap Rules

- Treat this file as the repo-local guidance source until richer project documentation exists.
- Use `$writing-skills` when drafting or restructuring future versions of this file.
- Do not install global tools or modify user-home directories without explicit confirmation.
- Prefer project-local skills and project-local subagents unless the user explicitly wants global setup.

## Reference Syntax

- Reference skills as `$skill-name`.
- Reference subagents as `@agent-name`.
- Every referenced `$skill-name` or `@agent-name` must include a short rule that says when to apply it.
- If several candidates are relevant for the same need, recommend one best-fit option, explain why it is recommended now, and place the others under conditional alternatives.
- The final choice still belongs to the user.

## Current Unknowns To Resolve

- final project purpose
- target Apple platforms
- `SPM` vs `Xcode`
- UI stack and priority technologies
- testing strategy
- CI expectations
- commit and review policy

## Default Workflow

- Explore the repository before making changes.
- Resolve the unknowns above through direct user dialogue before generating this file.
- Keep setup decisions reversible until the project interview is complete and the selected skills and subagents are confirmed.
- Run relevant verification before claiming setup is complete.

## Local Skill and Subagent Locations

- Project-local skills: `.agents/skills/`
- Project-local subagents: `.codex/agents/`

## Recommended AGENTS.md Composition

### Recommended Skills

- `$skill-name`: when to use it for this repository
- Why recommended now: why it is the strongest starting point for the current repo state

### Recommended Subagents

- `@agent-name`: when to use it for this repository
- Why recommended now: why it is the strongest starting point for the current repo state

### Optional Alternatives

- `$other-skill-name`: choose instead if the recommended skill is not the best fit
- `@other-agent-name`: choose instead if the recommended subagent is not the best fit

### Decision Note

- The items under `Recommended Skills` and `Recommended Subagents` are recommendations, not forced selections.
- The user confirms the final skill and subagent choice.

## Follow-Up

After the interview and after the selected skills and subagents are installed or intentionally skipped, turn this bootstrap template into a project-specific `AGENTS.md` that captures:

- repo purpose
- workspace shape
- core commands
- required skills
- required subagents
- why each recommended `$skill-name` and `@agent-name` applies
- why each recommendation is the best current starting point
- alternatives the user may choose instead
- a short note that the final choice belongs to the user
- non-negotiable repo rules
