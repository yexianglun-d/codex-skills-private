---
name: root-cause-fixer
description: Diagnose bugs through reproducible evidence, root-cause proof, boundary-correct fixes, and validation gates. Use when Codex is asked to investigate crashes, failing tests, regressions, incorrect UI or data behavior, race conditions, state inconsistencies, build/integration failures, or persistent "why did this happen" issues, especially when patch-style workarounds are rejected.
---

# Root Cause Fixer

## Role

Treat every bug as a causality problem. Establish the failure, collect evidence, find the first wrong value/state/boundary, prove the root cause, fix the real boundary, and validate the original repro plus nearby regression paths.

This skill is intentionally stricter than normal implementation work. It rejects symptom suppression by default.

## Use When

Use this skill when the task sounds like:

- "Find the real reason."
- "Do not patch it."
- "Why did this happen?"
- "Fix the failing test/build/regression."
- "This UI/data/state is wrong."
- "Trace the crash, race, stale state, or integration failure."

For Java bugs, also use `java-code-discipline`. For Vue bugs, also use `vue-code-discipline`. For complex or repeated failures, `superpowers:systematic-debugging` may be added after this route is selected.

## Hard Gates

Do not edit code until at least one is true:

- The failure is reproduced.
- A failing test, stack trace, bad payload, log excerpt, screenshot, or state snapshot proves the failure.
- Reproduction is not feasible and evidence-collection mode has been explicitly stated.

Do not claim the fix is complete until all are true:

- The root cause statement explains the symptom, trigger conditions, and why nearby paths behave differently.
- The fix changes the cause, not only the visible symptom.
- The original repro or closest available evidence path has been re-checked.
- Matching tests, build, lint, browser check, API check, or manual validation has run, or skipped checks are explained.

## Workflow

1. Define the failure.
   Capture symptom, expected behavior, trigger, affected surface, environment, timing, and whether it is new/intermittent/long-standing.
2. Reproduce or collect evidence.
   Prefer a minimal repro. If impossible, gather targeted logs, payloads, stack traces, screenshots, DB/state snapshots, or history around the suspected boundary.
3. Find the first divergence.
   Trace from symptom backward until the first wrong value, wrong state, wrong ordering, wrong config, or wrong ownership boundary appears.
4. Classify the bug.
   Use the failure type to decide where to inspect first: data, UI state, API/service, persistence/cache, async/concurrency, environment/config, build/tooling, or integration.
5. Prove a falsifiable root cause.
   Use: `The bug happens because <cause> leads to <broken behavior> under <conditions>.`
6. Fix the real boundary.
   Change the source of truth, validation boundary, state model, lifecycle, parsing rule, transaction, cache invalidation, or integration contract that created the failure.
7. Validate with gates.
   Re-run the original repro, exercise adjacent paths, run scoped automated checks, and document skipped checks.
8. Report concisely.
   State what changed, why this is the root fix, how it was validated, and remaining risk.

## Evidence Standard

Before changing code, keep enough notes to answer:

- What proves the bug exists?
- What is the smallest known trigger?
- Where is the first wrong fact?
- What hypothesis explains it?
- What would disprove the hypothesis?

Use `references/evidence-template.md` when the bug is non-trivial, cross-layer, intermittent, or likely to be disputed.

## Reject These Fix Patterns

- Hardcoding one known bad input while the parser or invariant remains wrong.
- Adding null/default guards without explaining why invalid state existed.
- Swallowing exceptions, broadening catch blocks, or hiding error messages.
- Adding retry, sleep, debounce, forced refresh, or reordered await without proving a timing cause.
- Fixing only UI display while corrupted data/source state remains.
- Bypassing validation, auth, permissions, transactions, or type checks.
- Making tests green by weakening assertions or replacing the real path with mocks.
- Treating a single successful mock/2xx/static screenshot as proof of real behavior.

## References

Read only what applies:

- `references/bug-workflow.md` - general investigation checklist.
- `references/evidence-template.md` - evidence notes and final report template.
- `references/diagnostic-playbooks.md` - targeted playbooks by bug type.
- `references/validation-gates.md` - completion gates and validation choices.
- `references/fix-standard.md` - judge whether a fix is complete or cosmetic.

## Output Shape

For simple bugs, answer in this order:

1. Symptom and evidence
2. Root cause
3. Fix
4. Validation
5. Residual risk

For complex bugs, use the template from `references/evidence-template.md`.

## Scope Limits

Do not use this skill for pure feature work, cosmetic refactors, or temporary mitigations the user explicitly requested.

Temporary mitigation is allowed only when the user asks for containment or production risk demands it. Label it as temporary, state the unresolved root problem, and list the permanent follow-up.
