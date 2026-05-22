# Fix Standard

Use this file to judge whether a proposed fix is complete or merely cosmetic.

## A fix is complete when

- It changes the cause of the bug, not only the last visible symptom.
- It explains why the bug happened in the first place.
- It prevents the same failure mode across equivalent paths.
- It leaves the code easier to reason about than before, or at least not harder.
- It includes validation that matches the original failure mode.

## A fix is probably incomplete when

- It adds a guard without explaining why invalid state existed.
- It adds a retry, delay, or debounce without proving a timing cause.
- It hides the error message rather than changing the failing behavior.
- It special-cases one input while the parser or invariant remains broken.
- It fixes only the UI while the data or domain layer still misbehaves.
- It relies on "should be fine now" without a repro or check.

## Preferred fix patterns

- Replace derived duplicated state with one source of truth.
- Move validation to the earliest trustworthy boundary.
- Tighten types or invariants so invalid states become impossible.
- Simplify branching so the broken path cannot drift from the correct path.
- Make async sequencing explicit with clear ownership and lifecycle.
- Correct caching invalidation or remove stale cache dependence.

## When temporary mitigation is acceptable

Allow temporary mitigation only when the user explicitly prefers speed over completeness or when production containment is required before a full fix.

When using temporary mitigation:

- Call it temporary
- State the unresolved root problem
- State the follow-up needed for permanent repair

Do not present temporary containment as a complete fix.
