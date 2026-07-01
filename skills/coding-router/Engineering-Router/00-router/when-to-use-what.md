# When To Use What

## Use `coding-router`

Use this router when the task is about:

- Code implementation
- Bug fixes
- Failing tests
- Build or lint failures
- Refactors
- Technical design
- Implementation planning
- Java or Vue engineering discipline
- Code review
- Verification before completion
- Third-party library, SDK, API, CLI, or framework usage

Do not use this router for:

- Pure UI/UX/visual direction tasks; use `$ai-design-router`
- Pure project history or handoff tasks; use `$project-memory-manager`
- Formal PRD decomposition, milestones, or multi-thread planning; use `$codex-project-orchestrator`
- Pure prose polishing; use `$humanizer` only when explicitly requested
- One-line shell facts that do not touch project state

## Route Selection

Start with the user's actual request, not the installed skill list.

If the request is:

- "Fix this bug" -> `root-cause-fixer`
- "Why does this fail" -> `root-cause-fixer`; add `superpowers:systematic-debugging` for complex failures
- "Implement this Java endpoint" -> `java-code-discipline`
- "Fix this Vue page" -> `vue-code-discipline`
- "Design the technical approach" -> `technical-solution-designer`
- "Break this technical solution into tasks" -> `implementation-planner` or `superpowers:writing-plans`
- "Review this code" -> review stance + relevant language discipline
- "Use this library/API" -> Context7 current docs + relevant stack skill
- "Is it done" -> `superpowers:verification-before-completion` for non-trivial work

## Avoid Skill Pileups

Bad route:

```text
root-cause-fixer + java-code-discipline + vue-code-discipline + implementation-planner + technical-solution-designer + all superpowers skills
```

Good route:

```text
root-cause-fixer + java-code-discipline
```

or:

```text
technical-solution-designer
```

or:

```text
vue-code-discipline + Context7
```
