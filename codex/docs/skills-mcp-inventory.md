# Codex Skills and MCP Inventory

> Checked-in snapshot summary for the current canonical Windows runtime.

## Snapshot

- Snapshot date: `2026-04-12`
- Host: `DESKTOP-GTGMLGK`
- OS: `Windows`
- Runtime focus: canonical sync snapshot stored directly under `codex/`
- Local Codex skill directories tracked in `codex/skills/local/`: `25`
- Project-specific DS3-Tool skill directories tracked in `codex/skills/projects/ds3-tool/`: `2`
- Top-level skill symlinks tracked in `codex/skills/local-symlinks.json`: `0`

## Canonical MCP Config

Configured MCP servers in `codex/mcp/config.toml`:

- `playwright`
- `mcp-ghidra`
- `github`
- `x64dbg`

## Tracked MCP Repositories

- `ghidra-mcp`: stored in `codex/mcp/repos/ghidra-mcp/`
- `x64dbg-mcp`: stored in `codex/mcp/repos/x64dbg-mcp/`

## Project Skills

DS3-Tool-specific skills are tracked in `codex/skills/projects/ds3-tool/` so they sync with the rest of the Codex runtime without pretending they are part of `~/.codex/skills`.

## Notes

- This file is now a checked-in snapshot summary, not a generator-owned document.
- When a new machine becomes the canonical sync source, update this file together with `codex/AGENTS.md`, `codex/skills/local/`, and `codex/mcp/`.
