# Codex MCP Assets

This directory stores the canonical Codex MCP snapshot for cross-machine sync.

Tracked content:

- `config.toml`: current Codex MCP configuration snapshot
- `repos/ghidra-mcp/`: local `ghidra-mcp` repository snapshot filtered to exclude git metadata and generated caches
- `repos/x64dbg-mcp/`: local `x64dbg-mcp` repository snapshot, including the runtime bundle currently referenced by the Windows Codex config

Excluded by design:

- git metadata from imported repositories
- generated caches such as `__pycache__`, `.pytest_cache`, `target`, and log folders
- auth tokens or machine state outside the checked-in config file

Notes:

- Paths in `config.toml` are machine-local and may need adjustment on restore.
- MCP repos are stored here because they are part of the working AI toolchain, not because every machine must use identical absolute paths.
