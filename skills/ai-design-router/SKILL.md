---
name: ai-design-router
description: Route UI, UX, frontend visual design, Figma, motion, and visual QA tasks to the smallest useful set of installed design-related skills. Use when a task mentions interface design, frontend UI, page/component visuals, redesign, UX flow, Figma, design systems, animation, visual polish, layout, or visual verification. This skill routes only; it does not directly implement UI.
---

# AI Design Router

## Role

This is a routing skill for design-related Codex work. Its job is to decide which design, frontend, Figma, motion, or QA skill should be used for the current task.

It must not become another large visual design skill. It should keep the active skill set small and specific.

## Core Rule

Use the minimum useful combination.

Default maximum: 1 router + 1 or 2 specialist skills.

Use more only when the user explicitly asks for a full design-to-code workflow, Figma integration, motion, and QA in the same task.

## Read First

Before routing, read:

1. `AI-Design-Library/00-router/when-to-use-what.md`
2. `AI-Design-Library/00-router/routing-matrix.md`

Then read only the category file that matches the task:

- Visual taste or anti-template direction: `01-taste-and-direction/README.md`
- Product UX or user flow: `02-product-ux/README.md`
- Figma or design system: `03-design-systems/README.md`
- Frontend implementation stack: `04-frontend-implementation/README.md`
- Motion or animation: `05-motion-animation/README.md`
- Visual assets: `06-visual-assets/README.md`
- Visual QA or review: `07-qa-review/README.md`

Do not read every category by default.

## Routing Procedure

1. Identify the task's primary intent:
   - Product UX
   - Visual direction
   - Figma/design-system work
   - Frontend implementation
   - Motion
   - Asset generation
   - Visual QA/review
2. Check the project stack and existing conventions before selecting stack-specific skills.
3. Select the smallest skill set.
4. State the route in one concise line before doing work:

```text
Design route: <primary skill> + <optional supporting skill> because <reason>.
```

5. Continue with the selected specialist skill instructions.

## Priority Rules

- Existing project style, project `AGENTS.md`, README, design docs, tokens, components, and framework conventions override generic design preferences.
- For existing apps, prefer targeted evolution over full redesign unless the user asks for overhaul.
- Do not stack `frontend-design`, `taste-skill`, `ui-ux-pro-max`, and TypeUI-style references together by default.
- Do not use visual-design skills for non-visual frontend tasks such as API wiring, store fixes, router guards, build errors, or simple bug fixes; use code-discipline or root-cause skills instead.
- If Figma tools are used, follow the Figma skill/tool prerequisite rules from the available Figma plugin or local Figma skill.
- If library/framework API details are needed, use Context7 for current docs before implementing.

## Default Routes

| Task | Route |
| --- | --- |
| New polished web page or component | `frontend-design` |
| Avoid AI-looking UI or improve visual taste | `taste-skill` + `frontend-design` |
| Existing Vue UI code | `vue-code-discipline` + optional `frontend-design` |
| React/Next implementation quality | `build-web-apps:react-best-practices` + optional `frontend-design` |
| Figma design to code | `figma-implement-design` or plugin Figma skills + stack skill |
| Design system or Figma component mapping | `figma-create-design-system-rules` / `figma-code-connect-components` |
| Product flow, UX, MVP screens | `product-co-creator` or product-design plugin skills |
| GSAP animation | relevant `gsap-*` skill |
| Visual/browser verification | `playwright` / `playwright-interactive` / `build-web-apps:frontend-testing-debugging` |
| Pet/character/spritesheet asset | `hatch-pet` |

## Output Discipline

When routing, be brief:

- Selected skill(s)
- Why this route
- Any skill intentionally skipped because it would duplicate another

When the user asks for implementation, do not stop at routing; route, then perform the work with the selected skill(s).
