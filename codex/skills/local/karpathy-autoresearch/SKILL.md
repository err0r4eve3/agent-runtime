---
name: karpathy-autoresearch
description: Use for Andrej Karpathy autoresearch repo work: setup, run baseline, autonomous LLM training experiments, program.md workflow, train.py edits, results.tsv logging. Also matches Karpathy autoresearch or Karpathy auto research requests.
---

# Karpathy Autoresearch

Use this skill when the user wants to work with Andrej Karpathy's `autoresearch` project that is installed locally at `/Users/error4ever/autoresearch`.

## Scope

- Repo path: `/Users/error4ever/autoresearch`
- Main files:
  - `README.md`
  - `program.md`
  - `prepare.py`
  - `train.py`

## Core Rules

- Read `program.md` before making changes or starting runs.
- Treat `prepare.py` as read-only.
- Default editable file is `train.py`.
- Do not add dependencies unless the user explicitly asks.
- Keep `results.tsv` untracked unless the user explicitly asks otherwise.

## Standard Workflow

1. Confirm the repo exists at `/Users/error4ever/autoresearch`.
2. Read `README.md` and `program.md`.
3. Check prerequisites:
   - Python/`uv`
   - NVIDIA GPU access if training is requested
   - cached data under `~/.cache/autoresearch/`
4. If cache is missing, instruct or run `uv run prepare.py` when appropriate.
5. For a fresh experiment run:
   - propose a run tag
   - create branch `autoresearch/<tag>`
   - initialize `results.tsv` with the header if missing
   - run the baseline first
6. Run experiments with redirected logs:
   - `uv run train.py > run.log 2>&1`
7. Read metrics from `run.log`, decide keep/discard, and append to `results.tsv`.

## Run Commands

```bash
cd /Users/error4ever/autoresearch
uv sync
uv run prepare.py
uv run train.py
```

For agent-style experiments, prefer:

```bash
cd /Users/error4ever/autoresearch
uv run train.py > run.log 2>&1
grep "^val_bpb:\|^peak_vram_mb:" run.log
```

## Notes

- The project compares experiments by `val_bpb`; lower is better.
- The training budget is fixed by the repo; do not change evaluation rules in `prepare.py`.
- If the user asks to "install into Codex", the intended meaning is usually to use this skill plus the local repo, not to compile a separate Codex plugin.
