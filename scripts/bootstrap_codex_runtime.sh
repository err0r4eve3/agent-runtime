#!/bin/sh
set -eu

HOME_DIR="${HOME:-/Users/error4ever}"
LOCAL_PREFIX="$HOME_DIR/.local"
TOOLS_DIR="$LOCAL_PREFIX/share/free-agent-tools"
BIN_DIR="$LOCAL_PREFIX/bin"

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "missing required command: $1" >&2
    exit 1
  fi
}

need_cmd git
need_cmd npm
need_cmd uv
need_cmd python3
need_cmd curl

mkdir -p "$TOOLS_DIR" "$BIN_DIR"

install_opencli_rs() {
  platform="$(uname -s)"
  arch="$(uname -m)"

  case "$platform:$arch" in
    Darwin:arm64) asset="opencli-rs-aarch64-apple-darwin.tar.gz" ;;
    Darwin:x86_64) asset="opencli-rs-x86_64-apple-darwin.tar.gz" ;;
    Linux:x86_64) asset="opencli-rs-x86_64-unknown-linux-musl.tar.gz" ;;
    Linux:aarch64|Linux:arm64) asset="opencli-rs-aarch64-unknown-linux-musl.tar.gz" ;;
    *)
      echo "unsupported platform for opencli-rs: $platform $arch" >&2
      return 1
      ;;
  esac

  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir"' EXIT HUP INT TERM
  curl -fL -o "$tmpdir/opencli-rs.tar.gz" "https://github.com/nashsu/opencli-rs/releases/latest/download/$asset"
  tar -xzf "$tmpdir/opencli-rs.tar.gz" -C "$tmpdir"
  install -m 755 "$tmpdir/opencli-rs" "$BIN_DIR/opencli-rs"
  rm -rf "$tmpdir"
  trap - EXIT HUP INT TERM
}

echo "[1/6] install npm tools"
npm install -g --prefix "$LOCAL_PREFIX" \
  @jackwener/opencli \
  @executeautomation/playwright-mcp-server \
  ctx7 \
  @upstash/context7-mcp

echo "[2/6] install opencli-rs"
install_opencli_rs

echo "[3/6] install uv tools"
uv tool install --python python3.11 --from https://github.com/Panniantong/Agent-Reach/archive/main.zip agent-reach
uv tool install --python python3.11 "scrapling[fetchers]"

echo "[4/6] install browser runtime for scrapling"
"$BIN_DIR/scrapling" install || true

sync_repo() {
  name="$1"
  url="$2"
  path="$TOOLS_DIR/$name"
  if [ -d "$path/.git" ]; then
    git -C "$path" pull --ff-only
  else
    git clone "$url" "$path"
  fi
}

echo "[5/6] sync repository tools"
sync_repo grok-bridge https://github.com/ythx-101/grok-bridge.git
sync_repo web-access https://github.com/eze-is/web-access.git
sync_repo opencli-source https://github.com/jackwener/opencli.git
sync_repo opencli-rs https://github.com/nashsu/opencli-rs.git

echo "[6/6] refresh local wrapper commands"
cat > "$BIN_DIR/grok-bridge-start" <<'EOF'
#!/bin/sh
exec python3 "$HOME/.local/share/free-agent-tools/grok-bridge/scripts/grok_bridge.py" "$@"
EOF

cat > "$BIN_DIR/grok-chat" <<'EOF'
#!/bin/sh
exec /bin/bash "$HOME/.local/share/free-agent-tools/grok-bridge/scripts/grok_chat.sh" "$@"
EOF

chmod +x "$BIN_DIR/grok-bridge-start" "$BIN_DIR/grok-chat"

echo "bootstrap complete"
echo "next:"
echo "  python3 ~/.codex/scripts/generate_codex_skills_mcp_inventory.py"
echo "  bash scripts/sync_codex_runtime.sh"
