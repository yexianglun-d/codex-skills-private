# Refactor And Architecture

Use when the task asks to restructure code, reduce duplication, change module boundaries, improve architecture, migrate patterns, or design a technical approach.

## Default Choice

- Use the relevant language discipline for stack-specific refactors.
- Use `technical-solution-designer` when ownership, data flow, interfaces, or module boundaries must be decided.
- Use sequential-thinking for complex migration, high-risk architecture, cross-module changes, or unclear tradeoffs.

## Refactor Rules

- Keep the refactor tied to the user request.
- Preserve behavior unless the user explicitly asks to change it.
- Prefer local simplification over new abstractions.
- Split only when it reduces real complexity or matches an existing project pattern.

## Do Not

- Rename, format, or reorganize unrelated files.
- Replace project conventions with personal preferences.
- Add a design pattern just to make the refactor look more formal.
