# Design Rules

Use these rules to keep technical designs useful instead of ornamental.

## Rule 1: Design from behavior, not from stack preference

The product flow should force the architecture, not the other way around.

## Rule 2: Prefer one source of truth per concern

If multiple components own the same critical state, explicitly justify it. Otherwise centralize ownership.

## Rule 3: Make invalid states hard to represent

Use data model, types, and state boundaries to prevent bad states instead of relying on scattered guards later.

## Rule 4: Keep v1 simple

An MVP design should optimize for changeability and correctness before advanced scale patterns.

Prefer:

- straightforward services
- minimal infrastructure
- explicit interfaces
- direct observability

## Rule 5: Mention tradeoffs, not just conclusions

For major choices, explain:

- why this option fits now
- what it gives up
- when it may need to change

## Rule 6: Raise security and privacy early

If the system handles identity, payments, health data, or user-generated content, call out:

- auth model
- permission boundaries
- sensitive data handling
- audit or moderation implications

## Rule 7: Stop before project-management detail

This skill should produce technical design, not full sprint execution plans. It can suggest build order, but detailed task decomposition belongs elsewhere.
