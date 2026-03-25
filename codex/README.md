# Codex Assets

Source snapshot:

- `mcp/config.toml` comes from `C:\Users\daniel\.codex\config.toml`
- `skills/local/` comes from `C:\Users\daniel\.codex\skills`
- `skills/vendor-imports/skills-repo/` comes from `C:\Users\daniel\.codex\vendor_imports\skills` with `.git` excluded
- `rules/local/` comes from `C:\Users\daniel\.codex\rules`
- `rules/vendor-imports/cursor-rules/` comes from `C:\Users\daniel\.codex\vendor_imports\cursor-rules`

Current snapshot summary:

- `36` local Codex skill directories
- `762` files in the imported Codex vendor skills repository snapshot
- `1` local Codex rules file
- `43` imported Cursor rule files available to Codex as a library

Recently synced local skills:

- `frontend-design`
- `web-design-guidelines`
- `vercel-react-best-practices`
- `better-auth-best-practices`
- `find-skills`

Important behavior note:

- `rules/vendor-imports/cursor-rules/` is a preserved Cursor rule library imported into Codex.
- Codex does not natively auto-apply `.mdc` rules; these files are typically used through the local `cursor-rules-library` skill under `skills/local/`.
