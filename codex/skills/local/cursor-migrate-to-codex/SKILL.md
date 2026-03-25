---
name: cursor-migrate-to-codex
description: Migrate Cursor rules and commands into Codex skills. Use when the user wants to port `.cursor/rules/*.mdc`, `.cursor/commands/*.md`, or Cursor built-in skills into `~/.codex/skills/` or project `.codex/skills/`.
---
# Migrate Cursor Rules And Commands To Codex

Use this skill when the task is to convert Cursor guidance into Codex skills.

## Source Types

- Cursor rules: `.cursor/rules/*.mdc`
- Cursor commands: `.cursor/commands/*.md`
- Cursor built-ins: `~/.cursor/skills-cursor/*/SKILL.md`

## Workflow

1. Find source files and inspect their frontmatter or headings.
2. Migrate "applied intelligently" rules with a `description` and without file-specific `globs` or `alwaysApply: true` into skill directories.
3. For commands, keep the body as intact as possible but replace Cursor-only slash-command UX or tool names with Codex equivalents when needed.
4. Install the result under `~/.codex/skills/<name>/SKILL.md` or `.codex/skills/<name>/SKILL.md`.
5. Namespace imported Cursor built-ins with a `cursor-` prefix to avoid colliding with Codex system skills.
6. Skip features that only make sense in Cursor, such as `/shell` wrappers, unless the user explicitly asks for them.

## Conversion Rules

- `name`: use the filename in kebab-case.
- `description`: keep or minimally adapt the original trigger description.
- Body: preserve meaning; only change paths, tool names, or UI concepts that do not exist in Codex.
- Do not delete originals unless the user explicitly asks for a destructive migration.

## Notes

- Prefer Codex-native wording over literal copy when a Cursor tool has no direct equivalent.
- Verify the installed skill by listing the target directory after writing.
