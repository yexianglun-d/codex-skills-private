# When To Use What

## Use `ai-design-router`

Use this router when the task is about:

- UI design
- UX flow
- Page or component visuals
- Redesign
- Figma
- Design system
- Motion or animation
- Visual QA
- Frontend polish

Do not use this router for:

- Backend work
- Java or database changes
- Non-visual frontend bugs
- Simple text changes
- Pure deployment or Git tasks

## Route Selection

Start with the user's actual request, not the installed skill list.

If the request is:

- "Make this page beautiful" -> visual direction / frontend design
- "Implement this Figma" -> Figma / design system / stack
- "Fix this Vue component" -> Vue discipline first; design skill only if visual
- "Add scroll animation" -> GSAP or framework motion
- "Check whether this UI looks right" -> visual QA
- "Design the product flow" -> product UX

## Avoid Skill Pileups

Bad route:

```text
taste-skill + frontend-design + ui-ux-pro-max + typeui + product-design + gsap
```

Good route:

```text
frontend-design + taste-skill
```

or:

```text
vue-code-discipline + frontend-design
```

or:

```text
figma-implement-design + vue-code-discipline
```
