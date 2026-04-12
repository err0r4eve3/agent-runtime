## MCP Backup Scope

This folder backs up the Codex-side MCP setup used with this repository.

Included:
- `config.toml`: current `mcp_servers` definitions from `C:\Users\Daniel\.codex\config.toml`
- `ghidra-mcp/`: source snapshot of the local `ghidra-mcp` worktree

`ghidra-mcp/` intentionally excludes generated or machine-local artifacts:
- `.git`
- `.benchmarks/`
- `.pytest_cache/`
- `__pycache__/`
- `target/`
- `logs/`
- `tests/junit.xml`

If you restore this backup on another machine, review the Python paths, tool paths, and Ghidra/x64dbg locations in `config.toml` before reuse.
