---
name: cursor-update-settings
description: Modify Cursor or VS Code settings in Cursor's `settings.json`. Use when the user wants to change Cursor editor settings, themes, font size, format on save, autosave, keybindings, or other settings values.
---
# Update Cursor Settings

Use this skill when the task is about Cursor user settings or workspace settings.

## Paths

- macOS user settings: `~/Library/Application Support/Cursor/User/settings.json`
- Linux user settings: `~/.config/Cursor/User/settings.json`
- Windows user settings: `%APPDATA%\Cursor\User\settings.json`
- Repo-local workspace settings: `.vscode/settings.json`

## Workflow

1. Read the current file first.
2. Preserve unrelated settings.
3. Treat the file as JSONC: comments may exist.
4. Update only the requested keys.
5. Write valid JSON or JSONC with consistent indentation.
6. Mention if a reload or restart may be required.

## Common Keys

- `editor.fontSize`
- `editor.tabSize`
- `editor.formatOnSave`
- `editor.wordWrap`
- `workbench.colorTheme`
- `files.autoSave`
- `terminal.integrated.fontSize`

## Notes

- Clarify whether the user wants global Cursor settings or repo-only `.vscode/settings.json`.
- Keybindings live in `keybindings.json`, not `settings.json`; switch files when the request is specifically about shortcuts.
- For large changes, prefer the smallest edit that satisfies the request.
