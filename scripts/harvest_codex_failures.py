#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import re
import shlex
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

EXIT_CODE_RE = re.compile(r"Process exited with code (\d+)")
RUNNING_SESSION_RE = re.compile(r"Process running with session ID (\d+)")
COMMAND_RE = re.compile(r"^Command: (.*)$", re.MULTILINE)
URL_RE = re.compile(r"https?://\S+")
HOME_PATH_RE = re.compile(r"/Users/[^/\s]+")
LONG_HEX_RE = re.compile(r"\b[0-9a-f]{8,}\b", re.IGNORECASE)
NUMBER_RE = re.compile(r"\b\d+\b")

SEARCH_LIKE_COMMANDS = {"rg", "grep", "fd", "find"}
TOOL_FAILURE_MARKERS = (
    "write_stdin failed:",
    "collab spawn failed:",
    "apply_patch failed:",
    "tool call failed:",
)
KNOWN_ERROR_MARKERS = (
    "traceback (most recent call last):",
    "command not found",
    "permission denied",
    "operation not permitted",
    "fatal:",
    "parse error",
    "syntax error",
    "unexpected eof",
    "bad substitution",
    "assertionerror",
    "npm err!",
    "error:",
    "failed",
    "exception:",
)
METADATA_PREFIXES = (
    "Command:",
    "Chunk ID:",
    "Wall time:",
    "Original token count:",
    "Output:",
    "Total output lines:",
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Harvest actionable failure records from local Codex session logs."
    )
    parser.add_argument(
        "--sessions-root",
        default=str(Path.home() / ".codex" / "sessions"),
        help="Root directory containing Codex session JSONL files.",
    )
    parser.add_argument(
        "--output-jsonl",
        required=True,
        help="Path for harvested failure records.",
    )
    parser.add_argument(
        "--summary-md",
        help="Optional markdown summary path.",
    )
    return parser.parse_args()


def ensure_text(value: Any) -> str:
    if value is None:
        return ""
    if isinstance(value, str):
        return value
    return json.dumps(value, ensure_ascii=False)


def parse_json(value: str | None) -> dict[str, Any]:
    if not value:
        return {}
    try:
        parsed = json.loads(value)
    except json.JSONDecodeError:
        return {}
    return parsed if isinstance(parsed, dict) else {}


def extract_command(output_text: str) -> str:
    match = COMMAND_RE.search(output_text)
    return match.group(1).strip() if match else ""


def extract_exit_code(output_text: str) -> int | None:
    match = EXIT_CODE_RE.search(output_text)
    return int(match.group(1)) if match else None


def extract_running_session_id(output_text: str) -> str | None:
    match = RUNNING_SESSION_RE.search(output_text)
    return match.group(1) if match else None


def sanitize_text(text: str) -> str:
    sanitized = text
    sanitized = URL_RE.sub("<url>", sanitized)
    sanitized = HOME_PATH_RE.sub("~/...", sanitized)
    sanitized = LONG_HEX_RE.sub("<hex>", sanitized)
    sanitized = NUMBER_RE.sub("<n>", sanitized)
    sanitized = " ".join(sanitized.split())
    return sanitized


def command_name(command: str) -> str:
    if not command:
        return ""
    try:
        words = shlex.split(command)
    except ValueError:
        words = command.split()
    if not words:
        return ""
    return Path(words[0]).name


def evidence_lines(output_text: str) -> list[str]:
    raw_lines = [line.strip() for line in output_text.splitlines()]
    specific: list[str] = []
    generic_exit: list[str] = []
    fallback: list[str] = []
    for line in raw_lines:
        if not line:
            continue
        if line.startswith(METADATA_PREFIXES):
            continue
        fallback.append(line)
        lowered = line.lower()
        if lowered.startswith("process exited with code"):
            generic_exit.append(line)
            continue
        if any(marker in lowered for marker in TOOL_FAILURE_MARKERS):
            specific.append(line)
            continue
        if any(marker in lowered for marker in KNOWN_ERROR_MARKERS):
            specific.append(line)
    chosen = specific[:3]
    if generic_exit:
        chosen.append(generic_exit[0])
    if not chosen:
        chosen = fallback[:4]
    return [sanitize_text(line) for line in chosen[:4]]


def is_probably_benign_nonzero(command: str, output_text: str, exit_code: int | None) -> bool:
    if exit_code != 1:
        return False
    lowered = output_text.lower()
    if any(
        marker in lowered
        for marker in (
            "traceback (most recent call last):",
            "command not found",
            "permission denied",
            "operation not permitted",
            "fatal:",
            "syntax error",
            "parse error",
            "unexpected eof",
            "bad substitution",
        )
    ):
        return False

    name = command_name(command)
    if name in SEARCH_LIKE_COMMANDS:
        return True
    if "| rg " in command or "| grep " in command:
        return True
    if "git diff --quiet" in command or "git diff --exit-code" in command:
        return True
    if name in {"test", "["}:
        return True
    return False


def is_actionable_failure(command: str, output_text: str, exit_code: int | None) -> bool:
    lowered = output_text.lower()
    if any(marker in lowered for marker in TOOL_FAILURE_MARKERS):
        return True
    if "traceback (most recent call last):" in lowered and exit_code not in (None, 0):
        return True
    if exit_code is None or exit_code == 0:
        return False
    return not is_probably_benign_nonzero(command, output_text, exit_code)


def classify_failure(command: str, output_text: str, exit_code: int | None) -> str:
    lowered = output_text.lower()
    name = command_name(command)
    if any(marker in lowered for marker in TOOL_FAILURE_MARKERS):
        return "tool_runtime_failure"
    if any(
        marker in lowered
        for marker in (
            "parse error",
            "syntax error",
            "unexpected eof",
            "bad substitution",
            "unmatched",
        )
    ):
        return "shell_quoting"
    if "command not found" in lowered:
        return "missing_command"
    if any(
        marker in lowered
        for marker in (
            "permission denied",
            "operation not permitted",
            "eacces",
            "eperm",
        )
    ):
        return "permission_denied"
    if any(
        marker in lowered
        for marker in (
            "fatal:",
            "could not resolve host",
            "ssl",
            "connection refused",
            "timed out",
            "remote end hung up",
        )
    ):
        return "git_or_network"
    if "traceback (most recent call last):" in lowered:
        return "python_traceback"
    if name in {"python", "python3"} and exit_code == 127:
        return "missing_command"
    if name == "curl" and exit_code in {5, 6, 7, 28, 35, 52, 56}:
        return "git_or_network"
    if (
        name in {"pytest", "ruff", "mypy", "npm", "pnpm", "yarn", "uv", "go", "cargo"}
        or " pytest" in command
        or "ruff check" in command
        or "npm test" in command
        or "pnpm test" in command
        or "yarn test" in command
    ) and exit_code not in (None, 0):
        return "test_or_build_failure"
    if any(
        marker in lowered
        for marker in (
            "assertionerror",
            "failed",
            "error:",
            "module not found",
            "modulenotfounderror",
            "referenceerror",
            "typeerror",
            "syntaxerror",
        )
    ):
        return "test_or_build_failure"
    if exit_code not in (None, 0):
        return "nonzero_exit"
    return "unknown"


def fingerprint(category: str, evidence: list[str]) -> str:
    seed = evidence[0] if evidence else category
    return f"{category}:{sanitize_text(seed).lower()}"


def write_jsonl(path: Path, rows: list[dict[str, Any]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as handle:
        for row in rows:
            handle.write(json.dumps(row, ensure_ascii=False) + "\n")


def write_summary(
    path: Path,
    *,
    sessions_scanned: int,
    tool_outputs_scanned: int,
    ignored_benign_nonzero: int,
    rows: list[dict[str, Any]],
) -> None:
    category_counts = Counter(row["category"] for row in rows)
    fingerprint_counts = Counter(row["fingerprint"] for row in rows)
    first_seen = min((row["timestamp"] for row in rows), default=None)
    last_seen = max((row["timestamp"] for row in rows), default=None)

    lines = [
        "# Codex Learning Summary",
        "",
        f"- Generated at: {datetime.now(timezone.utc).isoformat()}",
        f"- Sessions scanned: {sessions_scanned}",
        f"- Tool outputs scanned: {tool_outputs_scanned}",
        f"- Actionable failures: {len(rows)}",
        f"- Ignored probable benign non-zero exits: {ignored_benign_nonzero}",
    ]
    if first_seen and last_seen:
        lines.extend(
            [
                f"- Failure window: {first_seen} -> {last_seen}",
            ]
        )
    lines.extend(["", "## Categories", "", "| Category | Hits |", "| --- | ---: |"])
    for category, count in sorted(category_counts.items(), key=lambda item: (-item[1], item[0])):
        lines.append(f"| `{category}` | {count} |")

    lines.extend(["", "## Recurring signals", ""])
    top_records_by_fp: dict[str, dict[str, Any]] = {}
    for row in rows:
        top_records_by_fp.setdefault(row["fingerprint"], row)
    for signature, count in fingerprint_counts.most_common(10):
        row = top_records_by_fp[signature]
        example = row["evidence"][0] if row["evidence"] else "no evidence line captured"
        lines.extend(
            [
                f"### `{row['category']}` x{count}",
                f"- Signal: `{example}`",
                f"- Command shape: `{row['command'] or 'unknown'}`",
                f"- Last seen: {row['timestamp']}",
                "",
            ]
        )

    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def main() -> int:
    args = parse_args()
    sessions_root = Path(args.sessions_root).expanduser()
    output_jsonl = Path(args.output_jsonl).expanduser()
    summary_md = Path(args.summary_md).expanduser() if args.summary_md else None

    if not sessions_root.exists():
        raise SystemExit(f"missing sessions root: {sessions_root}")

    rows: list[dict[str, Any]] = []
    sessions_scanned = 0
    tool_outputs_scanned = 0
    ignored_benign_nonzero = 0

    for session_file in sorted(sessions_root.rglob("*.jsonl")):
        sessions_scanned += 1
        call_map: dict[str, dict[str, Any]] = {}
        running_sessions: dict[str, str] = {}
        with session_file.open("r", encoding="utf-8", errors="replace") as handle:
            for line in handle:
                try:
                    obj = json.loads(line)
                except json.JSONDecodeError:
                    continue
                if obj.get("type") != "response_item":
                    continue

                payload = obj.get("payload", {})
                payload_type = payload.get("type")

                if payload_type == "function_call":
                    call_id = payload.get("call_id")
                    if not call_id:
                        continue
                    fn_name = payload.get("name", "")
                    arguments = parse_json(payload.get("arguments"))
                    call_map[call_id] = {
                        "name": fn_name,
                        "arguments": arguments,
                        "command": ensure_text(arguments.get("cmd")),
                        "session_id": ensure_text(arguments.get("session_id")),
                    }
                    continue

                if payload_type != "function_call_output":
                    continue

                tool_outputs_scanned += 1
                call_id = payload.get("call_id", "")
                meta = call_map.get(call_id, {})
                output_text = ensure_text(payload.get("output"))
                if not output_text:
                    continue

                command = meta.get("command") or extract_command(output_text)
                session_id = meta.get("session_id", "")
                running_session_id = extract_running_session_id(output_text)
                if running_session_id and command:
                    running_sessions[running_session_id] = command
                if not command and session_id:
                    command = running_sessions.get(session_id, "")

                exit_code = extract_exit_code(output_text)
                if not is_actionable_failure(command, output_text, exit_code):
                    if exit_code not in (None, 0):
                        ignored_benign_nonzero += 1
                    continue

                category = classify_failure(command, output_text, exit_code)
                evidence = evidence_lines(output_text)
                command_shape = sanitize_text(command) if command else ""
                row = {
                    "timestamp": obj.get("timestamp"),
                    "session_file": str(session_file.relative_to(sessions_root)),
                    "tool_name": meta.get("name") or "unknown",
                    "command": command_shape,
                    "exit_code": exit_code,
                    "category": category,
                    "fingerprint": fingerprint(category, evidence),
                    "evidence": evidence,
                }
                rows.append(row)

    write_jsonl(output_jsonl, rows)
    if summary_md:
        write_summary(
            summary_md,
            sessions_scanned=sessions_scanned,
            tool_outputs_scanned=tool_outputs_scanned,
            ignored_benign_nonzero=ignored_benign_nonzero,
            rows=rows,
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
