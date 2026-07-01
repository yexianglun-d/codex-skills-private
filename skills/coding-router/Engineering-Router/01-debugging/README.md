# Debugging

Use when the task involves a bug, regression, crash, failing test, wrong data, unexpected behavior, integration failure, or build failure.

## Default Choice

- Use `root-cause-fixer` for most bugs.
- Add `superpowers:systematic-debugging` only when the issue is complex, repeated, multi-layer, or previous fixes failed.
- Add `java-code-discipline` or `vue-code-discipline` when the fix touches those stacks.

## Working Rule

Reproduce or gather evidence before changing code. Fix the earliest broken assumption, data boundary, state transition, config, or lifecycle that explains the symptom.

## Do Not

- Patch symptoms with hardcoded defaults, swallowed exceptions, broad guards, sleeps, retries, or unrelated rewrites.
- Claim root cause without evidence.
- Treat a green build as proof that the reported behavior is fixed unless the repro path was also checked.
