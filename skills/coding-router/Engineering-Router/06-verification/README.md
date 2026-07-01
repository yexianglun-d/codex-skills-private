# Verification

Use when the task is near completion, asks whether a change is done, or involves build, test, lint, type-check, CI, release, or deployment readiness.

## Default Choice

- Run verification that matches the changed surface: tests, build, type-check, lint, browser/manual checks, integration checks, or command-level smoke tests.
- Use `superpowers:verification-before-completion` for non-trivial changes before claiming completion.
- For failing verification, route back to `root-cause-fixer`.

## Evidence Standard

State:

- What command or manual check was run
- What passed or failed
- What was not run and why
- Remaining risk

## Do Not

- Say "complete" because code was edited.
- Treat mock data, static screenshots, or one successful HTTP response as proof of real integration.
- Hide failed or skipped checks.
