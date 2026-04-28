# agent-runtime

Portable runtime snapshot and bootstrap repo for `Codex`, `Cursor`, and shared local agent tooling.

This repo is meant to do two jobs:

- Preserve a canonical sync snapshot of the current AI tooling setup.
- Make it easier to rebuild or align the same runtime on another machine.

## Layout

- `codex/`: Codex runtime snapshots, notes, and generated inventories
- `codex/AGENTS.md`: persistent Codex local instruction overlay
- `codex/agents/local/`: snapshot of Codex subagent definitions from `~/.codex/agents`
- `codex/mcp/repos/`: tracked local MCP repositories or runtime bundles worth syncing across machines
- `codex/skills/agents-home/`: snapshot of agent-home skills from `~/.agents/skills`
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
```

On a fresh machine you want to bring up to roughly the same runtime:

```bash
bash scripts/bootstrap_codex_runtime.sh
bash scripts/sync_codex_runtime.sh
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
- Codex native memories are now the long-term memory layer. This repo no longer keeps its own failure-learning or memory pipeline.
- The repo stores reproducible metadata first; MCP repos and runtime bundles are included only when they are local, stable, and worth syncing across machines.

## Credits

### MCP repositories

- `codex/mcp/repos/ghidra-mcp/` is synced from a local working tree based on [bethington/ghidra-mcp](https://github.com/bethington/ghidra-mcp), with ongoing personal fork work tracked at [err0r4eve3/ghidra-mcp](https://github.com/err0r4eve3/ghidra-mcp).
- `codex/mcp/repos/x64dbg-mcp/` is synced from the local clone of [Wasdubya/x64dbgMCP](https://github.com/Wasdubya/x64dbgMCP).

### Skills

- `codex/skills/local/` is the canonical snapshot of the current machine's `~/.codex/skills`, including locally maintained process and research skills.
- `codex/skills/agents-home/` is the canonical snapshot of the current machine's `~/.agents/skills`, including skills installed by cross-agent tooling.
- `codex/skills/local/.system/` preserves Codex-bundled system skills; related public skill packaging and vendor snapshots are tracked alongside [openai/skills](https://github.com/openai/skills).
- `codex/skills/vendor-imports/skills-repo/` preserves a vendor skill snapshot from [openai/skills](https://github.com/openai/skills).
- `codex/skills/projects/ds3-tool/` is synced from [err0r4eve3/DS3-Tool](https://github.com/err0r4eve3/DS3-Tool)'s local `skills/` directory.

### Plugins and extensions

- `shared/plugins/opencli/` tracks metadata derived from [jackwener/opencli](https://github.com/jackwener/opencli).
- Installed Cursor extension sources are documented in [cursor/extensions/README.md](cursor/extensions/README.md).
