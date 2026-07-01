# Code Review

Use when the user asks for a review, audit, risk check, regression check, or "看看这段代码有没有问题".

## Default Choice

- Use Codex's code-review stance: findings first, ordered by severity, with file and line references.
- Add `java-code-discipline` or `vue-code-discipline` when language-specific rules matter.
- Add `root-cause-fixer` if the review is triggered by a suspected bug or failing behavior.

## Review Focus

- Bugs
- Behavioral regressions
- Missing validation or error handling
- Data, state, permission, or lifecycle issues
- Missing or weak tests
- Project-style violations that carry real maintenance risk

## Do Not

- Lead with praise or summary before findings.
- Rewrite code unless the user explicitly asks for fixes.
- Report purely stylistic preferences as high-severity issues.
