#!/bin/sh
set -eu

REPO_ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
CODEX_HOME="${HOME}/.codex"
AGENTS_HOME="${HOME}/.agents"
CODEX_RUNTIME_HOME="${CODEX_RUNTIME_HOME:-$HOME/.cache/codex-runtimes/codex-primary-runtime}"

find_python() {
  if [ "${PYTHON:-}" ]; then
    printf '%s\n' "$PYTHON"
    return 0
  fi

  for candidate in \
    "$HOME/AppData/Local/Python/bin/python3" \
    "$HOME/AppData/Local/Python/bin/python" \
    "$HOME/AppData/Local/Programs/Python/Python312/python.exe" \
    python3 \
    python
  do
    if command -v "$candidate" >/dev/null 2>&1 && "$candidate" - <<'PY' >/dev/null 2>&1
print("ok")
PY
    then
      printf '%s\n' "$candidate"
      return 0
    fi
  done

  echo "missing usable Python interpreter" >&2
  exit 1
}

PYTHON_BIN="$(find_python)"
GENERATOR="$CODEX_HOME/scripts/generate_codex_skills_mcp_inventory.py"
SOURCE_DOC="$CODEX_HOME/docs/skills-mcp-inventory.md"
SOURCE_RUNTIME_JSON="$CODEX_RUNTIME_HOME/runtime.json"
TARGET_CODEX_DOC="$REPO_ROOT/codex/docs/skills-mcp-inventory.md"
TARGET_RUNTIME_JSON="$REPO_ROOT/codex/docs/codex-primary-runtime.json"
TARGET_AGENTS="$REPO_ROOT/codex/AGENTS.md"
short_hostname() {
  hostname -s 2>/dev/null || hostname
}

MACHINE_NAME="${1:-$(short_hostname)}"
TARGET_DIR="$REPO_ROOT/inventories/$MACHINE_NAME"
TARGET_DOC="$TARGET_DIR/skills-mcp-inventory.md"
TARGET_META="$TARGET_DIR/metadata.txt"
TARGET_CONFIG="$REPO_ROOT/codex/mcp/config.toml"
TARGET_CODEX_AGENTS="$REPO_ROOT/codex/agents/local"
TARGET_LOCAL_SKILLS="$REPO_ROOT/codex/skills/local"
TARGET_AGENT_HOME_SKILLS="$REPO_ROOT/codex/skills/agents-home"
TARGET_SYMLINKS="$REPO_ROOT/codex/skills/local-symlinks.json"
GENERATED_DOC_AVAILABLE=0
RUNTIME_JSON_AVAILABLE=0

mirror_tree() {
  src="$1"
  dst="$2"
  if [ ! -d "$src" ]; then
    return 0
  fi

  SRC="$src" DST="$dst" "$PYTHON_BIN" - <<'PY'
from pathlib import Path
import os
import shutil

src = Path(os.environ["SRC"]).expanduser()
dst = Path(os.environ["DST"]).expanduser()

excluded_names = {".DS_Store", "__pycache__", ".git"}
excluded_suffixes = {".pyc"}


def ignore_names(_directory: str, names: list[str]) -> set[str]:
    ignored: set[str] = set()
    for name in names:
        if name in excluded_names or any(name.endswith(suffix) for suffix in excluded_suffixes):
            ignored.add(name)
    return ignored


if dst.exists():
    shutil.rmtree(dst)
dst.parent.mkdir(parents=True, exist_ok=True)
shutil.copytree(src, dst, ignore=ignore_names, symlinks=True)
PY
}

write_fallback_inventory() {
  doc_path="$1"
  DOC_PATH="$doc_path" MACHINE_NAME="$MACHINE_NAME" REPO_ROOT="$REPO_ROOT" "$PYTHON_BIN" - <<'PY'
from pathlib import Path
from datetime import date
import json
import os
import tomllib

repo = Path(os.environ["REPO_ROOT"])
doc_path = Path(os.environ["DOC_PATH"])
machine_name = os.environ["MACHINE_NAME"]


def count_dirs(relative_path: str) -> int:
    path = repo / relative_path
    if not path.exists():
        return 0
    return sum(1 for child in path.iterdir() if child.is_dir())


def load_json(relative_path: str):
    path = repo / relative_path
    if not path.exists():
        return {}
    return json.loads(path.read_text(encoding="utf-8"))


def load_toml(relative_path: str):
    path = repo / relative_path
    if not path.exists():
        return {}
    return tomllib.loads(path.read_text(encoding="utf-8"))


runtime = load_json("codex/docs/codex-primary-runtime.json")
config = load_toml("codex/mcp/config.toml")
symlinks = load_json("codex/skills/local-symlinks.json")

mcp_servers = sorted(config.get("mcp_servers", {}).keys())
plugins = sorted(config.get("plugins", {}).keys())

lines = [
    "# Codex Skills and MCP Inventory",
    "",
    "> Checked-in snapshot summary for the current canonical Windows runtime.",
    "",
    "## Snapshot",
    "",
    f"- Snapshot date: `{date.today().isoformat()}`",
    f"- Host: `{machine_name}`",
    "- OS: `Windows`",
    "- Runtime focus: canonical sync snapshot stored directly under `codex/`",
    f"- Codex primary runtime bundle version: `{runtime.get('bundleVersion', 'unavailable')}`",
    f"- Local Codex skill directories tracked in `codex/skills/local/`: `{count_dirs('codex/skills/local')}`",
    f"- Agent-home skill directories tracked in `codex/skills/agents-home/`: `{count_dirs('codex/skills/agents-home')}`",
    f"- Codex subagent definition groups tracked in `codex/agents/local/`: `{count_dirs('codex/agents/local')}`",
    f"- Project-specific DS3-Tool skill directories tracked in `codex/skills/projects/ds3-tool/`: `{count_dirs('codex/skills/projects/ds3-tool')}`",
    f"- Top-level skill symlinks tracked in `codex/skills/local-symlinks.json`: `{len(symlinks) if isinstance(symlinks, list) else 0}`",
    "",
    "## Canonical MCP Config",
    "",
    "Configured MCP servers in `codex/mcp/config.toml`:",
    "",
]

if mcp_servers:
    lines.extend(f"- `{name}`" for name in mcp_servers)
else:
    lines.append("- none detected")

lines.extend([
    "",
    "Enabled Codex plugins in `codex/mcp/config.toml`:",
    "",
])

if plugins:
    lines.extend(f"- `{name}`" for name in plugins)
else:
    lines.append("- none detected")

lines.extend([
    "",
    "## Tracked MCP Repositories",
    "",
    "- `ghidra-mcp`: stored in `codex/mcp/repos/ghidra-mcp/`",
    "- `x64dbg-mcp`: stored in `codex/mcp/repos/x64dbg-mcp/`",
    "",
    "## Runtime Additions",
    "",
    "- `codex/skills/local/` includes the current machine's Codex skills, including the installed `gstack-*` skills.",
    "- `codex/skills/agents-home/` includes cross-agent skills from `~/.agents/skills`, including Waza and Compound Engineering `ce-*` skills.",
    "- `codex/agents/local/` includes Compound Engineering subagent definitions from `~/.codex/agents`.",
    "- `codex/docs/codex-primary-runtime.json` records Codex primary runtime bundle metadata.",
    "",
    "## Project Skills",
    "",
    "DS3-Tool-specific skills are tracked in `codex/skills/projects/ds3-tool/` so they sync with the rest of the Codex runtime without pretending they are part of `~/.codex/skills`.",
    "",
    "## Notes",
    "",
    "- This file is a checked-in snapshot summary generated from local repo state when the Codex inventory generator is unavailable.",
    "- Codex native memories are the runtime memory layer; this repo no longer keeps a separate failure-learning or memory pipeline.",
    "- When a new machine becomes the canonical sync source, update this file together with `codex/AGENTS.md`, `codex/skills/local/`, `codex/skills/agents-home/`, `codex/agents/local/`, and `codex/mcp/`.",
    "",
])

doc_path.parent.mkdir(parents=True, exist_ok=True)
doc_path.write_text("\n".join(lines), encoding="utf-8", newline="\n")
PY
}

normalize_text_tree() {
  target="$1"
  if [ ! -e "$target" ]; then
    return 0
  fi

  TARGET="$target" "$PYTHON_BIN" - <<'PY'
from pathlib import Path
import os
import re

target = Path(os.environ["TARGET"])
paths = [target] if target.is_file() else [p for p in target.rglob("*") if p.is_file()]

for path in paths:
    data = path.read_bytes()
    if b"\0" in data or len(data) > 5 * 1024 * 1024:
        continue
    try:
        text = data.decode("utf-8")
    except UnicodeDecodeError:
        continue

    normalized = re.sub(r"[ \t]+(?=\r?\n)", "", text)
    normalized = re.sub(r"[ \t]+\Z", "", normalized)
    normalized = re.sub(r"(\r?\n){2,}\Z", "\n", normalized)
    if not re.search(r"\r?\n\Z", normalized):
        normalized += "\n"

    if normalized != text:
        path.write_text(normalized, encoding="utf-8", newline="\n")
PY
}

if [ -f "$GENERATOR" ]; then
  "$PYTHON_BIN" "$GENERATOR" >/dev/null || true
fi

if [ -f "$SOURCE_DOC" ]; then
  GENERATED_DOC_AVAILABLE=1
fi

if [ -f "$SOURCE_RUNTIME_JSON" ]; then
  RUNTIME_JSON_AVAILABLE=1
fi

mkdir -p \
  "$REPO_ROOT/codex/docs" \
  "$TARGET_DIR" \
  "$TARGET_LOCAL_SKILLS" \
  "$TARGET_CODEX_AGENTS" \
  "$TARGET_AGENT_HOME_SKILLS"
cp "$CODEX_HOME/AGENTS.md" "$TARGET_AGENTS"
cp "$CODEX_HOME/config.toml" "$TARGET_CONFIG"

if [ "$GENERATED_DOC_AVAILABLE" -eq 1 ]; then
  cp "$SOURCE_DOC" "$TARGET_CODEX_DOC"
  cp "$SOURCE_DOC" "$TARGET_DOC"
fi

if [ "$RUNTIME_JSON_AVAILABLE" -eq 1 ]; then
  cp "$SOURCE_RUNTIME_JSON" "$TARGET_RUNTIME_JSON"
fi

"$PYTHON_BIN" - <<'PY' > "$TARGET_SYMLINKS"
from pathlib import Path
import json
root = Path.home() / ".codex" / "skills"
items = []
if root.exists():
    for p in sorted(root.iterdir()):
        if p.is_symlink():
            items.append({
                "name": p.name,
                "target": str(p.resolve()),
            })
print(json.dumps(items, ensure_ascii=False, indent=2))
PY

mirror_tree "$CODEX_HOME/skills" "$TARGET_LOCAL_SKILLS"
mirror_tree "$CODEX_HOME/agents" "$TARGET_CODEX_AGENTS"
mirror_tree "$AGENTS_HOME/skills" "$TARGET_AGENT_HOME_SKILLS"

find "$TARGET_LOCAL_SKILLS" -maxdepth 1 -type l -delete 2>/dev/null || true
find "$TARGET_LOCAL_SKILLS" -maxdepth 1 -type d -name '*.bak-*' -prune -exec rm -rf {} +
rm -rf "$TARGET_LOCAL_SKILLS/gstack"
find "$TARGET_AGENT_HOME_SKILLS" -maxdepth 1 -type d -name '*.bak-*' -prune -exec rm -rf {} +

if [ "$GENERATED_DOC_AVAILABLE" -eq 0 ]; then
  write_fallback_inventory "$TARGET_CODEX_DOC"
  write_fallback_inventory "$TARGET_DOC"
fi

{
  echo "machine=$MACHINE_NAME"
  echo "generated_at=$(date '+%Y-%m-%d %H:%M:%S %Z')"
  echo "hostname=$(short_hostname)"
  echo "os=$(uname -s)"
  echo "arch=$(uname -m)"
  if [ "$GENERATED_DOC_AVAILABLE" -eq 1 ]; then
    echo "codex_inventory_source=$SOURCE_DOC"
  else
    echo "codex_inventory_source=unavailable"
  fi
  if [ "$RUNTIME_JSON_AVAILABLE" -eq 1 ]; then
    echo "codex_primary_runtime_json=$SOURCE_RUNTIME_JSON"
  else
    echo "codex_primary_runtime_json=unavailable"
  fi
  if [ -d "$CODEX_HOME/agents" ]; then
    echo "codex_agents_source=$CODEX_HOME/agents"
  else
    echo "codex_agents_source=unavailable"
  fi
  if [ -d "$AGENTS_HOME/skills" ]; then
    echo "agent_home_skills_source=$AGENTS_HOME/skills"
  else
    echo "agent_home_skills_source=unavailable"
  fi
} > "$TARGET_META"

normalize_text_tree "$TARGET_AGENTS"
normalize_text_tree "$TARGET_CONFIG"
normalize_text_tree "$TARGET_LOCAL_SKILLS"
normalize_text_tree "$TARGET_CODEX_AGENTS"
normalize_text_tree "$TARGET_AGENT_HOME_SKILLS"
normalize_text_tree "$TARGET_SYMLINKS"
normalize_text_tree "$TARGET_CODEX_DOC"
normalize_text_tree "$TARGET_DOC"
normalize_text_tree "$TARGET_META"
if [ "$RUNTIME_JSON_AVAILABLE" -eq 1 ]; then
  normalize_text_tree "$TARGET_RUNTIME_JSON"
fi

echo "synced:"
echo "  $TARGET_AGENTS"
echo "  $TARGET_CONFIG"
if [ "$RUNTIME_JSON_AVAILABLE" -eq 1 ]; then
  echo "  $TARGET_RUNTIME_JSON"
fi
if [ "$GENERATED_DOC_AVAILABLE" -eq 1 ]; then
  echo "  $TARGET_CODEX_DOC"
  echo "  $TARGET_DOC"
else
  echo "  inventory generator unavailable; wrote fallback skills/MCP inventory docs"
  echo "  $TARGET_CODEX_DOC"
  echo "  $TARGET_DOC"
fi
echo "  $TARGET_LOCAL_SKILLS"
echo "  $TARGET_CODEX_AGENTS"
echo "  $TARGET_AGENT_HOME_SKILLS"
echo "  $TARGET_META"
