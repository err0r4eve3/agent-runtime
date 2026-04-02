# Codex Runtime Notes

This repo tracks the parts of the local Codex runtime that are most useful when moving between machines:

- local skills
- top-level symlinked skills
- enabled curated plugin skills
- Codex config
- local MCP-capable tools and bridge tools
- update commands for those tools

## Why this matters

Multi-machine setup is mostly a reconstruction problem:

1. Know what was present.
2. Know where it lived.
3. Know how to update or recreate it.

The generated inventory solves `1` and `2`.
The bootstrap script solves `3`.

## Current operational flow

```bash
python3 ~/.codex/scripts/generate_codex_skills_mcp_inventory.py
bash scripts/sync_codex_runtime.sh
```

## Notes

- Hosted services such as Jina Reader appear in the generated inventory as documented runtime dependencies, but they are not stored here as local binaries.
- The sync script is intentionally user-scope friendly: it copies config and skills metadata, but it does not commit secrets, auth tokens, logs, or databases.
