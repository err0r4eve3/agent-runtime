# Codex Assets

Source snapshot:

- `mcp/config.toml` comes from `/Users/error4ever/.codex/config.toml`
- `skills/local/` comes from the real directories under `/Users/error4ever/.codex/skills`
- `skills/local-symlinks.json` records the top-level symlink entrypoints under `/Users/error4ever/.codex/skills`
- `skills/vendor-imports/skills-repo/` comes from `/Users/error4ever/.codex/vendor_imports/skills` with `.git` excluded
- `rules/local/` comes from `/Users/error4ever/.codex/rules`
- `rules/vendor-imports/README.md` documents the imported-rule state on this machine

Current snapshot summary:

- `9` real local Codex skill directories
- `27` symlinked top-level Codex skill entrypoints
- `765` files in the imported Codex vendor skills repository snapshot
- `1` local Codex rules file
- `0` imported external Codex rule-library snapshots beyond the README note

Current local skills of note:

- `gstack`
- `design-md`
- `karpathy-autoresearch`
- Cursor migration/authoring helpers (`cursor-create-*`, `cursor-update-settings`, `cursor-migrate-to-codex`)

Important behavior notes:

- This machine's gstack install exposes most Codex-facing skill entrypoints as absolute symlinks into `~/.gstack/repos/gstack/.agents/skills/`.
- Those symlink targets are recorded in `skills/local-symlinks.json`; only real local directories are copied into `skills/local/`.
- There is no extra imported Cursor-rule repository wired into Codex on this machine right now; only `rules/local/default.rules` is present.
