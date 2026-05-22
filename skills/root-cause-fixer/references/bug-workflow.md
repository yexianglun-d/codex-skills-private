# Bug Workflow

Use this checklist when the root cause is not immediately obvious.

## 1. Define the failure precisely

- Record the exact symptom.
- Record the expected behavior.
- Record the trigger conditions.
- Record the affected environment, input, and timing.
- Record whether the issue is new, intermittent, or long-standing.

Do not begin code edits while the problem statement is still vague.

## 2. Establish a reproducible path

- Reproduce locally when feasible.
- Reduce the repro to the smallest reliable sequence.
- Capture the exact command, screen path, fixture, request, or file that triggers the issue.
- If the issue is intermittent, record frequency and suspected contributing conditions.

If reproduction is impossible, switch into evidence collection mode instead of guessing.

## 3. Find the first point of divergence

Inspect the flow in this order until the first wrong fact appears:

1. Input or event source
2. Parsing or normalization
3. State mutation
4. Domain logic
5. Persistence or cache
6. Async or concurrency boundary
7. Rendering or presentation
8. External dependency or environment

The bug usually becomes tractable when the first wrong value, wrong state, or wrong ordering is identified.

## 4. Build a falsifiable root-cause statement

Use this template:

`The bug happens because <cause> leads to <broken behavior> under <conditions>.`

A valid root cause should explain:

- Why the symptom appears
- Why it appears only under those conditions
- Why neighboring paths do not fail the same way

If the statement does not explain all three, keep investigating.

## 5. Prefer these evidence sources

- Failing tests
- Minimal repro fixtures
- Targeted logging around the suspect boundary
- State snapshots before and after the failure
- Stack traces and error payloads
- Comparison between working and failing paths
- Git history when the regression window is narrow

Prefer narrow, targeted instrumentation over noisy blanket logging.

## 6. Classify the failure type

Use the classification to choose where to look first:

- Wrong value: inspect parsing, normalization, units, defaults, and stale cache.
- Wrong state: inspect ownership, lifecycle, mutation order, and impossible states.
- Wrong timing: inspect async sequencing, races, cancellation, retries, and stale closures.
- Wrong boundary: inspect validation placement, API contracts, serialization, and adapter layers.
- Wrong environment: inspect permissions, config, OS differences, paths, and feature flags.

## 7. Design the fix at the real boundary

Prefer fixes like:

- Move validation to the true input boundary
- Centralize source of truth
- Remove invalid intermediate state
- Correct ownership or lifecycle
- Normalize data once instead of patching each consumer
- Make ordering explicit instead of relying on timing luck

Avoid adding more conditionals if the state model itself is broken.

## 8. Validate beyond the happy path

- Re-run the original repro
- Exercise the nearest adjacent flows
- Check the most likely regression areas
- Run targeted tests or build checks when available
- Verify that removed assumptions are actually gone

Do not stop after "the obvious screen works now."
