---
name: coding-router
description: Route code engineering tasks to the smallest useful set of debugging, planning, language-discipline, documentation, and verification skills. Use for bug fixes, failing tests, new features, refactors, code reviews, Java/Vue work, build errors, technical design, implementation planning, or third-party library usage. This skill routes only; it does not directly implement code.
---

# Coding Router

## Role

This is a routing skill for engineering work. It decides which coding, debugging, planning, language-discipline, documentation, MCP, or verification workflow should guide the current task.

It must stay small. It is not a replacement for project `AGENTS.md`, code reading, tests, or the specialist skills it routes to.

## Core Rule

Use the minimum useful combination.

Default maximum: 1 router + 1 or 2 specialist workflows.

Do not stack planning, debugging, language discipline, and verification skills by default. Select the next workflow that materially reduces risk for the current task.

## Read First

Before routing, read:

1. `Engineering-Router/00-router/when-to-use-what.md`
2. `Engineering-Router/00-router/routing-matrix.md`

Then read only the category file that matches the task:

- Bug, failing tests, regressions, crashes: `01-debugging/README.md`
- New feature or implementation work: `02-implementation/README.md`
- Refactor, cleanup, or architecture adjustment: `03-refactor-architecture/README.md`
- Java work: `04-language-discipline/java.md`
- Vue work: `04-language-discipline/vue.md`
- Code review: `05-review/README.md`
- Verification, build, test, release closure: `06-verification/README.md`
- Third-party libraries, SDKs, APIs, CLIs, framework usage: `07-docs-and-mcp/README.md`

Do not read every category by default.

## Routing Procedure

1. Identify the task's primary intent:
   - Bug/root cause
   - New feature
   - Refactor
   - Code review
   - Build/test failure
   - Technical design
   - Implementation plan
   - Verification before completion
   - Third-party library/API usage
2. Check the project stack and existing conventions before selecting language-specific skills.
3. Select the smallest useful set.
4. State the route in one concise line before doing work:

```text
Coding route: <primary workflow> + <optional supporting workflow> because <reason>.
```

5. Continue with the selected specialist skill instructions or MCP workflow.

## Priority Rules

- User's current request, project `AGENTS.md`, README, package scripts, tests, and existing code style override generic routing preferences.
- For existing codebases, inspect the relevant code path before editing.
- For bugs, root cause comes before fixes.
- For simple local edits, do not inflate the task into a formal plan.
- For UI/UX/visual-design tasks, defer to `$ai-design-router` first; only add coding discipline if implementation work is also required.
- For project memory, PRD decomposition, milestones, or multi-thread coordination, defer to `$project-memory-manager` or `$codex-project-orchestrator`.
- For third-party library, framework, SDK, API, CLI, or cloud-service usage, query current docs with Context7 when details matter.
- For complex architecture, migration, multi-module redesign, or high-risk technical decisions, use sequential-thinking before executing.

## Default Routes

| Task | Route |
| --- | --- |
| Bug, regression, crash, wrong data, failing test | `root-cause-fixer`; add `superpowers:systematic-debugging` only for complex or repeated failures |
| Java / Spring / MyBatis / Maven work | `java-code-discipline`; add `root-cause-fixer` for bugs |
| Vue / Nuxt / Vite / uni-app code work | `vue-code-discipline`; add `$ai-design-router` only when the primary issue is visual |
| New feature with clear scope | project conventions + language discipline if stack-specific |
| New feature with unclear technical shape | `technical-solution-designer` before implementation |
| Existing technical design needs task breakdown | `implementation-planner` or `superpowers:writing-plans` when the user wants an execution plan |
| Refactor or architecture adjustment | relevant language discipline + `technical-solution-designer` if boundaries are unclear |
| Code review | review stance + language discipline when Java/Vue rules apply |
| Build, lint, type-check, CI, integration failure | `root-cause-fixer` + relevant language discipline |
| Before claiming completion | `superpowers:verification-before-completion` for non-trivial changes |
| Library/framework/API/SDK/CLI usage | Context7 current docs + relevant language discipline |
| Tiny text/config/code tweak | no extra specialist unless the project rules or risk require it |

## Output Discipline

When routing, be brief:

- Selected workflow(s)
- Why this route
- Any obvious skill intentionally skipped because it would add noise

When the user asks for implementation, do not stop at routing. Route, inspect context, then perform the work with the selected workflow.
