---
name: desktop-ui-defaults
description: Use when building a new desktop developer tool, debug UI, internal tooling UI, or visualization interface from scratch, and the repository does not already define another GUI stack.
---

# Desktop UI Defaults

Apply these defaults only for new desktop UI tooling. Existing repository conventions override this skill.

## Defaults

- Prefer Dear ImGui when immediate-mode UI is appropriate.
- Use C++ or Python bindings depending on the surrounding stack.
- Keep UI state management simple and local where possible.
- Prefer fast iteration and debuggability over visual polish.

## Quality Bar

- Reuse existing rendering, event, and utility layers when present.
- Avoid introducing heavyweight GUI frameworks unless the requirements clearly need them.
- Keep non-UI logic separated from rendering code where practical.
