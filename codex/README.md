# Codex Assets

This directory stores Codex-specific runtime state that is useful to recreate or inspect across machines.

## Tracked content

- `AGENTS.md`: local Codex persistent instruction overlay from `~/.codex/AGENTS.md`
- `mcp/config.toml`: current sanitized Codex config snapshot from `~/.codex/config.toml`
- `learning/`: failure-learning docs, execution plans, and distilled shared guardrails
- `skills/local/`: copied real local skill directories from `~/.codex/skills`
- `skills/local-symlinks.json`: top-level Codex skill symlink inventory
- `skills/vendor-imports/`: imported vendor skill snapshots that are worth preserving
- `rules/`: local Codex rules snapshot
- `docs/skills-mcp-inventory.md`: generated inventory of local skills, plugin skills, MCP-capable tools, bridge tools, versions, and update commands
- `docs/runtime-notes.md`: stable notes about what is being tracked and why

## Refresh

```bash
python3 ~/.codex/scripts/generate_codex_skills_mcp_inventory.py
bash scripts/sync_codex_runtime.sh
bash scripts/refresh_codex_learning.sh
```

## Important behavior notes

- On this machine, many `gstack-*` Codex skill entrypoints are symlinks into `~/.gstack/repos/gstack/.agents/skills/`.
- The generated inventory is the fastest way to inspect current Codex skills, plugin-provided skills, and local MCP/bridge tooling without manually traversing `~/.codex`.
- The failure-learning loop is intentionally conservative: it mines local session logs for recurring actionable failures, writes sanitized machine summaries, and only suggests durable rule promotions after aggregation.
