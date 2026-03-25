---
name: cursor-create-rule
description: Create or update Cursor rules in `.cursor/rules/*.mdc` or project `AGENTS.md`. Use when the user wants persistent Cursor guidance, coding standards, file-pattern rules, or asks about Cursor rules, `.cursor/rules/`, `.mdc`, or `AGENTS.md`.
---
# Create Cursor Rules

Use this skill when the task is about authoring or updating rules for Cursor rather than Codex.

## Workflow

1. Inspect existing `.cursor/rules/` and `AGENTS.md` files before adding a new rule.
2. Decide the scope:
   - Global within the repo: `alwaysApply: true`
   - File-specific: `globs: <pattern>` and `alwaysApply: false`
3. Put each rule in its own `.mdc` file under `.cursor/rules/`.
4. Keep rules short, specific, and actionable. Prefer one concern per file.
5. Ask only if scope or glob patterns are unclear and guessing would likely create the wrong rule.

## File Template

```markdown
---
description: Brief description of what this rule enforces
globs: **/*.ts
alwaysApply: false
---

# Rule Title

Concrete guidance, constraints, and examples.
```

For always-applied rules, omit `globs` and set `alwaysApply: true`.

## Notes

- Prefer kebab-case filenames.
- Preserve existing rule style and repo conventions.
- If the project clearly uses `AGENTS.md` instead of `.mdc` files, follow that convention.
