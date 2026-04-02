# Codex Failure Learning Plan

## Goal

Add a conservative failure-learning loop that mines local Codex session logs, produces sanitized summaries, and suggests reusable guardrails without self-mutating prompts.

## Status

- Milestone 1: Parse local session logs and classify actionable failures. Status: completed.
  Acceptance criteria: read `.codex/sessions/**/*.jsonl`, map tool calls to outputs, capture timestamps, commands, exit codes, and categories, and filter likely-benign non-zero exits.
  Validation: `python3 scripts/harvest_codex_failures.py --sessions-root ~/.codex/sessions --output-jsonl codex/learning/generated/<machine>/failures.jsonl --summary-md inventories/<machine>/codex-learning-summary.md`
- Milestone 2: Distill recurring failures into shared guardrail candidates. Status: completed.
  Acceptance criteria: aggregate harvested failures into sanitized category-level suggestions and write them to `codex/learning/distilled-rules.md` without mutating `AGENTS.md`.
  Validation: `python3 scripts/promote_codex_learnings.py --input codex/learning/generated/<machine>/failures.jsonl --output-md codex/learning/distilled-rules.md`
- Milestone 3: Make the workflow repeatable across machines. Status: completed.
  Acceptance criteria: provide a single wrapper command, document the artifacts, and wire the approach into persistent runtime guidance.
  Validation: `bash scripts/refresh_codex_learning.sh`
- Milestone 4: Feed durable learnings back into task execution. Status: completed.
  Acceptance criteria: update persistent instructions and task templates so future tasks can consult existing distilled learnings before repeating the same failure class.
  Validation: inspect `~/.codex/AGENTS.md`, `codex/AGENTS.md`, and `codex/templates/parallel-nontrivial-implementation.md`

## Risks

- macOS permission-denied noise can dominate full-home scans and drown out real task failures.
- Exit code `1` is often non-fatal for search commands such as `rg`, so the harvester must filter probable false positives.
- Distilled rules can become cargo cults if they are promoted from one-off environment failures instead of repeated patterns.
- Session logs can contain sensitive paths or command text, so shared outputs must stay sanitized and raw generated artifacts must remain local-only.

## Current decision

The v1 loop promotes sanitized category-level guidance only. It does not auto-rewrite `AGENTS.md`, create automation, or commit raw failure logs.
