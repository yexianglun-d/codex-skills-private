# Evidence Template

Use this for non-trivial, cross-layer, intermittent, or disputed bugs.

## Investigation Notes

```markdown
## Bug Evidence

- Symptom:
- Expected behavior:
- Actual behavior:
- Trigger path:
- Environment / data / timing:
- First known occurrence:
- Deterministic or intermittent:

## Reproduction Or Evidence

- Repro command / screen path / request / fixture:
- Evidence artifact:
- If not reproducible, why:
- What was ruled out:

## First Divergence

- Layer inspected:
- First wrong value/state/config/order:
- Upstream source:
- Downstream symptom caused:

## Root Cause Statement

The bug happens because <cause> leads to <broken behavior> under <conditions>.

This explains:
- Why the symptom appears:
- Why these conditions trigger it:
- Why nearby paths do not fail:

## Fix Boundary

- Boundary changed:
- Files changed:
- Why this is the root fix:
- Why rejected alternatives were only patches:

## Validation

- Original repro rechecked:
- Tests/build/lint/type-check/API/browser/manual checks:
- Adjacent paths checked:
- Checks not run and why:
- Remaining risk:
```

## Final Response Shape

```markdown
改了什么：

为什么这样改：

如何验证：

剩余问题：
```

For user-facing final answers, keep it concise. Do not paste the full investigation notes unless the user asks for the detailed trace.
