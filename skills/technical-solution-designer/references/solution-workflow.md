# Solution Workflow

Use this workflow to convert product intent into an implementation-grade technical design.

## 1. Anchor the product behavior

Before naming technologies, capture:

- the main user flows
- the critical user actions
- the data that must exist
- the platform surfaces involved
- the constraints that are already known

If you cannot describe how the product behaves, you are not ready to design the system.

## 2. Draw the system boundary

Define what belongs in:

- client
- backend
- storage
- third-party services
- background processing
- admin or internal tools

This prevents the design from collapsing into a vague "frontend + backend + database" answer.

## 3. Model the core entities

For each core entity, define:

- purpose
- key fields
- ownership
- lifecycle
- relationships
- invariants

Strong technical design usually starts with a correct data and state model.

## 4. Define the main flows

For each important product flow, specify:

- trigger
- input
- validations
- state changes
- side effects
- response shape
- failure modes

This is the fastest way to discover missing components or weak boundaries.

## 5. Cut the modules

Split by domain responsibility, not by random file count.

Good module boundaries usually separate:

- user/account domain
- core business domain
- content/data domain
- integrations
- analytics or reporting
- infrastructure concerns

## 6. Choose technical patterns only when justified

Decide patterns based on product behavior:

- real-time sync only if the product needs fresh shared state
- background jobs only if work must outlive a request
- cache only if latency or load actually matters
- event-driven patterns only if multiple consumers benefit from decoupling

Do not add fashionable architecture without a product reason.

## 7. Close the document with implementation reality

Always include:

- major risks
- unknowns
- security/privacy concerns
- build order
- what can stay simple in v1
