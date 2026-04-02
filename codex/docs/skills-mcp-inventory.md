# Codex Skills and MCP Inventory

> Generated file. Refresh with `python3 ~/.codex/scripts/generate_codex_skills_mcp_inventory.py`.

## Snapshot

- Generated at: `2026-04-03 00:03:02 CST`
- Codex latest known version: `0.116.0`
- Model: `gpt-5.4`
- Reasoning effort: `xhigh`
- Sandbox mode: `danger-full-access`
- Approval policy: `never`
- Enabled curated plugins: `5`
- Local active skills: `38`
- Local backup skills: `4`

## Custom MCP Config

- No user-defined MCP sections detected in `/Users/error4ever/.codex/config.toml`.
- Current MCP-like capabilities come from enabled curated plugins and locally installed bridge/server tools.

## Enabled Curated Plugins

### `canva@openai-curated`

| Skill | Summary | Path |
| --- | --- | --- |
| canva:canva-branded-presentation | Use this skill to turn a brief, outline, or existing Canva content into a branded presentation. Gather the source content first, choose the  | `/Users/error4ever/.codex/plugins/cache/openai-curated/canva/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/canva-branded-presentation/SKILL.md` |
| canva:canva-resize-for-all-social-media | Use this skill to take one Canva design and create a multi-platform set of resized variants. Identify the source design, generate the reques | `/Users/error4ever/.codex/plugins/cache/openai-curated/canva/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/canva-resize-for-all-social-media/SKILL.md` |
| canva:canva-translate-design | Use this skill to create a translated copy of an existing Canva design. Find the source design, duplicate it safely, translate text elements | `/Users/error4ever/.codex/plugins/cache/openai-curated/canva/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/canva-translate-design/SKILL.md` |

### `github@openai-curated`

| Skill | Summary | Path |
| --- | --- | --- |
| github:gh-address-comments | Use this skill when the user wants to work through requested changes on a GitHub pull request. Use the GitHub app from this plugin for PR me | `/Users/error4ever/.codex/plugins/cache/openai-curated/github/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/gh-address-comments/SKILL.md` |
| github:gh-fix-ci | Use this skill when the task is specifically about failing GitHub Actions checks on a pull request. This workflow is hybrid by design: | `/Users/error4ever/.codex/plugins/cache/openai-curated/github/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/gh-fix-ci/SKILL.md` |
| github:github | Use this skill as the umbrella entrypoint for general GitHub work in this plugin. It should decide whether the task stays in repo and PR tri | `/Users/error4ever/.codex/plugins/cache/openai-curated/github/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/github/SKILL.md` |
| github:yeet | Use this skill only when the user explicitly wants the full publish flow from the local checkout: branch setup if needed, staging, commit, p | `/Users/error4ever/.codex/plugins/cache/openai-curated/github/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/yeet/SKILL.md` |

### `gmail@openai-curated`

| Skill | Summary | Path |
| --- | --- | --- |
| gmail:gmail | Use this skill to turn noisy email threads into clear summaries, action lists, and ready-to-send drafts. Prefer Gmail-native search and read | `/Users/error4ever/.codex/plugins/cache/openai-curated/gmail/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/gmail/SKILL.md` |
| gmail:gmail-inbox-triage | Use this skill for direct inbox-triage requests. Build on the core Gmail skill at [../gmail/SKILL.md](../gmail/SKILL.md), especially its sea | `/Users/error4ever/.codex/plugins/cache/openai-curated/gmail/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/gmail-inbox-triage/SKILL.md` |

### `google-calendar@openai-curated`

| Skill | Summary | Path |
| --- | --- | --- |
| google-calendar:google-calendar | Use this skill to turn raw calendar data into clear scheduling decisions. Keep answers grounded in exact dates, times, and calendar evidence | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-calendar/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-calendar/SKILL.md` |
| google-calendar:google-calendar-daily-brief | Use this skill to turn one day of Google Calendar events into a readable daily brief instead of a raw event dump. Use the Google Calendar ap | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-calendar/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-calendar-daily-brief/SKILL.md` |
| google-calendar:google-calendar-free-up-time | Use this skill when the goal is to create time, not just inspect time. | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-calendar/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-calendar-free-up-time/SKILL.md` |
| google-calendar:google-calendar-group-scheduler | Use this skill when the scheduling problem is the task. | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-calendar/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-calendar-group-scheduler/SKILL.md` |
| google-calendar:google-calendar-meeting-prep | Use this skill when the user wants a prep brief, not just the event details. | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-calendar/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-calendar-meeting-prep/SKILL.md` |

### `google-drive@openai-curated`

| Skill | Summary | Path |
| --- | --- | --- |
| google-drive:google-docs | Use this guide for precise Google Docs reading, editing, and creation. | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-drive/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-docs/SKILL.md` |
| google-drive:google-drive | Use this as the top-level router for Google file work inside the unified Google Drive plugin. Do not route the user toward separate Google D | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-drive/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-drive/SKILL.md` |
| google-drive:google-sheets | Use this skill to keep spreadsheet work grounded in the exact spreadsheet, sheet, range, headers, and formulas that matter. | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-drive/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-sheets/SKILL.md` |
| google-drive:google-sheets-chart-builder | Use this skill when the chart itself is the task. | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-drive/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-sheets-chart-builder/SKILL.md` |
| google-drive:google-sheets-formula-builder | Use this skill when the formula itself is the task. | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-drive/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-sheets-formula-builder/SKILL.md` |
| google-drive:google-slides | Use this skill as the default entrypoint for Google Slides work. Stay here for deck search, summaries, general content edits, imports, nativ | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-drive/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-slides/SKILL.md` |
| google-drive:google-slides-import-presentation | Use this skill when the source material is a presentation file rather than an existing Google Slides deck. The goal is to create a native Go | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-drive/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-slides-import-presentation/SKILL.md` |
| google-drive:google-slides-template-migration | Use this skill when the user has: | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-drive/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-slides-template-migration/SKILL.md` |
| google-drive:google-slides-template-surgery | Use this skill for structural Google Slides cleanup. This is the escalation path after normal visual iteration fails to converge. | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-drive/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-slides-template-surgery/SKILL.md` |
| google-drive:google-slides-visual-iteration | Use this skill for existing or newly imported Google Slides decks when the user wants visual cleanup, not just content edits. | `/Users/error4ever/.codex/plugins/cache/openai-curated/google-drive/f78e3ad49297672a905eb7afb6aa0cef34edc79e/skills/google-slides-visual-iteration/SKILL.md` |

## Local Skills

| Skill | Summary | Path |
| --- | --- | --- |
| cursor-create-rule | Use this skill when the task is about authoring or updating rules for Cursor rather than Codex. | `/Users/error4ever/.codex/skills/cursor-create-rule/SKILL.md` |
| cursor-create-skill | Use this skill for Cursor skill authoring, not Codex skill authoring. | `/Users/error4ever/.codex/skills/cursor-create-skill/SKILL.md` |
| cursor-create-subagent | Use this skill when the user wants reusable Cursor subagents stored on disk. | `/Users/error4ever/.codex/skills/cursor-create-subagent/SKILL.md` |
| cursor-migrate-to-codex | Use this skill when the task is to convert Cursor guidance into Codex skills. | `/Users/error4ever/.codex/skills/cursor-migrate-to-codex/SKILL.md` |
| cursor-update-settings | Use this skill when the task is about Cursor user settings or workspace settings. | `/Users/error4ever/.codex/skills/cursor-update-settings/SKILL.md` |
| design-md | You are an expert Design Systems Lead. Your goal is to analyze the provided technical assets and synthesize a "Semantic Design System" into  | `/Users/error4ever/.codex/skills/design-md/SKILL.md` |
| doc | - Read or review DOCX content where layout matters (tables, diagrams, pagination). | `/Users/error4ever/.codex/skills/doc/SKILL.md` |
| gstack | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack/SKILL.md` |
| gstack-autoplan | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-autoplan/SKILL.md` |
| gstack-benchmark | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-benchmark/SKILL.md` |
| gstack-browse | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-browse/SKILL.md` |
| gstack-canary | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-canary/SKILL.md` |
| gstack-careful | > **Safety Advisory:** This skill includes safety checks that check bash commands for destructive operations (rm -rf, DROP TABLE, force-push | `/Users/error4ever/.codex/skills/gstack-careful/SKILL.md` |
| gstack-cso | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-cso/SKILL.md` |
| gstack-design-consultation | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-design-consultation/SKILL.md` |
| gstack-design-review | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-design-review/SKILL.md` |
| gstack-document-release | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-document-release/SKILL.md` |
| gstack-freeze | > **Safety Advisory:** This skill includes safety checks that verify file edits are within the allowed scope boundary before applying, and v | `/Users/error4ever/.codex/skills/gstack-freeze/SKILL.md` |
| gstack-guard | > **Safety Advisory:** This skill includes safety checks that check bash commands for destructive operations (rm -rf, DROP TABLE, force-push | `/Users/error4ever/.codex/skills/gstack-guard/SKILL.md` |
| gstack-investigate | > **Safety Advisory:** This skill includes safety checks that verify file edits are within the allowed scope boundary before applying, and v | `/Users/error4ever/.codex/skills/gstack-investigate/SKILL.md` |
| gstack-land-and-deploy | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-land-and-deploy/SKILL.md` |
| gstack-office-hours | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-office-hours/SKILL.md` |
| gstack-plan-ceo-review | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-plan-ceo-review/SKILL.md` |
| gstack-plan-design-review | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-plan-design-review/SKILL.md` |
| gstack-plan-eng-review | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-plan-eng-review/SKILL.md` |
| gstack-qa | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-qa/SKILL.md` |
| gstack-qa-only | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-qa-only/SKILL.md` |
| gstack-retro | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-retro/SKILL.md` |
| gstack-review | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-review/SKILL.md` |
| gstack-setup-browser-cookies | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-setup-browser-cookies/SKILL.md` |
| gstack-setup-deploy | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-setup-deploy/SKILL.md` |
| gstack-ship | _ROOT=$(git rev-parse --show-toplevel 2>/dev/null) | `/Users/error4ever/.codex/skills/gstack-ship/SKILL.md` |
| gstack-unfreeze | Remove the edit restriction set by `/freeze`, allowing edits to all directories. | `/Users/error4ever/.codex/skills/gstack-unfreeze/SKILL.md` |
| gstack-upgrade | Upgrade gstack to the latest version and show what's new. | `/Users/error4ever/.codex/skills/gstack-upgrade/SKILL.md` |
| karpathy-autoresearch | Use this skill when the user wants to work with Andrej Karpathy's `autoresearch` project that is installed locally at `/Users/error4ever/aut | `/Users/error4ever/.codex/skills/karpathy-autoresearch/SKILL.md` |
| pdf | - Read or review PDF content where layout and visuals matter. | `/Users/error4ever/.codex/skills/pdf/SKILL.md` |
| playwright | Drive a real browser from the terminal using `playwright-cli`. Prefer the bundled wrapper script so the CLI works even when it is not global | `/Users/error4ever/.codex/skills/playwright/SKILL.md` |
| spreadsheet | - Create new workbooks with formulas, formatting, and structured layouts. | `/Users/error4ever/.codex/skills/spreadsheet/SKILL.md` |

## Local Backup Skills

| Backup Skill | Path |
| --- | --- |
| doc.bak-20260331-114332 | `/Users/error4ever/.codex/skills/doc.bak-20260331-114332/SKILL.md` |
| pdf.bak-20260331-114332 | `/Users/error4ever/.codex/skills/pdf.bak-20260331-114332/SKILL.md` |
| playwright.bak-20260331-114332 | `/Users/error4ever/.codex/skills/playwright.bak-20260331-114332/SKILL.md` |
| spreadsheet.bak-20260331-114332 | `/Users/error4ever/.codex/skills/spreadsheet.bak-20260331-114332/SKILL.md` |

## Installed MCP and Bridge Tools

| Tool | Version | Role | Command Path | Update Command |
| --- | --- | --- | --- | --- |
| opencli | 1.6.1 | Structured site CLI and browser bridge | `/opt/homebrew/bin/opencli` | `npm install -g --prefix ~/.local @jackwener/opencli@latest` |
| playwright-mcp-server | 1.0.12 | Standalone Playwright MCP server | `/Users/error4ever/.local/bin/playwright-mcp-server` | `npm install -g --prefix ~/.local @executeautomation/playwright-mcp-server@latest` |
| ctx7 | 0.3.9 | Context7 CLI | `/Users/error4ever/.local/bin/ctx7` | `npm install -g --prefix ~/.local ctx7@latest` |
| context7-mcp | 2.1.6 | Context7 MCP server | `/Users/error4ever/.local/bin/context7-mcp` | `npm install -g --prefix ~/.local @upstash/context7-mcp@latest` |
| agent-reach | 1.4.0 | Search and platform-access installer / health check | `/Users/error4ever/.local/bin/agent-reach` | `uv tool install --python python3.11 --upgrade --from https://github.com/Panniantong/Agent-Reach/archive/main.zip agent-reach` |
| scrapling | 0.4.3 | Anti-bot scraping framework with MCP mode | `/Users/error4ever/.local/bin/scrapling` | `uv tool install --python python3.11 --upgrade 'scrapling[fetchers]'` |

## Repository-based Integrations

| Repo | Commit | Path | Entrypoints | Remote | Update Command |
| --- | --- | --- | --- | --- | --- |
| grok-bridge | 9a2d8ab | `/Users/error4ever/.local/share/free-agent-tools/grok-bridge` | /Users/error4ever/.local/bin/grok-bridge-start, /Users/error4ever/.local/bin/grok-chat | https://github.com/ythx-101/grok-bridge.git | `git -C ~/.local/share/free-agent-tools/grok-bridge pull --ff-only` |
| web-access | 7ff4877 | `/Users/error4ever/.local/share/free-agent-tools/web-access` | skill repo only | https://github.com/eze-is/web-access.git | `git -C ~/.local/share/free-agent-tools/web-access pull --ff-only` |
| opencli-source | fe82b38 | `/Users/error4ever/.local/share/free-agent-tools/opencli-source` | /Users/error4ever/.local/share/free-agent-tools/opencli-source/extension | https://github.com/jackwener/opencli.git | `git -C ~/.local/share/free-agent-tools/opencli-source pull --ff-only` |

## Other Related UV Tools Present

| Package | Version | Executables |
| --- | --- | --- |
| bilibili-cli | 0.6.2 | bili |
| kabi-tg-cli | 0.4.2 | tg |
| nano-pdf | 0.2.1 | nano-pdf |
| twitter-cli | 0.6.3 | twitter |
| xiaohongshu-cli | 0.1.0 | xhs |

## Quick Refresh

```bash
python3 ~/.codex/scripts/generate_codex_skills_mcp_inventory.py
```

## Notes

- `Jina Reader` is a zero-install hosted service, so it is intentionally not listed as a local binary.
- `web-access` is tracked here as a local skill repository, not a custom MCP section in Codex config.
- `playwright-mcp-server`, `context7-mcp`, and `scrapling mcp` are available as local MCP-capable server entrypoints.
- If you later add user-defined MCP sections to `~/.codex/config.toml`, rerun the generator and they will appear in the MCP section.
