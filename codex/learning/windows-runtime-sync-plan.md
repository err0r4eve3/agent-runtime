# Windows Runtime Sync Transition Plan

## Goal

Turn `agent-runtime` into the canonical cross-machine sync repository for the current Windows Codex toolchain instead of treating the Windows snapshot as an inventory-only backup.

## Milestones

- Milestone 1: Replace the canonical `codex/` snapshot with the current Windows Codex state.
  Acceptance criteria: `codex/AGENTS.md`, `codex/mcp/config.toml`, and `codex/skills/local/` reflect `C:\Users\Daniel\.codex`; stale Mac-only symlink metadata is removed or replaced.
  Validation: inspect `git diff -- codex`

- Milestone 2: Promote MCP source snapshots into canonical tracked locations.
  Acceptance criteria: `ghidra-mcp` and `x64dbg-mcp` are stored under `codex/mcp/repos/` with generated caches and git metadata excluded.
  Validation: inspect `git diff -- codex/mcp`

- Milestone 3: Preserve project-specific DS3-Tool skills in canonical sync layout.
  Acceptance criteria: DS3-Tool project skills live under `codex/skills/projects/ds3-tool/`.
  Validation: inspect `git diff -- codex/skills/projects`

- Milestone 4: Demote machine inventory back to metadata/history only.
  Acceptance criteria: `inventories/DESKTOP-GTGMLGK/` no longer contains the large `ds3-tool-backup/` snapshot and only keeps machine-level artifacts.
  Validation: inspect `git diff -- inventories/DESKTOP-GTGMLGK`

- Milestone 5: Update docs and sync guidance for the new canonical layout.
  Acceptance criteria: `README.md`, `codex/README.md`, `codex/docs/runtime-notes.md`, and `scripts/sync_codex_runtime.sh` describe the overwrite-first sync model and no longer assume generated inventory is always available.
  Validation: inspect `git diff -- README.md codex/README.md codex/docs/runtime-notes.md scripts/sync_codex_runtime.sh`

## Risks

- Overwriting canonical `codex/` content can remove older Mac-specific runtime details that were previously stored only in the main snapshot.
- The Windows machine does not currently have the inventory generator used by the existing Mac workflow, so docs and scripts must handle that absence cleanly.
- Large MCP snapshots can bloat diffs if generated artifacts are not filtered consistently.
