# Install Superpowers First

This skill always treats `obra/superpowers` as the first prerequisite.

## Why It Comes First

`superpowers` establishes the baseline workflow expected by this repository, especially:

- `writing-skills`
- plan and execution discipline
- verification and review flow

Do not continue with workspace setup until this prerequisite is satisfied or the user explicitly declines.

## Official Codex Install Flow

Source:

- <https://github.com/obra/superpowers>
- <https://raw.githubusercontent.com/obra/superpowers/refs/heads/main/.codex/INSTALL.md>

Use this flow when the user confirms:

```bash
git clone https://github.com/obra/superpowers.git ~/.codex/superpowers
mkdir -p ~/.agents/skills
ln -s ~/.codex/superpowers/skills ~/.agents/skills/superpowers
```

## Update Flow

If already installed but outdated, suggest:

```bash
git -C ~/.codex/superpowers pull
```

## Confirmation Policy

This step changes user-level locations:

- `~/.codex/superpowers`
- `~/.agents/skills/superpowers`

Because of that, the skill must:

1. explain why the install is needed
2. show the exact command or commands
3. wait for explicit confirmation before running anything

## Verification

After installation, verify with:

```bash
ls -la ~/.agents/skills/superpowers
```

Expected result: a symlink or directory path resolving to the `superpowers` skills folder.
