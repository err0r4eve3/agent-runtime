# Parallel Non-trivial Implementation Template

Use this as the task body for Codex CLI or Codex cloud tasks when the work is more than a small local edit.

```text
Implement <task> in this repository.

For non-trivial work:
1. Create or update an in-repo execution plan with milestones, acceptance criteria, validation commands, and risks.
2. Spawn parallel subagents for:
   - codebase exploration / evidence collection
   - docs / API verification
   - regression and test-risk review
3. Wait for all child results, synthesize them, then implement in scoped milestones.
4. After each milestone, run the relevant validation and fix failures before continuing.
5. Before signoff, run final tests/lint/typecheck/build and update the plan/status docs.

Do not stop at analysis unless blocked.
Do not ask unnecessary follow-up questions.
Keep diffs scoped and evidence-based.
```

## Notes

- This template is intentionally explicit because Codex only uses subagents when asked directly.
- Keep the execution plan in-repo so the task state survives model restarts and handoffs.
- Use this for repository work, not for trivial one-file edits where the planning overhead is not justified.
