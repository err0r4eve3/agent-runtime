---
name: frontend-greenfield-defaults
description: Use when creating a new frontend application or a major new frontend surface from scratch, and the repository does not already define a frontend stack.
---

# Frontend Greenfield Defaults

Apply these defaults only for greenfield frontend work. Existing repository conventions override this skill.

## Defaults

- Prefer TypeScript 5.x.
- Prefer Next.js App Router for new web applications.
- Prefer `pnpm` as the package manager.
- Prefer Tailwind CSS for styling.
- Use ESLint and Prettier.
- Keep architecture simple and avoid premature abstraction.

## Working Order

1. Requirements
2. UI/UX
3. Architecture
4. Implementation

## Quality Bar

- Reuse existing design tokens, components, and utilities when available.
- Keep components small and composable.
- Avoid adding state libraries or new framework layers unless the need is clear.
- Run the smallest relevant validation for the changed area.
