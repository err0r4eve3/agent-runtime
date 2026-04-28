# Codex Skills and MCP Inventory

> Checked-in snapshot summary for the current canonical Windows runtime.

## Snapshot

- Snapshot date: `2026-04-28`
- Host: `DESKTOP-F61S3LC`
- OS: `Windows`
- Runtime focus: canonical sync snapshot stored directly under `codex/`
- Codex primary runtime bundle version: `26.426.12240`
- Local Codex skill directories tracked in `codex/skills/local/`: `68`
- Agent-home skill directories tracked in `codex/skills/agents-home/`: `53`
- Codex subagent definition groups tracked in `codex/agents/local/`: `1`
- Project-specific DS3-Tool skill directories tracked in `codex/skills/projects/ds3-tool/`: `2`
- Top-level skill symlinks tracked in `codex/skills/local-symlinks.json`: `0`

## Canonical MCP Config

Configured MCP servers in `codex/mcp/config.toml`:

- `github`
- `mcp-ghidra`
- `notebooklm`
- `playwright`
- `x64dbg`

Enabled Codex plugins in `codex/mcp/config.toml`:

- `browser-use@openai-bundled`
- `build-web-apps@openai-curated`
- `chatgpt-apps@openai-curated`
- `documents@openai-primary-runtime`
- `github@openai-curated`
- `google-drive@openai-curated`
- `latex-tectonic@openai-bundled`
- `presentations@openai-primary-runtime`
- `render@openai-curated`
- `spreadsheets@openai-primary-runtime`
- `superpowers@openai-curated`

## Tracked MCP Repositories

- `ghidra-mcp`: stored in `codex/mcp/repos/ghidra-mcp/`
- `x64dbg-mcp`: stored in `codex/mcp/repos/x64dbg-mcp/`

## Runtime Additions

- `codex/skills/local/` includes the current machine's Codex skills, including the installed `gstack-*` skills.
- `codex/skills/agents-home/` includes cross-agent skills from `~/.agents/skills`, including Waza and Compound Engineering `ce-*` skills.
- `codex/agents/local/` includes Compound Engineering subagent definitions from `~/.codex/agents`.
- `codex/docs/codex-primary-runtime.json` records Codex primary runtime bundle metadata.

## Project Skills

DS3-Tool-specific skills are tracked in `codex/skills/projects/ds3-tool/` so they sync with the rest of the Codex runtime without pretending they are part of `~/.codex/skills`.

## Notes

- This file is a checked-in snapshot summary generated from local repo state when the Codex inventory generator is unavailable.
- Codex native memories are the runtime memory layer; this repo no longer keeps a separate failure-learning or memory pipeline.
- When a new machine becomes the canonical sync source, update this file together with `codex/AGENTS.md`, `codex/skills/local/`, `codex/skills/agents-home/`, `codex/agents/local/`, and `codex/mcp/`.
