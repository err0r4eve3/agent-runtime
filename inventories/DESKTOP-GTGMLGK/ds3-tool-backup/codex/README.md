## Codex Backup

This directory stores a repo-backed snapshot of the local Codex setup that is useful for DS3-Tool work.

Included:
- `skills/`: snapshot of `C:\Users\Daniel\.codex\skills`
- `mcp/config.toml`: extracted `mcp_servers` config from `C:\Users\Daniel\.codex\config.toml`
- `mcp/ghidra-mcp/`: filtered snapshot of `C:\Users\Daniel\.codex\worktrees\ghidra-mcp\openai-first-lazy-loading`

Excluded by design:
- auth and secrets such as `auth.json`, `.sandbox-secrets`, PAT values
- runtime state such as `sqlite/`, `sessions/`, `memories/`, `logs_2.sqlite*`, `state_5.sqlite*`
- plugin cache downloads under `C:\Users\Daniel\.codex\plugins\cache`
- MCP build/cache outputs such as `.git`, `target/`, `.pytest_cache/`, `__pycache__/`, and log folders

Notes:
- Paths in `mcp/config.toml` are machine-local Windows paths and may need adjustment after restore.
- Project-specific skills continue to live in the repository root `skills/` directory.
