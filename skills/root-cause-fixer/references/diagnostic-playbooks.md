# Diagnostic Playbooks

Use the smallest playbook that matches the failure. Combine playbooks only when the evidence crosses boundaries.

## Data Or Value Bug

Look first at:

- Input source and payload shape
- Parsing, normalization, units, timezone, encoding
- Enum/string mapping and default values
- Cache or stale persisted state
- Derived fields and duplicate source of truth

Good fixes:

- Normalize once at the input boundary.
- Tighten schema/type/invariant.
- Remove duplicated derived state.
- Fix cache invalidation or stale reads.

Avoid:

- UI fallback labels for corrupted upstream data.
- Special-casing one bad value in a consumer.

## UI State Bug

Look first at:

- Props/events and parent-child ownership
- Store/composable state mutation order
- Lifecycle hooks and cleanup
- Async request cancellation and stale closures
- Loading/error/empty state transitions
- Conditional rendering and key stability

Good fixes:

- Clarify one source of truth.
- Make ownership and lifecycle explicit.
- Cancel or ignore stale async work at the correct boundary.
- Preserve project component/style conventions.

Avoid:

- Forced page refresh.
- `setTimeout` to hide timing issues.
- Mutating props or duplicating store state locally without ownership.

## API, Service, Or Backend Bug

Look first at:

- Request DTO, query params, headers, auth scope
- Controller validation boundary
- Service invariants and transaction boundary
- Mapper/repository query conditions
- Exception handling and response envelope
- DB schema, migrations, indexes, seed data

Good fixes:

- Validate at the earliest trustworthy boundary.
- Keep errors consistent with project exception/response patterns.
- Fix service invariants or transaction ownership.
- Add targeted tests around the failing service/API path.

Avoid:

- Catch-all exceptions.
- Returning success for failed domain operations.
- Fixing SQL output in the controller/UI layer.

## Async, Race, Or Concurrency Bug

Look first at:

- Ownership of async work
- Cancellation, idempotency, and duplicate submissions
- Shared mutable state
- Cache refresh and invalidation ordering
- Locking/transaction isolation where relevant
- Event ordering and retry semantics

Good fixes:

- Make ordering explicit.
- Add idempotency or ownership checks at the boundary.
- Cancel stale work or ignore stale results intentionally.
- Use existing project concurrency primitives.

Avoid:

- Random sleeps, retries, or debounce without proof.
- Reordering awaits until the symptom disappears.

## Environment, Config, Or Build Bug

Look first at:

- Current working directory and actual checkout
- Environment variables and secrets presence, not values
- OS, shell, Node/Java/Python/Xcode/tool versions
- Lockfiles, generated files, build cache
- CI vs local command differences
- Feature flags and runtime config

Good fixes:

- Correct config source or documented setup.
- Make command/path assumptions explicit.
- Keep secrets local and redacted.
- Add validation to detect missing config early.

Avoid:

- Hardcoding personal absolute paths.
- Committing local secrets or machine-specific cache.

## Integration Or External Service Bug

Look first at:

- Contract version and official docs
- Auth, permissions, scopes, rate limits
- Request/response examples from the real service
- Webhook/callback payloads and retries
- Adapter boundaries and serialization
- Observability logs at each boundary

Good fixes:

- Fix the adapter/contract boundary.
- Preserve real-service validation.
- Use official docs or Context7 when API behavior is version-sensitive.
- Distinguish mock checks from real integration checks.

Avoid:

- Treating a mocked success as production proof.
- Swallowing external errors and returning local success.
