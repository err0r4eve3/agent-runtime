# Codex Runtime Notes

This repo tracks the parts of the local Codex runtime that are most useful when moving between machines:

- local skills
- agent-home skills
- Codex subagent definitions
- project-specific skills worth syncing
- top-level symlinked skills
- enabled curated plugin skills
- Codex config
- Codex primary runtime metadata
- local MCP-capable tools and bridge tools
- checked-in MCP repositories and runtime bundles

## Why this matters

Multi-machine setup is mostly a reconstruction problem:

1. Know what was present.
2. Know where it lived.
3. Know how to update or recreate it.

The checked-in snapshot solves most of `1` and `2`.
The bootstrap and sync scripts help with `3`.

## Current operational flow

```bash
bash scripts/sync_codex_runtime.sh
```

## Notes

- Hosted services are documented when useful, but the repo focuses on local, restorable assets first.
- The sync flow is intentionally user-scope friendly: it copies config and skills metadata, but it does not commit secrets, auth tokens, logs, or databases.
- `inventories/<machine>/` is lightweight history and metadata; canonical sync content should live under `codex/`.
- Codex native memories are the only long-term memory layer for this runtime. Repo-local memory harvesting and distilled-learning scripts have been retired.
