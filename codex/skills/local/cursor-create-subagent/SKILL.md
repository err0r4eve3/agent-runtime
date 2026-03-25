---
name: cursor-create-subagent
description: Create Cursor subagents in `.cursor/agents/*.md` or `~/.cursor/agents/*.md`. Use when the user wants specialized Cursor agents such as reviewers, debuggers, or domain-specific assistants with custom prompts.
---
# Create Cursor Subagents

Use this skill when the user wants reusable Cursor subagents stored on disk.

## Workflow

1. Choose scope:
   - Repo agent: `.cursor/agents/<name>.md`
   - User agent: `~/.cursor/agents/<name>.md`
2. Inspect existing agents before adding a new one.
3. Write YAML frontmatter with `name` and `description`; the markdown body is the agent prompt.
4. Make the description explicit about when Cursor should delegate to the agent.
5. Keep the prompt focused on one responsibility.

## Template

```markdown
---
name: code-reviewer
description: Reviews changed code for correctness, security, and maintainability. Use right after code changes or when the user asks for review.
---

You are a specialized code reviewer.

When invoked:
1. Inspect the relevant diff or files.
2. Prioritize correctness, regressions, and security.
3. Return concise, actionable findings.
```

## Notes

- Prefer kebab-case names.
- Avoid broad agents that overlap heavily.
- Preserve existing project conventions if `.cursor/agents/` already exists.
