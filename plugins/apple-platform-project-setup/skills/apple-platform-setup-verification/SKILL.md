---
name: apple-platform-setup-verification
description: Use when the Apple setup flow needs to verify the final setup contract, validate plugin and skill metadata, and summarize configured versus pending items at the end of the run.
---

# Apple Platform Setup Verification

Run this skill after the full setup flow is complete.

## When to Use

Use this skill when:

- the configured state needs a final pass before handoff
- contract validation should confirm the repo layout and metadata
- the final response needs a clear split between configured, pending, and still-decision-bound items

## Verification Checklist

- validate the final repo state against [`catalog.yaml`](../../../../catalog.yaml)
- validate skill metadata and trigger descriptions
- validate `agents/openai.yaml` metadata for each plugin skill
- validate repo-local marketplace metadata when this plugin repo is edited
- confirm that `AGENTS.md` was generated only after final capability and artifact decisions
- confirm that README, SwiftLint, workflow, and config changes match the chosen workspace path

## Repository Contract Check

For this repository, run:

```bash
ruby scripts/verify-repo-contract.rb
```

Treat failures as blocking until the repo contract passes.

## Final Summary Shape

End by separating:

- what was installed
- what was configured
- what still needs user confirmation
- what still needs project-specific decisions

## References

- [`references/skill-verification.md`](../../../../references/skill-verification.md)
- [`catalog.yaml`](../../../../catalog.yaml)
- [`scripts/verify-repo-contract.rb`](../../../../scripts/verify-repo-contract.rb)
