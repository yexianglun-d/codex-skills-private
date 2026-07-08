# AI Design Library

This library organizes local design-related Codex skills by responsibility.

Path rule: this folder is inside the `ai-design-router` skill directory. All paths in `ai-design-router/SKILL.md` that start with `AI-Design-Library/` are relative to the `ai-design-router` skill directory, not to `$CODEX_HOME/skills` or the current project root.

It is not a new design system and does not replace project conventions. Use it to route tasks cleanly and avoid stacking overlapping skills.

```text
AI-Design-Library/
├── 00-router/
├── 01-taste-and-direction/
├── 02-product-ux/
├── 03-design-systems/
├── 04-frontend-implementation/
├── 05-motion-animation/
├── 06-visual-assets/
├── 07-qa-review/
├── 08-design-references/
└── 99-candidates/
```

Default principle:

- Route first.
- Use the smallest useful skill set.
- Preserve existing product style unless the user asks for a redesign.
