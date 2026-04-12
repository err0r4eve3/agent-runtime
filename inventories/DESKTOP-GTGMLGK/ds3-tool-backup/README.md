# DS3-Tool Codex Backup

This snapshot preserves the DS3-Tool project `skills/` directory together with selected local Codex runtime assets that were useful for DS3-Tool work on `DESKTOP-GTGMLGK`.

Included:
- `skills/`: project-local skills from `C:\Users\Daniel\source\repos\DS3-Tool\skills`
- `codex/skills/`: snapshot of `C:\Users\Daniel\.codex\skills`
- `codex/mcp/config.toml`: extracted MCP server configuration from `C:\Users\Daniel\.codex\config.toml`
- `codex/mcp/ghidra-mcp/`: filtered snapshot of `C:\Users\Daniel\.codex\worktrees\ghidra-mcp\openai-first-lazy-loading`
- `codex/mcp/x64dbg-mcp/`: filtered snapshot of `C:\Users\Daniel\Desktop\tools\x64dbgMCP`

Excluded by design:
- auth/session/state files
- plugin cache downloads
- hidden git metadata from imported repositories
- generated caches such as `__pycache__`, `.pytest_cache`, `target`, and log folders

Notes:
- Paths inside the copied config are machine-local Windows paths.
- `x64dbg-mcp` includes the local `release-build1.1` runtime bundle because the Codex MCP config points to that path.
