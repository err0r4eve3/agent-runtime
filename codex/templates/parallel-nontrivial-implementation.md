# Parallel Non-trivial Implementation Template

Use this as the task body for Codex CLI or Codex cloud tasks when the work is more than a small local edit.

```text
Implement <task> in this repository.

For non-trivial work:
1. Check current repo instructions, project docs, and Codex native memories before planning or implementing.
2. Create or update an in-repo execution plan with milestones, acceptance criteria, validation commands, and risks.
3. Spawn parallel subagents for:
   - codebase exploration / evidence collection
   - docs / API verification
   - regression and test-risk review
4. Wait for all child results, synthesize them, then implement in scoped milestones.
5. After each milestone, run the relevant validation and fix failures before continuing.
6. Before signoff, run final tests/lint/typecheck/build and update the plan/status docs.

Do not stop at analysis unless blocked.
Do not ask unnecessary follow-up questions.
Keep diffs scoped and evidence-based.
```

## Notes

- This template is intentionally explicit because Codex only uses subagents when asked directly.
- Keep the execution plan in-repo so the task state survives model restarts and handoffs.
- Reusing current repo instructions and native memory context is cheaper than rediscovering the same failure mode.
- Use this for repository work, not for trivial one-file edits where the planning overhead is not justified.
