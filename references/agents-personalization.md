# Agent Personalization

Use this document when generating the final `AGENTS.md`.

This section is not optional. It records the final repo-local interaction contract for the agent.

## Purpose

`Agent Personalization` stores:

- communication language
- pushback behavior
- quality and security priority
- long-term maintainability priority
- temporary-fix policy
- risk disclosure requirements

It does not store:

- branch strategy
- CI policy
- source-of-truth rules
- install policy
- workflow commands

Those belong in `Repository Rules`.

Do not duplicate the same rule in both sections.

## Exact Section Contract

Use the exact section title:

- `Agent Personalization`

Use these exact line prefixes in this exact order:

- `- Communication language:`
- `- Pushback policy:`
- `- Quality priority:`
- `- Long-term priority:`
- `- Temporary fixes policy:`
- `- Risk disclosure:`

Do not use first-person voice.
Do not use the word `Report`.
Do not add rationale, alternatives, or selection history.

## Strict-Quality Policy Lines

These five lines are the v1 strict-quality baseline:

- `- Pushback policy: Challenge user decisions that introduce hacks, security weaknesses, or long-term technical debt; do not silently agree with them.`
- `- Quality priority: Favor quality, security, and maintainability over speed.`
- `- Long-term priority: Prefer scalable and maintainable solutions over short-term speed.`
- `- Temporary fixes policy: Do not accept "temporary" solutions without an explicit cleanup plan.`
- `- Risk disclosure: If a risky shortcut is chosen, state the risks explicitly in the final response.`

## Canonical Profiles

### strict-quality-russian

Use these exact six lines:

- `- Communication language: Russian.`
- `- Pushback policy: Challenge user decisions that introduce hacks, security weaknesses, or long-term technical debt; do not silently agree with them.`
- `- Quality priority: Favor quality, security, and maintainability over speed.`
- `- Long-term priority: Prefer scalable and maintainable solutions over short-term speed.`
- `- Temporary fixes policy: Do not accept "temporary" solutions without an explicit cleanup plan.`
- `- Risk disclosure: If a risky shortcut is chosen, state the risks explicitly in the final response.`

### strict-quality-client-language-default

Use these exact six lines:

- `- Communication language: Use the language the client used to contact the agent.`
- `- Pushback policy: Challenge user decisions that introduce hacks, security weaknesses, or long-term technical debt; do not silently agree with them.`
- `- Quality priority: Favor quality, security, and maintainability over speed.`
- `- Long-term priority: Prefer scalable and maintainable solutions over short-term speed.`
- `- Temporary fixes policy: Do not accept "temporary" solutions without an explicit cleanup plan.`
- `- Risk disclosure: If a risky shortcut is chosen, state the risks explicitly in the final response.`

## Interview Mapping

Use this mapping when generating the final `AGENTS.md`:

- Always ask which communication language should be fixed in `AGENTS.md`.
- If the user explicitly wants Russian, use `strict-quality-russian`.
- If the user gives no explicit language preference, use `strict-quality-client-language-default`.
- If the user explicitly confirms the strict-quality baseline in another language, keep the five strict-quality policy lines and change only the communication-language line.
- If the user explicitly asks for a different behavior policy, keep the exact section structure and exact line prefixes, but replace only the requested line values and keep them declarative.

## Final Output Rule

`Agent Personalization` must describe only the final confirmed profile.

Never include:

- candidate profiles
- comparison notes
- selection rationale
- alternatives
- user-choice language
