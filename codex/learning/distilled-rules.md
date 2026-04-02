# Distilled Codex Learnings

- Generated at: 2026-04-02T16:57:40.779075+00:00
- Source: `/Users/error4ever/Dev/agent-runtime/codex/learning/generated/error4everdeMacBook-Air/failures.jsonl`
- Promotion threshold: 2 actionable hits per category

This file is generated from harvested session failures. It suggests reusable guardrails, but it does not auto-edit persistent instructions.

## Promotion policy

- Promote only patterns that recur and have a concrete prevention step.
- Keep category-level guardrails broad enough to reuse across repositories.
- Leave one-off environment issues in summaries until they repeat.

## Reusable learnings

### `python_traceback`
- Hits: 3040
- Guardrail: Treat inline Python as production code: add input type guards, simplify the snippet, or move repeated logic into a checked script.
- Best promotion target: repo scripts, shell safety notes, reusable utilities
- Validation loop: Re-run the exact Python entrypoint and confirm the traceback is gone.
- Common signals:
  - `Traceback (most recent call last):` x1934
  - `ERROR: test_shop_router_shadow_write (unittest.loader._FailedTest.test_shop_router_shadow_write)` x84
  - `ERROR: test_get_shop_summary_includes_shadow_coverage (tests.test_shop_admin_shadow_summary.ShopAdminShadowSummaryTestCase.test_get_shop_summary_includes_shadow_coverage)` x49
- Recent examples:
  - `2026-03-21T10:45:18.016Z` via `python3 - <<'PY' import inspect from py_clob_client.client import ClobClient print(inspect.getsource(ClobClient.get_balance_allowance)) PY` -> `Traceback (most recent call last):`
  - `2026-03-21T10:45:18.062Z` via `python3 - <<'PY' import inspect from py_clob_client.client import ClobClient print(inspect.getsource(ClobClient.create_or_derive_api_creds)) PY` -> `Traceback (most recent call last):`
  - `2026-03-21T10:45:18.065Z` via `python3 - <<'PY' from eth_account import Account from pathlib import Path import re text = Path('~/.../Dev/Projects/polymarket-bot/.env').read_text() pk = re.search(r'^PRIVATE_KEY=(.+)$', text, re.M).group(<n>).strip() acct = Account.from_key(pk) print(acct.address) PY` -> `Traceback (most recent call last):`

### `test_or_build_failure`
- Hits: 2025
- Guardrail: Capture the failing assertion or compiler error first, then reproduce with the narrowest deterministic validation before editing code.
- Best promotion target: task templates, debugging workflow, review checklist
- Validation loop: Run the narrow failing command, fix it, then re-run the full validation command.
- Common signals:
  - `SyntaxError: invalid syntax` x351
  - `xcode-select: Failed to locate 'python', requesting installation of command line developer tools.` x326
  - `xcode-select: Failed to locate 'python', and no install could be requested (perhaps no UI is present). Please install manually from 'developer.apple.com'.` x131
- Recent examples:
  - `2026-03-17T07:33:20.705Z` via `pgrep -fl "clash-verge|mihomo|clash"` -> `sysmon request failed with error: sysmond service not found`
  - `2026-03-20T09:47:14.120Z` via `/bin/zsh -lc 'UV_CACHE_DIR=/tmp/uv-cache uv run ruff check src/config.py src/strategy/signal_pipeline.py src/optimize/tuner.py tests/test_config.py tests/test_signal_pipeline.py tests/test_optimizer_tuner.py tests/test_paper_report.py'` -> `× Failed to build `polymarket-bot @`
  - `2026-03-20T13:14:33.430Z` via `.venv/bin/pytest -q ~/.../Dev/Projects/polymarket-bot/tests/test_signal_pipeline.py ~/.../Dev/Projects/polymarket-bot/tests/test_paper_execution.py ~/.../Dev/Projects/polymarket-bot/tests/test_paper_execution_realism.py ~/.../Dev/Projects/polymarket-bot/tests/test_paper_orchestrator.py ~/.../Dev/Projects/polymarket-bot/tests/test_paper_portfolio.py ~/.../Dev/Projects/polymarket-bot/tests/test_paper_portfolio_deepen.py ~/.../Dev/Projects/polymarket-bot/tests/test_execution_engine_paper_dispatch.py ~/.../Dev/Projects/polymarket-bot/tests/test_main_market_filters.py` -> `E AssertionError: assert 'DRY_RUN_LEG_RISK' == 'DRY_RUN_FILLED'`

### `tool_runtime_failure`
- Hits: 683
- Guardrail: Separate agent-tool misuse from repository bugs. Fix session lifecycle, TTY, stdin, or agent-limit issues before editing product code.
- Best promotion target: task templates, runtime docs, operator checklists
- Validation loop: Re-run the same tool step and confirm the runtime failure marker is gone before continuing.
- Common signals:
  - `collab spawn failed: agent thread limit reached (max <n>)` x336
  - `write_stdin failed: stdin is closed for this session; rerun exec_command with tty=true to keep stdin open` x290
  - `write_stdin failed: Unknown process id <n>` x54
- Recent examples:
  - `2026-03-21T10:32:05.450Z` via `/bin/zsh -lc 'env OPTIMIZER_PREFLIGHT_MODE=light OPTIMIZER_DAEMON_ROOT=data/optimize-daemon-live-15m OPTIMIZER_FAILURE_BACKOFF_SECONDS=<n> bash scripts/auto_optimize_daemon.sh <n> <n> <n>'` -> `write_stdin failed: Unknown process id <n>`
  - `2026-03-23T11:51:46.038Z` via `/bin/zsh -lc 'ACTIVE_MARKET_LIMIT=<n> RESEARCH_CORE_HINT_SLOTS=<n> RESEARCH_POLYMARKET_LIMIT=<n> .venv/bin/python -m src.optimize.autoresearch --tag officehours-<hex>-v10-active5000-slots64-limit400 --iterations <n> --duration <n>'` -> `write_stdin failed: stdin is closed for this session; rerun exec_command with tty=true to keep stdin open`
  - `2026-03-23T11:56:27.459Z` via `/bin/zsh -lc 'ACTIVE_MARKET_LIMIT=<n> RESEARCH_CORE_HINT_SLOTS=<n> RESEARCH_POLYMARKET_LIMIT=<n> .venv/bin/python -m src.optimize.autoresearch --tag officehours-<hex>-v11-partial-hydration --iterations <n> --duration <n>'` -> `write_stdin failed: stdin is closed for this session; rerun exec_command with tty=true to keep stdin open`

### `shell_quoting`
- Hits: 500
- Guardrail: Rewrite regex-heavy, JSON-heavy, or multi-quote shell commands into here-docs, smaller steps, or checked-in scripts before retrying.
- Best promotion target: `AGENTS.md` shell safety section, reusable repo scripts
- Validation loop: Re-run the rewritten command and confirm a clean exit code with no shell parser errors.
- Common signals:
  - `Process exited with code <n>` x198
  - `bash: -c: line <n>: unexpected EOF while looking for matching `"'` x72
  - `Traceback (most recent call last):` x67
- Recent examples:
  - `2026-03-25T06:35:10.047Z` via `AUTORESEARCH_DAEMON_ROOT=data/autoresearch-daemon-live AUTORESEARCH_TAG_PREFIX=live bash scripts/autoresearch_daemon.sh <n> <n> <n>` -> `awk: syntax error at source line <n>`
  - `2026-03-29T04:15:48.816Z` via `uv run python - <<'PY' import sqlite3, json, pathlib p = pathlib.Path('~/.../Dev/Projects/polymarket-bot/data/autoresearch/daemon-<hex>-<n>-batch-<n>/cand-<n>/data/trades.db') conn = sqlite3.connect(str(p)) cur = conn.cursor() cur.execute("select market_id, strategy, metadata from trades where status in ('DRY_RUN_FILLED','DRY_RUN_PARTIAL_FILL')") for market_id, strategy, metadata in cur.fetchall(): print('MARKET', market_id, 'STRATEGY', strategy) try: payload = json.loads(metadata) if metadata else {} except Exception as exc: print(' metadata parse error', exc) continue if isinstance(payload, dict): keys = sorted(payload.keys()) print(' keys', keys) for key in ['event_id','event_family_key','market_id','market_ids','question','group_title','titles','legs','analysis']: if key in payload: print(' ', key, payload[key]) print(' payload_sample', json.dumps(payload)[:<n>]) conn.close() PY` -> `print(' metadata parse error', exc)`
  - `2026-03-20T10:01:07.173Z` via `/bin/zsh -lc "ssh fiberstate 'cd /home/user1/subtitle_pipeline` -> `Traceback (most recent call last):`

### `missing_command`
- Hits: 284
- Guardrail: Probe tool availability with `command -v` before use, then either install the tool or pick a supported fallback.
- Best promotion target: bootstrap scripts, task templates, preflight checks
- Validation loop: Confirm the binary exists before invoking the main workflow.
- Common signals:
  - `bash: line <n>: rg: command not found` x87
  - `bash: line <n>: sqlite3: command not found` x70
  - `zsh:<n>: command not found: python` x69
- Recent examples:
  - `2026-03-21T11:46:21.823Z` via `python - <<'PY' import inspect from py_clob_client.clob_types import OrderArgs from py_clob_client.client import ClobClient print(OrderArgs) print(inspect.signature(OrderArgs)) print(inspect.signature(ClobClient.create_order)) PY` -> `zsh:<n>: command not found: python`
  - `2026-03-21T11:46:21.823Z` via `python - <<'PY' import inspect, py_clob_client.client as c src = inspect.getsource(c.ClobClient.create_order) print(src) PY` -> `zsh:<n>: command not found: python`
  - `2026-03-21T11:46:21.837Z` via `python - <<'PY' import inspect, py_clob_client.order_builder.builder as b print(inspect.getsource(b.OrderBuilder.build_signed_order)) PY` -> `zsh:<n>: command not found: python`

### `git_or_network`
- Hits: 265
- Guardrail: Separate auth, DNS, SSL, and connectivity failures before retrying. Only re-run once the root transport issue is explicit.
- Best promotion target: network troubleshooting notes, git workflows, bootstrap docs
- Validation loop: Repeat the same remote operation only after the transport precondition is fixed.
- Common signals:
  - `Process exited with code <n>` x159
  - `Traceback (most recent call last):` x75
  - `fatal: not a git repository (or any of the parent directories): .git` x14
- Recent examples:
  - `2026-03-17T07:32:28.942Z` via `curl -s <url>` -> `Process exited with code <n>`
  - `2026-03-17T07:32:28.942Z` via `curl -s <url>` -> `Process exited with code <n>`
  - `2026-03-17T07:32:33.402Z` via `curl --unix-socket /tmp/verge/verge-mihomo.sock -s <url>` -> `Process exited with code <n>`

### `permission_denied`
- Hits: 101
- Guardrail: Scope scans away from protected directories, or redirect expected permission noise so exit codes are interpreted correctly.
- Best promotion target: search commands, repo helper scripts, troubleshooting docs
- Validation loop: Re-run the narrowed command and verify that permission noise no longer masks the real result.
- Common signals:
  - `root@<n>.<n>.<n>.<n>: Permission denied (publickey,password).` x26
  - `mkdir: cannot create directory ‘/pt/emby-diagnostics’: Permission denied` x22
  - `cp: cannot create regular file '/storage/clouddrive2/Config/systemsettings.json.bak-<hex>-<n>': Permission denied` x22
- Recent examples:
  - `2026-03-21T11:38:15.658Z` via `ssh fiberstate 'mkdir -p /pt/emby-diagnostics/docs && cat > /pt/emby-diagnostics/emby_startup_probe.py && chmod <n> /pt/emby-diagnostics/emby_startup_probe.py' < ~/.../Dev/Projects/emby-bot/tools/emby_startup_probe.py` -> `mkdir: cannot create directory ‘/pt/emby-diagnostics’: Permission denied`
  - `2026-03-21T16:20:36.503Z` via `ssh root@fiberstate 'whoami'` -> `root@<n>.<n>.<n>.<n>: Permission denied (publickey,password).`
  - `2026-03-21T17:25:55.605Z` via `/bin/zsh -lc "ssh fiberstate 'ts="'$(TZ=Asia/Shanghai date +%Y%m%d-%H%M%S); cp /storage/clouddrive2/Config/systemsettings.json /storage/clouddrive2/Config/systemsettings.json.bak-$ts'"'"` -> `cp: cannot create regular file '/storage/clouddrive2/Config/systemsettings.json.bak-<hex>-<n>': Permission denied`

## Watchlist

- `nonzero_exit`: 2577 hit(s), latest signal `Process exited with code <n>`
