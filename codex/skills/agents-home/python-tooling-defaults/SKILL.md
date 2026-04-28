---
name: python-tooling-defaults
description: Use when creating a new Python helper, CLI, tooling script, or small internal automation from scratch, and the repository does not already mandate a different Python stack or style.
---

# Python Tooling Defaults

Apply these defaults only for new Python helper or tooling work. Existing repository conventions override this skill.

## Defaults

- Target Python 3.10+ unless the repository specifies another version.
- Prefer `uv` for environment and dependency management when it does not conflict with the repository.
- Follow PEP 8 and Google Python Style Guide.
- Use type hints for public functions and non-trivial internal helpers.
- Prefer standard library solutions before adding dependencies.
- Keep modules small and composable.
- Add comments only for non-obvious logic.

## Quality Bar

- Handle errors explicitly.
- Validate inputs where appropriate.
- Include the smallest useful validation, test, or runnable example.
- Do not introduce compatibility shims unless the user explicitly asks for backward compatibility.
