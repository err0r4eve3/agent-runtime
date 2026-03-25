---
name: cursor-create-skill
description: Create or update Cursor skills under `.cursor/skills/` or `~/.cursor/skills/`. Use when the user wants to author a Cursor skill, asks about Cursor `SKILL.md` format, or needs Cursor skill structure and best practices.
---
# Create Cursor Skills

Use this skill for Cursor skill authoring, not Codex skill authoring.

## Workflow

1. Choose scope:
   - Repo skill: `.cursor/skills/<skill-name>/SKILL.md`
   - User skill: `~/.cursor/skills/<skill-name>/SKILL.md`
2. Never write into `~/.cursor/skills-cursor`; that directory is reserved for Cursor built-ins.
3. Write frontmatter with `name` and `description`.
4. Keep `SKILL.md` concise. Put detailed examples or docs in extra files only when needed.
5. Use lower-case kebab-case names and descriptions that say both what the skill does and when Cursor should use it.

## Template

```markdown
---
name: my-skill
description: What the skill does and when to use it
---

# Skill Title

## Workflow

Steps the agent should follow.
```

## Authoring Rules

- Keep the main file focused; avoid long tutorials.
- Prefer concrete workflows, templates, and examples over generic advice.
- Reuse project conventions and existing file structure.
