# Implementation

Use when the task asks for new behavior, a feature, an endpoint, a page, a component, a workflow, or a targeted code change.

## Default Choice

- If the scope is clear, inspect the codebase and follow existing project patterns.
- Use `java-code-discipline` for Java/Spring/MyBatis work.
- Use `vue-code-discipline` for Vue/Nuxt/Vite/uni-app work.
- Use `$ai-design-router` first when the primary requirement is UI/UX/visual quality.
- Use Context7 when current third-party library/API behavior matters.

## Escalate To Planning

Use `technical-solution-designer` before coding when:

- Product behavior is clear but technical structure is not.
- Data model, API, state ownership, integration boundaries, or security decisions are unclear.
- The implementation affects multiple modules or services.

Use `implementation-planner` or `superpowers:writing-plans` when:

- The technical direction is decided but the user wants phases, tasks, acceptance criteria, and verification steps.

## Do Not

- Create a large plan for a small local change.
- Introduce new dependencies, patterns, or abstractions when existing project mechanisms are enough.
- Implement UI visuals from generic taste guidance without reading project style first.
