---
name: opencli
description: Use the local `opencli` binary when the user mentions OpenCLI, Browser Bridge, CLI-ing a website/app, or asks for a supported website/Electron/desktop action that likely needs logged-in Chrome state or an installed desktop adapter. First check `opencli doctor`; to discover supported adapters/capabilities use `opencli list` or `opencli list -f yaml`; to learn a specific adapter use `opencli <adapter> --help`. When executing `opencli`, use the normal local `exec` path and do not set `exec.host="gateway"`. Typical adapters include bilibili, zhihu, xiaohongshu, twitter, reddit, youtube, boss, xueqiu, weread, codex, cursor, chatgpt, notion, discord-app, and antigravity.
metadata:
  {
    "openclaw":
      {
        "requires": { "bins": ["opencli"] }
      }
  }
---

# OpenCLI

Use `opencli` instead of inventing browser automation when the target is already covered by an OpenCLI adapter.

Workflow

1. Check health first:

```bash
opencli doctor
```

If daemon or extension is not connected, say that plainly before trying browser commands.
Run local `opencli` commands via the default `exec` host; do not request `host:"gateway"` for them.

2. Discover commands instead of guessing:

```bash
opencli list -f yaml
opencli <adapter> --help
```

If the user asks what adapters/capabilities are available, prefer `opencli list` or `opencli list -f yaml`.
Do not answer `opencli --help` for adapter discovery unless the user explicitly asks for top-level CLI flags.
If the user asks how to invoke a specific adapter, prefer `opencli <adapter> --help`.

3. For browser adapters, assume Chrome must already be logged into the target site.

4. For desktop adapters, start with `status` when available, then use `read`, `send`, `new`, `dump`, or similar commands.

5. For external CLIs, OpenCLI is a passthrough wrapper:

```bash
opencli gh pr list --limit 5
opencli docker ps
opencli kubectl get pods
```

6. If asked to create or modify an OpenCLI adapter, read this first:

```text
/opt/homebrew/lib/node_modules/@jackwener/opencli/CLI-EXPLORER.md
```

Local setup on this machine

- Browser Bridge extension path: `/opt/homebrew/lib/node_modules/@jackwener/opencli/extension`
- Daemon is managed by LaunchAgent: `ai.opencli.daemon`
- Daemon listens on `127.0.0.1:19825`

Good first commands

```bash
opencli doctor
opencli list
opencli list -f yaml
opencli bilibili --help
opencli zhihu --help
opencli xiaohongshu --help
opencli codex --help
opencli cursor --help
```

Examples

```bash
opencli hackernews top --limit 10
opencli zhihu hot --limit 10
opencli xiaohongshu search "AI"
opencli youtube transcript "https://www.youtube.com/watch?v=..."
opencli codex status
opencli cursor read
```

Do not:

- invent `opencli` subcommands without checking `opencli list` or `opencli <adapter> --help`
- assume browser adapters work when `opencli doctor` is not all green
- replace `opencli` with generic scraping when the user explicitly asked to use OpenCLI, unless `opencli` is unavailable or unhealthy
