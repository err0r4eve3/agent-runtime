# Global Codex Instructions

This file is a Codex adaptation of the user's Cursor rules.
Primary rule sources are stored under `C:\Users\Daniel\.codex\cursor-rules\`.

## Core Interaction

- Use Simplified Chinese for user-facing replies unless the user explicitly requests another language. Keep technical terms in English when that is clearer.
- Keep replies concise and high-signal. Avoid filler, unnecessary preambles, and repeated framing.
- Before editing, understand the existing logic, dependencies, and exact requested scope.
- Make minimal targeted changes. Do not alter unrelated behavior unless the user asks for it.
- Prefer existing project utilities, components, conventions, and patterns over introducing new abstractions.

## Code And Style

- Match the existing project's naming, formatting, indentation, comment style, and overall architecture.
- Prefer reuse over duplicate implementations.
- Add comments only where the logic is non-obvious.
- Handle edge cases and errors explicitly.

## Working Method

- Inspect local context first. Do not answer from assumptions when the codebase can resolve the question.
- When information might be stale or external, verify it with the appropriate tool or source.
- If requirements remain ambiguous after inspection, ask focused clarifying questions about scope, business rules, error handling, and performance.
- For greenfield work or major design work, align in this order when relevant: requirements, UI/UX, architecture, implementation.
- Do not skip validation when a change can be tested locally.

## Tool Choice

- Prefer Codex built-in tools and repo-aware search or edit capabilities when available.
- Use shell for environment checks, build or test commands, toolchain operations, or when built-in tools are insufficient.
- Treat potentially destructive actions as confirmation-required unless the user explicitly requested them.

## Tech Defaults For New Work

- Existing project: follow the project's current stack.
- New Python helper or tooling work: Python 3.10+, `uv`, PEP 8 / Google Python Style Guide.
- New frontend work: TypeScript 5.x, Next.js App Router, `pnpm`, Tailwind CSS, ESLint, and Prettier.
- New desktop UI tooling: Dear ImGui with C++ or Python bindings when appropriate.

## Reference Rule Packs

- Additional migrated Cursor rules live under `C:\Users\Daniel\.codex\cursor-rules\`.
- Treat `.cursorrules`, `cursor.md`, and `rules\base\*.mdc` as the primary global baseline.
- When the task clearly involves a specific language, framework, document type, or git workflow, consult the matching migrated rule file under:
  - `C:\Users\Daniel\.codex\cursor-rules\rules\languages\`
  - `C:\Users\Daniel\.codex\cursor-rules\rules\frameworks\`
  - `C:\Users\Daniel\.codex\cursor-rules\rules\other\`
