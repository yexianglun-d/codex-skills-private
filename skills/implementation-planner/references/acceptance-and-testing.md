# Acceptance And Testing

Use this file to make tasks verifiable.

## Acceptance criteria rules

Good acceptance criteria are:

- observable
- specific
- tied to behavior, not intention
- small enough to validate quickly

Weak example:

- "User system is complete"

Strong example:

- "Users can create an account, sign in, sign out, and receive clear validation errors for invalid credentials."

## Testing layers

Choose test layers based on the nature of the task:

- Unit tests: logic, parsing, state transitions, utility behavior
- Integration tests: database, API, service boundaries, external dependencies
- End-to-end tests: critical user flows and system interaction
- Manual QA: UI detail, edge conditions, device behavior, release smoke checks

Do not require every layer for every task. Choose the minimum set that gives meaningful confidence.

## What every plan should include

- at least one validation path for each phase
- explicit checks for the highest-risk user flow
- release smoke checks for the MVP path
- regression-sensitive areas called out before release

## Done means

A task is done when:

- the target behavior exists
- the acceptance criteria are satisfied
- the planned validation has been performed
- obvious adjacent regressions have been considered

If any of these are missing, the task is not really done.
