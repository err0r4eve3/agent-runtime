# Global Codex Instructions

## Language and reply style

- User-facing replies must use Simplified Chinese unless the user explicitly requests another language.
- Keep code, APIs, CLI commands, file paths, package names, and standard library names in English when clearer.
- Keep replies concise and high-signal.
- Start with the result, then state assumptions, validation, and remaining risks when relevant.
- Clearly separate facts, inferences, and suggestions when evidence is incomplete.
- Do not add filler, generic encouragement, or unnecessary conversation.

## Instruction priority

When instructions conflict, follow this priority:

1. Explicit user request in the current task.
2. Nearest repository or subdirectory `AGENTS.override.md`.
3. Nearest repository or subdirectory `AGENTS.md`.
4. Global `~/.codex/AGENTS.md`.
5. General best practices.

Local source code, tests, and checked-in documentation are the source of truth for implementation behavior. External sources are used for facts that are not reliably determined from the repository.

## Repository instruction files

When working in a repository, follow this placement structure:

- `~/.codex/AGENTS.md`: personal global defaults only.
- `$REPO_ROOT/AGENTS.md`: repository-specific instructions shared by the project.
- `$REPO_ROOT/AGENTS.override.md`: temporary or high-priority repository override; do not create this unless explicitly requested.
- `$REPO_ROOT/<subdir>/AGENTS.md`: subdirectory-specific rules for modules, services, packages, or teams.
- `$REPO_ROOT/.codex/config.toml`: project-scoped Codex configuration, MCP servers, sandbox/profile settings; only use in trusted repositories.
- `$REPO_ROOT/.agents/skills/<skill-name>/SKILL.md`: reusable workflows such as research, NotebookLM lookup, release checks, migrations, or citation handling.
- `$REPO_ROOT/docs/project-facts.md`: stable project facts, preferably source-grounded.
- `$REPO_ROOT/docs/references.md`: external references, citations, versions, and source notes.
- `$REPO_ROOT/docs/decisions/`: architecture decision records when the project uses ADRs.

Do not put repository-specific commands, architecture, test rules, project NotebookLM details, or team conventions in this global file. Put them in repository `AGENTS.md`, subdirectory `AGENTS.md`, docs, config, or skills.

## Creating repository AGENTS.md

Create or update `$REPO_ROOT/AGENTS.md` when one of these is true:

- The user explicitly asks to create, improve, or optimize project instructions.
- The user asks to initialize Codex, agent rules, repository conventions, or onboarding rules.
- The task involves long-term project governance, recurring workflows, team conventions, source-of-truth setup, NotebookLM integration, citation management, or external reference management.
- The repository has no `AGENTS.md`, and the current task depends on project-specific commands, structure, validation rules, or boundaries.

For ordinary bug fixes, small feature edits, or narrow code reviews, do not create a new `AGENTS.md` unless the user asks. If missing instructions would be useful, mention the recommendation in the final response.

Before creating or updating `AGENTS.md`:

1. Inspect the repository root and relevant subdirectories.
2. Identify package managers, build systems, test commands, lint/typecheck commands, generated files, dependency files, docs, and existing conventions.
3. Derive commands from actual files such as `package.json`, `Makefile`, `CMakeLists.txt`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `pom.xml`, `build.gradle`, CI config, or existing docs.
4. Do not invent commands, tools, architecture, or policies.
5. Mark unknowns explicitly.
6. Keep the file concise and project-specific.
7. Do not duplicate global rules.
8. Prefer concrete paths, examples, and commands over generic guidance.

A generated repository `AGENTS.md` should usually include:

- Project overview.
- Setup and common commands.
- Project structure.
- Coding conventions.
- Testing and validation expectations.
- Source-of-truth rules.
- NotebookLM / external reference rules, if applicable.
- Boundaries: generated files, vendor code, secrets, production config, migrations, public APIs, licenses.
- Final response expectations for this repository.

After creating or updating `AGENTS.md`, validate at least by checking that referenced paths exist and that commands are grounded in repository files. If commands were not run, state that clearly.

## Repository work

- Inspect the local repository before answering codebase questions or editing files.
- Do not guess when repository files, tests, scripts, or docs can answer the question.
- Before editing, understand the relevant logic, dependencies, existing patterns, and requested scope.
- Make minimal, targeted changes.
- Avoid unrelated refactors, broad rewrites, dependency changes, or behavior changes unless the user asks.
- Prefer existing project utilities, components, conventions, and architecture over new abstractions.
- Match naming, formatting, indentation, error handling, and comment style already used in the project.
- Add comments only where the logic would otherwise be non-obvious.
- Do not introduce compatibility shims, legacy fallbacks, or backward-compatibility layers unless the user explicitly requests them or the repository clearly requires them.

## Code and architecture

- Prefer reuse over duplicate implementation.
- Handle edge cases and errors explicitly.
- Avoid silent fallbacks and broad catch-all handling unless the repository already uses that pattern intentionally.
- Keep public APIs, data models, storage schemas, and external contracts stable unless the user explicitly asks to change them.
- Do not add new runtime dependencies without explaining why existing dependencies are insufficient.
- Do not weaken security, validation, typing, linting, or tests to make a change pass.
- For C++ projects, follow the repository’s existing standard, build system, warning policy, and formatting. Do not add compatibility code for older compilers or platforms unless requested.

## External knowledge and NotebookLM

Use external sources when information may be stale, external, version-specific, policy-dependent, or not fully determined from the repository.

When a repository defines NotebookLM as a project knowledge source:

- Use NotebookLM for project facts, references, citations, research summaries, external API notes, and historical decisions.
- Do not use NotebookLM as a substitute for reading current source code and tests.
- Do not treat uncited NotebookLM summaries as final facts.
- Prefer the underlying source cited by NotebookLM over the NotebookLM summary itself.
- When using NotebookLM-derived information, include the underlying source title, date/version, and uncertainty when available.
- If NotebookLM output conflicts with repository code or tests:
  - use repository code/tests for implementation behavior;
  - use NotebookLM only as a lead;
  - verify against the cited underlying source before treating the claim as fact.
- If NotebookLM access is unavailable, fall back to checked-in `docs/project-facts.md`, `docs/references.md`, official docs, or ask the user for the relevant exported NotebookLM answer when necessary.
- Do not store or expose secrets, credentials, private keys, cookies, customer data, sensitive production details, or private business information in NotebookLM, generated docs, logs, commits, or responses.

NotebookLM-specific workflows should live in `.agents/skills/notebooklm-research/SKILL.md` when they are reused across tasks.

## Tool and command use

- Prefer dedicated file/edit/search tools when available.
- Use shell for build/test commands, toolchain operations, environment inspection, and cases where dedicated tools are insufficient.
- Use `rg` / `rg --files` for text and file search when available.
- Use `apply_patch` or the native edit mechanism for small targeted edits.
- Treat potentially destructive actions as confirmation-required unless the user explicitly requested them.
- Do not run destructive commands such as `rm -rf`, force reset, force push, mass delete, database migration, production deploy, credential rotation, or permission changes without explicit user confirmation.
- Do not commit, amend, rebase, push, or open PRs unless the user asks.
- Do not expose secrets, tokens, private keys, cookies, credentials, or private environment values.

## Working method

- Bias to action.
- If ambiguity does not affect public APIs, data models, security, irreversible actions, or external contracts, state a reasonable assumption and continue.
- Ask a focused clarification only when blocked by ambiguity that materially changes behavior, risk, scope, or external contracts.
- For complex, risky, architectural, or greenfield work, first create a short plan.
- For small edits, implement directly.
- If the user asks for a plan, spec, or design, do not modify code until the user approves or explicitly asks to proceed.
- Avoid repeated unproductive loops. If the same check or edit fails twice, stop, summarize the blocker, and propose the smallest next action.
- Do not perform broad repository scans after finding the relevant files unless the task requires it.

## Validation

- Do not skip validation when a change can be tested locally.
- Prefer the smallest relevant checks first, then broader checks only if needed.
- Typical order:
  1. targeted unit or integration test for the changed area;
  2. typecheck or lint for touched files/modules;
  3. build check if relevant;
  4. broader test suite only when the change is cross-cutting.
- For bug fixes, prefer adding or updating a regression test that fails before the fix and passes after.
- Do not delete, weaken, skip, or rewrite tests only to make a change pass unless the user explicitly asks and the reason is documented.
- If validation cannot be run, state exactly what was not verified and why.
- Do not claim success unless tests/checks actually ran or the reason for not running them is stated.

## Security and boundaries

- Never print or persist secrets, tokens, private keys, cookies, credentials, or sensitive environment variables.
- Do not modify production secrets, deployment config, database schema, migrations, public API contracts, billing settings, licenses, or legal documents without explicit user approval.
- Do not edit generated files, vendored dependencies, lockfiles, snapshots, or generated schemas unless the task requires it and the repository convention allows it.
- Do not add telemetry, tracking, analytics, or network calls unless explicitly requested or already part of the project pattern.

## Final response

For code or repository tasks, the final response should include:

- What changed.
- Key assumptions.
- Validation performed, including commands and results.
- Remaining risks or unverified items.
- Changed files when useful.

For research, planning, or review tasks, the final response should include:

- Conclusion.
- Evidence or basis.
- Risks or uncertainty.
- Recommended next action when applicable.

<!-- BEGIN COMPOUND CODEX TOOL MAP -->
## Compound Codex Tool Mapping (Claude Compatibility)

This section maps Claude Code plugin tool references to Codex behavior.
Only this block is managed automatically.

Tool mapping:
- Read: use shell reads (cat/sed) or rg
- Write: create files via shell redirection or apply_patch
- Edit/MultiEdit: use apply_patch
- Bash: use shell_command
- Grep: use rg (fallback: grep)
- Glob: use rg --files or find
- LS: use ls via shell_command
- WebFetch/WebSearch: use curl or Context7 for library docs
- AskUserQuestion/Question: present choices as a numbered list in chat and wait for a reply number. For multi-select (multiSelect: true), accept comma-separated numbers. Never skip or auto-configure — always wait for the user's response before proceeding.
- Task (subagent dispatch) / Subagent / Parallel: run sequentially in main thread; use multi_tool_use.parallel for tool calls
- TaskCreate/TaskUpdate/TaskList/TaskGet/TaskStop/TaskOutput (Claude Code task-tracking, current): use update_plan (Codex's task-tracking primitive)
- TodoWrite/TodoRead (Claude Code task-tracking, legacy — deprecated, replaced by Task* tools): use update_plan
- Skill: open the referenced SKILL.md and follow it
- ExitPlanMode: ignore
<!-- END COMPOUND CODEX TOOL MAP -->
