# agent-runtime

This repository is a snapshot of the `Codex`, `Cursor`, and shared local plugin assets currently installed on this machine.

The content is split by runtime first, then by asset type:

- `codex/mcp`: current Codex base config snapshot
- `codex/skills`: local Codex skills, symlink inventory, and vendor-imported skills
- `codex/rules`: local Codex rules plus notes for optional imported rule libraries
- `cursor/skills`: current Cursor-managed skills
- `cursor/extensions`: installed Cursor extension inventory plus per-extension `package.json` metadata
- `cursor/mcp`: note for Cursor MCP state on this machine
- `cursor/rules`: note for Cursor rules state on this machine
- `shared/plugins`: cross-runtime local tools/plugins such as `opencli`
- `shared/mcp`: note for shared MCP helper state on this machine

What is intentionally not included:

- auth/session/state databases
- secrets and tokens
- caches and logs unrelated to runtime behavior
- hidden git metadata from imported vendor repositories
- full Cursor extension bundles and other large binary payloads

Notes:

- The copied config and metadata files preserve their original absolute local paths where useful.
- Codex top-level skill entrypoints are partly symlink-based on this machine; the real directories are copied under `codex/skills/local/` and the symlink map lives in `codex/skills/local-symlinks.json`.
- Cursor does not currently have a standalone `mcp.json` or a separate global rules tree on this machine, so those folders only contain explanatory README files.
- `opencli` is tracked under `shared/plugins/opencli/` because it is a cross-runtime local tool with both a local skill wrapper and a browser bridge extension.

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
