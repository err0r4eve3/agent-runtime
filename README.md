# agent-runtime

This repository is a snapshot of the local `Codex` and `Cursor` runtime assets that are currently usable on this machine.

The content is split by runtime first, then by asset type:

- `codex/mcp`: Codex MCP configuration snapshot
- `codex/skills`: Codex-local skills and Codex vendor-imported skills
- `codex/rules`: Codex local rules plus imported Cursor rule library
- `cursor/mcp`: Cursor MCP configuration snapshot
- `cursor/skills`: Cursor-managed skills and Cursor global skills
- `cursor/rules`: Cursor global `.mdc` rule library
- `shared/mcp`: Local MCP server scripts referenced by the configs

What is intentionally not included:

- auth/session/state databases
- caches and logs unrelated to `mcp`, `skills`, or `rules`
- hidden git metadata from imported vendor repositories

Notes:

- The copied config files preserve their original absolute local paths.
- Both Codex and Cursor currently reference the local Ghidra bridge script, which is also copied into `shared/mcp/`.
- Codex can use imported Cursor rules through its compatibility layer, but it does not natively auto-apply Cursor `.mdc` rules the way Cursor does.
