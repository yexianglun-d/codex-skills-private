---
name: root-cause-fixer
description: Diagnose bugs by reproducing them, gathering evidence, isolating the true root cause, and implementing a complete fix with validation. Use when Codex is asked to investigate crashes, failing tests, regressions, incorrect UI or data behavior, race conditions, state inconsistencies, or persistent "why did this happen" issues, especially when the user explicitly wants root-cause analysis and rejects patch-style workarounds.
---

# Root Cause Fixer

## Overview

Treat every bug as a causality problem. Reproduce the failure, narrow the blast radius, identify the broken assumption or invariant, then fix that cause and validate the surrounding behavior.

Reject patch-style workarounds by default. Do not stop at symptom suppression, defensive masking, or surface-only fixes unless the user explicitly asks for temporary mitigation.

## Trigger Phrases

Use this skill when the request sounds like:

- "Do not patch it. Find the real reason and fix it."
- "Why is this bug happening?"
- "Trace the root cause of this crash/regression."
- "Give me a complete fix, not a workaround."
- "This only hides the issue. Solve it properly."

## Working Rules

- Reproduce the failure before editing code when feasible.
- Gather evidence before declaring a cause.
- Fix the earliest broken assumption, boundary, or invariant that explains the symptom.
- Prefer removing impossible states over adding more guards around them.
- Preserve the existing architecture when it is sound; change the architecture directly when it is the root problem.
- State uncertainty explicitly when the root cause is not yet proven.
- Ask before applying temporary mitigation that intentionally leaves the root problem in place.

## Workflow

1. Establish the failure.
   Capture the exact symptom, expected behavior, trigger, affected surface, and first known occurrence.
2. Reproduce the issue.
   Freeze a minimal repro path. Distinguish deterministic, intermittent, environment-specific, and data-specific failures.
3. Bound the problem.
   Find the first layer where values, state, ownership, timing, or configuration diverge from expectation.
4. Prove the root cause.
   Form a falsifiable statement in the form "X causes Y because Z" and test it against the evidence.
5. Design the complete fix.
   Change the source of truth, ownership boundary, state model, parsing rule, synchronization rule, or validation point that actually created the bad outcome.
6. Validate adjacent behavior.
   Re-run the repro, run nearby checks, and inspect the most likely regression paths.
7. Explain the result.
   State the root cause, the actual fix, why patch-style alternatives were rejected, and any remaining risk.

## Investigation Heuristics

- Trace data backward from the symptom to the first wrong value.
- Trace state transitions until the first impossible state appears.
- Compare working and failing paths to isolate the divergence point.
- Check ownership and lifecycle boundaries before adding null guards.
- Check concurrency, caching, and stale state before adding retries or delays.
- Check parsing and normalization before special-casing one bad input.
- Check configuration, environment, and build differences before rewriting logic.

## Reject These Fix Patterns

- Adding retries, sleeps, debounces, or reordered awaits to hide a race you have not explained.
- Adding UI-level fallback text to mask corrupted upstream data.
- Adding null/default guards around state that should never be invalid.
- Swallowing exceptions or broadening catch blocks without changing the failing condition.
- Duplicating validation across layers when the real boundary is misplaced.
- Fixing a single symptom path while the same broken assumption remains elsewhere.

## Use The References

- Read [references/bug-workflow.md](references/bug-workflow.md) for the detailed investigation checklist.
- Read [references/fix-standard.md](references/fix-standard.md) to judge whether a proposed fix is complete enough.

## Output Shape

When reporting back, structure the answer around:

1. Symptom and repro
2. Proven root cause
3. Complete fix
4. Validation performed
5. Residual risk, if any

## Scope Limits

Do not use this skill for:

- Pure feature development with no bug involved
- Cosmetic-only refactors
- Temporary workarounds the user explicitly prefers for schedule reasons

If the request starts as a bug but the real answer is architectural change, continue and make that architectural change explicitly.
