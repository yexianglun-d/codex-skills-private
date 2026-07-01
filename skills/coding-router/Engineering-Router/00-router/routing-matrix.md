# Routing Matrix

| Primary intent | First choice | Add only if needed | Skip by default |
| --- | --- | --- | --- |
| Bug, crash, regression, wrong data | `root-cause-fixer` | `superpowers:systematic-debugging` for complex/repeated failures; language discipline for Java/Vue | implementation planning |
| Failing test, build, lint, CI | `root-cause-fixer` | language discipline for stack-specific fixes | temporary guards or broad rewrites |
| Java/Spring/MyBatis code | `java-code-discipline` | `root-cause-fixer` for bugs; Context7 for library/API details | generic Java manuals |
| Vue/Nuxt/Vite/uni-app code | `vue-code-discipline` | `$ai-design-router` for visual UI work; Context7 for library/API details | React-only or generic design skills |
| New feature, scope clear | existing project patterns | language discipline if Java/Vue | heavy planning |
| New feature, scope unclear | `technical-solution-designer` | `implementation-planner` after design is accepted | direct coding |
| Technical design from product docs | `technical-solution-designer` | sequential-thinking for high-risk decisions | implementation execution |
| Implementation plan from design | `implementation-planner` | `superpowers:writing-plans` for detailed executable plans | code edits |
| Refactor | relevant language discipline | `technical-solution-designer` if boundaries are unclear | unrelated cleanup |
| Code review | review stance | language discipline for Java/Vue; `root-cause-fixer` for suspected bugs | direct edits unless requested |
| Verification before done | project test/build commands | `superpowers:verification-before-completion` for non-trivial changes | claiming completion without evidence |
| Third-party docs/API usage | Context7 | relevant language discipline | model-memory-only answers |
| Visual UI redesign | `$ai-design-router` | stack discipline when implementing | coding-router-only route |
| Project memory or PRD orchestration | `$project-memory-manager` or `$codex-project-orchestrator` | implementation planner after direction is accepted | coding-router-only route |

## Tie Breakers

- If the user explicitly names a skill, use that skill.
- If the task is a bug and a language-specific task, route bug first, then language discipline.
- If the task is a visual UI task and a code task, route design first, then stack discipline.
- If the task is implementation and the approach is not decided, design first.
- If the task is small and safe, do not add a specialist skill just because one exists.
- If a selected workflow requires reading its own references, read those after routing and before acting.
