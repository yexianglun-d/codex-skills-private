# Validation Gates

Use before saying a bug is fixed.

## Required Gates

1. Original failure path checked
   - Re-run the failing command, test, screen path, request, fixture, or closest available evidence path.
2. Root cause still explains the result
   - The observed fix outcome must match the root-cause statement, not merely hide the symptom.
3. Adjacent paths checked
   - Exercise the nearest equivalent path, edge case, or regression-prone flow.
4. Scoped automated checks run
   - Prefer the smallest meaningful test/build/lint/type/API/browser check for the changed files.
5. No unrelated damage
   - Review diff scope. Do not include unrelated formatting, rewrites, cleanup, or user changes.

## Matching Validation By Bug Type

| Bug type | Minimum useful validation |
| --- | --- |
| Failing unit test | Re-run the failing test, then nearby tests. |
| Build/type/lint failure | Re-run the failing command, then scoped project build/check if reasonable. |
| UI state bug | Re-run browser/manual repro and nearest state transitions; use Playwright when practical. |
| API/service bug | Re-run request/service test and validate error/response shape. |
| Data/persistence bug | Check source data, write/read path, and equivalent query or migration path. |
| Async/race bug | Re-run multiple times or cover duplicate/stale/cancelled path. |
| Integration bug | Distinguish mock, local, staging, and real service evidence. |

## When Validation Cannot Run

State all three:

- Why it could not run.
- What substitute check was performed.
- What risk remains.

Do not convert "not run" into "passed."

## Completion Language

Allowed:

- "Implemented and verified with <checks>."
- "Fixed the proven root cause; <checks> passed."
- "Code changed, but final validation is blocked by <reason>."

Avoid:

- "Should be fixed."
- "Looks good."
- "Tests are enough" when the original repro was not covered.
