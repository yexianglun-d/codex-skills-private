# Planning Workflow

Use this workflow to convert technical design into execution.

## 1. Identify the build spine

Find the smallest sequence of work that makes the product real:

- initial environment or repo setup
- foundational models and contracts
- core user path
- integration layer
- hardening and release checks

This gives the plan an execution backbone instead of a random task list.

## 2. Split into phases

Good phases usually look like:

- Foundation
- Core vertical slice
- Supporting capabilities
- Integrations and edge cases
- Hardening and release prep

Not every project needs all of these, but most plans benefit from a few clear stages.

## 3. Shape tasks around outputs

Each task should produce something concrete:

- a working endpoint
- a data model
- a page or component
- an integration
- a migration
- a test suite
- a release gate

Avoid tasks like "handle backend" or "do frontend polish" unless they are further decomposed.

## 4. Put dependencies in writing

For each task, ask:

- what must exist before this starts
- what this unlocks afterward
- whether it can be parallelized
- whether it introduces review or approval waits

Plans feel much more realistic when dependency order is explicit.

## 5. Finish with validation

Every phase should end with a checkpoint:

- build passes
- key flow works
- integration is verified
- regressions are checked
- release criteria are met

Planning without validation creates false progress.
