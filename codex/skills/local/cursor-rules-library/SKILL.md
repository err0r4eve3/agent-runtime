---
name: cursor-rules-library
description: Use the imported Cursor rules library from ~/.codex/vendor_imports/cursor-rules as reference guidance, selecting only the rules relevant to the current stack, language, or workflow.
---

# Cursor Rules Library

This skill exposes the imported Cursor `.mdc` rules inside Codex.

## Rule Source

The imported rules live under:

`C:\Users\daniel\.codex\vendor_imports\cursor-rules`

Main categories:

- `base`
- `frameworks`
- `languages`
- `other`
- `demo`

## How To Use

1. Start from `base/core.mdc` for general behavior guidance.
2. Add only the files relevant to the current task's language or framework.
3. Treat these files as guidance to adapt, not as unconditional instructions for every task.
4. If a rule conflicts with the repository's existing conventions, prefer the repository's conventions.
5. Avoid loading unrelated template rules just because they exist.

## Selection Guide

- General behavior: `base/core.mdc`, `base/general.mdc`
- Project context: `base/project-structure.mdc`, `base/tech-stack.mdc`
- Language-specific work: matching file in `languages/`
- Framework-specific work: matching file in `frameworks/`
- Git and docs workflows: matching file in `other/`

## Notes

- These rules were imported from Cursor and preserved in their original `.mdc` format.
- Codex does not auto-apply Cursor `.mdc` rules natively, so this skill is the compatibility layer for using them intentionally.
