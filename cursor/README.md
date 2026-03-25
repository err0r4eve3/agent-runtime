# Cursor Assets

Source snapshot:

- `skills/skills-cursor/` comes from `/Users/error4ever/.cursor/skills-cursor`
- `extensions/extensions.json` comes from `/Users/error4ever/.cursor/extensions/extensions.json`
- `extensions/catalog.json` is generated from the installed extension manifest plus each extension's `package.json`
- `extensions/packages/*/package.json` comes from each installed extension bundle under `/Users/error4ever/.cursor/extensions/`
- `mcp/README.md` documents the Cursor MCP state on this machine
- `rules/README.md` documents the Cursor rules state on this machine

Current snapshot summary:

- `6` Cursor-managed skill directories
- `11` installed Cursor extensions tracked as metadata
- `0` standalone Cursor MCP config files
- `0` standalone Cursor global rule files

Layout notes:

- Cursor on this machine currently uses the managed `skills-cursor` tree only.
- Full extension payloads are intentionally not copied; this snapshot keeps the install manifest and per-extension metadata needed to reconstruct what was installed.
- See `extensions/README.md` for upstream marketplace/source links.
