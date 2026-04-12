# Codex Assets

This directory stores the canonical Codex-specific runtime snapshot that should be shared across machines.

## Tracked content

- `AGENTS.md`: local Codex persistent instruction overlay from `~/.codex/AGENTS.md`
- `mcp/config.toml`: current sanitized Codex config snapshot from `~/.codex/config.toml`
- `mcp/repos/`: checked-in MCP repositories or runtime bundles that should sync across machines
- `learning/`: failure-learning docs, execution plans, and distilled shared guardrails
- `skills/local/`: copied real local skill directories from `~/.codex/skills`
- `skills/projects/`: project-specific skills that live outside `~/.codex/skills`
- `skills/local-symlinks.json`: top-level Codex skill symlink inventory
- `skills/vendor-imports/`: imported vendor skill snapshots that are worth preserving
- `rules/`: local Codex rules snapshot
- `docs/skills-mcp-inventory.md`: current checked-in snapshot summary for the canonical Codex runtime
- `docs/runtime-notes.md`: stable notes about what is being tracked and why

## Refresh

```bash
bash scripts/sync_codex_runtime.sh
bash scripts/refresh_codex_learning.sh
```

## Important behavior notes

- `skills/local/` is expected to be overwritten when intentionally promoting a new machine into the canonical sync snapshot.
- `skills/projects/` is where repo-local or project-specific skills should live when they are worth syncing but are not installed directly under `~/.codex/skills`.
- `mcp/repos/` is for local MCP repositories and runtime bundles that need to move with the rest of the Codex toolchain.
- The failure-learning loop is intentionally conservative: it mines local session logs for recurring actionable failures, writes sanitized machine summaries, and only suggests durable rule promotions after aggregation.
