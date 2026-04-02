#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
from collections import Counter, defaultdict
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

SUGGESTIONS = {
    "tool_runtime_failure": {
        "guardrail": "Separate agent-tool misuse from repository bugs. Fix session lifecycle, TTY, stdin, or agent-limit issues before editing product code.",
        "target": "task templates, runtime docs, operator checklists",
        "validation": "Re-run the same tool step and confirm the runtime failure marker is gone before continuing.",
    },
    "shell_quoting": {
        "guardrail": "Rewrite regex-heavy, JSON-heavy, or multi-quote shell commands into here-docs, smaller steps, or checked-in scripts before retrying.",
        "target": "`AGENTS.md` shell safety section, reusable repo scripts",
        "validation": "Re-run the rewritten command and confirm a clean exit code with no shell parser errors.",
    },
    "missing_command": {
        "guardrail": "Probe tool availability with `command -v` before use, then either install the tool or pick a supported fallback.",
        "target": "bootstrap scripts, task templates, preflight checks",
        "validation": "Confirm the binary exists before invoking the main workflow.",
    },
    "permission_denied": {
        "guardrail": "Scope scans away from protected directories, or redirect expected permission noise so exit codes are interpreted correctly.",
        "target": "search commands, repo helper scripts, troubleshooting docs",
        "validation": "Re-run the narrowed command and verify that permission noise no longer masks the real result.",
    },
    "git_or_network": {
        "guardrail": "Separate auth, DNS, SSL, and connectivity failures before retrying. Only re-run once the root transport issue is explicit.",
        "target": "network troubleshooting notes, git workflows, bootstrap docs",
        "validation": "Repeat the same remote operation only after the transport precondition is fixed.",
    },
    "python_traceback": {
        "guardrail": "Treat inline Python as production code: add input type guards, simplify the snippet, or move repeated logic into a checked script.",
        "target": "repo scripts, shell safety notes, reusable utilities",
        "validation": "Re-run the exact Python entrypoint and confirm the traceback is gone.",
    },
    "test_or_build_failure": {
        "guardrail": "Capture the failing assertion or compiler error first, then reproduce with the narrowest deterministic validation before editing code.",
        "target": "task templates, debugging workflow, review checklist",
        "validation": "Run the narrow failing command, fix it, then re-run the full validation command.",
    },
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Promote recurring harvested failures into shared guardrail suggestions."
    )
    parser.add_argument("--input", required=True, help="Input JSONL from harvest_codex_failures.py")
    parser.add_argument("--output-md", required=True, help="Markdown output path")
    parser.add_argument(
        "--min-hits",
        type=int,
        default=2,
        help="Minimum actionable hits before a category is suggested as a reusable learning.",
    )
    return parser.parse_args()


def load_rows(path: Path) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    with path.open("r", encoding="utf-8") as handle:
        for line in handle:
            line = line.strip()
            if not line:
                continue
            rows.append(json.loads(line))
    return rows


def main() -> int:
    args = parse_args()
    input_path = Path(args.input).expanduser()
    output_path = Path(args.output_md).expanduser()
    rows = load_rows(input_path)

    category_counts = Counter(row["category"] for row in rows)
    category_rows: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for row in rows:
        category_rows[row["category"]].append(row)

    promoted: list[str] = []
    watchlist: list[str] = []

    lines = [
        "# Distilled Codex Learnings",
        "",
        f"- Generated at: {datetime.now(timezone.utc).isoformat()}",
        f"- Source: `{input_path}`",
        f"- Promotion threshold: {args.min_hits} actionable hits per category",
        "",
        "This file is generated from harvested session failures. It suggests reusable guardrails, but it does not auto-edit persistent instructions.",
        "",
        "## Promotion policy",
        "",
        "- Promote only patterns that recur and have a concrete prevention step.",
        "- Keep category-level guardrails broad enough to reuse across repositories.",
        "- Leave one-off environment issues in summaries until they repeat.",
        "",
        "## Reusable learnings",
        "",
    ]

    for category, count in sorted(category_counts.items(), key=lambda item: (-item[1], item[0])):
        suggestion = SUGGESTIONS.get(category)
        if suggestion and count >= args.min_hits:
            promoted.append(category)
            examples = category_rows[category][:3]
            top_signals = Counter(
                example["evidence"][0] if example["evidence"] else "no evidence captured"
                for example in category_rows[category]
            )
            lines.extend(
                [
                    f"### `{category}`",
                    f"- Hits: {count}",
                    f"- Guardrail: {suggestion['guardrail']}",
                    f"- Best promotion target: {suggestion['target']}",
                    f"- Validation loop: {suggestion['validation']}",
                    "- Common signals:",
                ]
            )
            for signal, signal_count in top_signals.most_common(3):
                lines.append(f"  - `{signal}` x{signal_count}")
            lines.append("- Recent examples:")
            for example in examples:
                evidence = example["evidence"][0] if example["evidence"] else "no evidence captured"
                lines.append(
                    f"  - `{example['timestamp']}` via `{example['command'] or 'unknown command'}` -> `{evidence}`"
                )
            lines.append("")
        else:
            watchlist.append(category)

    if not promoted:
        lines.extend(
            [
                "No category crossed the current promotion threshold.",
                "",
            ]
        )

    lines.extend(["## Watchlist", ""])
    if watchlist:
        for category in sorted(watchlist):
            sample = category_rows[category][0]
            evidence = sample["evidence"][0] if sample["evidence"] else "no evidence captured"
            lines.append(
                f"- `{category}`: {category_counts[category]} hit(s), latest signal `{evidence}`"
            )
    else:
        lines.append("- None.")

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
