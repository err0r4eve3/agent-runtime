# agent-runtime

Portable runtime snapshot and bootstrap repo for `Codex`, `Cursor`, and shared local agent tooling.

This repo is meant to do two jobs:

- Preserve a canonical sync snapshot of the current AI tooling setup.
- Make it easier to rebuild or align the same runtime on another machine.

## Layout

- `codex/`: Codex runtime snapshots, notes, and generated inventories
- `codex/AGENTS.md`: persistent Codex local instruction overlay
- `codex/learning/`: failure-learning workflow, distilled rules, and task plans
- `codex/mcp/repos/`: tracked local MCP repositories or runtime bundles worth syncing across machines
- `codex/skills/projects/`: project-specific skill snapshots that are not part of `~/.codex/skills`
- `codex/templates/`: reusable task templates for Codex CLI / cloud tasks
- `cursor/`: Cursor runtime snapshots
- `shared/`: cross-runtime tools and plugin metadata
- `scripts/`: bootstrap and sync helpers
- `inventories/<machine>/`: per-machine metadata, generated inventories, and lightweight history

## Codex flow

On a machine that already has Codex:

```bash
bash scripts/sync_codex_runtime.sh
bash scripts/refresh_codex_learning.sh
```

On a fresh machine you want to bring up to roughly the same runtime:

```bash
bash scripts/bootstrap_codex_runtime.sh
bash scripts/sync_codex_runtime.sh
bash scripts/refresh_codex_learning.sh
```

## What is intentionally not committed

- auth/session/state databases
- secrets and tokens
- caches and logs unrelated to runtime behavior
- hidden git metadata from imported vendor repositories
- large downloaded browser/runtime caches

## Notes

- `codex/` is the canonical sync target and may be overwritten when you intentionally promote a new machine snapshot.
- `inventories/<machine>/` is now lightweight history and metadata, not the place for large primary runtime backups.
- Codex failure learning is split on purpose:
  sanitized shared rules live in `codex/learning/`,
  machine-level summaries live in `inventories/<machine>/codex-learning-summary.md`,
  and raw harvested failure records stay under gitignored `codex/learning/generated/`.
- The repo stores reproducible metadata first; MCP repos and runtime bundles are included only when they are local, stable, and worth syncing across machines.

## Credits

### Skills

#### 思考 / 研究

- [karpathy/autoresearch](https://github.com/karpathy/autoresearch)

#### 开发

- [garrytan/gstack](https://github.com/garrytan/gstack)
- [openai/skills](https://github.com/openai/skills)

### Plugins

- [jackwener/opencli](https://github.com/jackwener/opencli)
- Installed Cursor extension links are documented in [cursor/extensions/README.md](cursor/extensions/README.md)
