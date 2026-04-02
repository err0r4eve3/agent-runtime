# Codex Failure Learning

This directory turns past Codex failures into reusable runtime guardrails without letting raw logs rewrite persistent instructions on their own.

## Principles

- Treat failures as evidence, not lore.
- Keep raw artifacts local and sanitized. Shared repo state should stay reviewable and low-risk.
- Only promote a learning when it recurs and has a concrete prevention step.
- Convert repeated failures into scripts, guardrails, validation commands, or template changes instead of relying on conversational memory.

## Workflow

1. Run `bash scripts/refresh_codex_learning.sh`.
2. `scripts/harvest_codex_failures.py` scans `~/.codex/sessions/**/*.jsonl`, links tool calls to their outputs, filters likely-benign non-zero exits, and emits actionable failure records.
3. `scripts/promote_codex_learnings.py` groups recurring categories and generates [distilled-rules.md](distilled-rules.md).
4. Review the suggested rules and promote only stable items into `AGENTS.md`, templates, scripts, or skills.

## Shared artifacts

- [plan.md](plan.md): implementation plan and current status for this learning loop
- [distilled-rules.md](distilled-rules.md): recurring, sanitized learnings worth reusing across tasks and machines
- `inventories/<machine>/codex-learning-summary.md`: machine-level summary generated from local sessions

## Local-only artifacts

- `codex/learning/generated/<machine>/failures.jsonl`: sanitized raw harvest for local inspection

The `generated/` tree is gitignored on purpose. The repo should keep durable learnings, not a growing pile of raw execution transcripts.

## Commands

```bash
bash scripts/refresh_codex_learning.sh
```

Manual steps:

```bash
python3 scripts/harvest_codex_failures.py \
  --sessions-root ~/.codex/sessions \
  --output-jsonl codex/learning/generated/$(hostname -s)/failures.jsonl \
  --summary-md inventories/$(hostname -s)/codex-learning-summary.md

python3 scripts/promote_codex_learnings.py \
  --input codex/learning/generated/$(hostname -s)/failures.jsonl \
  --output-md codex/learning/distilled-rules.md
```

## Promotion gate

- At least 2 actionable hits in harvested records
- A prevention step that is concrete, low-risk, and reusable
- Safe to generalize beyond one temporary environment issue or one repository-only edge case
