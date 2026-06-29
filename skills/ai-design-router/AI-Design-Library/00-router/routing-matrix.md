# Routing Matrix

| Primary intent | First choice | Add only if needed | Skip by default |
| --- | --- | --- | --- |
| New web UI/page/component | `frontend-design` | `taste-skill` for stronger anti-template taste | `ui-ux-pro-max` |
| Existing UI needs better taste | `taste-skill` | `frontend-design` for implementation guidance | TypeUI candidates |
| Product idea or flow | `product-co-creator` | product-design plugin skills | frontend implementation skills |
| Figma to code | Figma implementation skill | stack skill such as Vue/React | unrelated visual taste skills |
| Design system rules | Figma design-system skill | stack skill | general redesign skills |
| Vue UI implementation | `vue-code-discipline` | `frontend-design` if visual quality matters | React-only skills |
| React/Next UI implementation | React best-practices skill | `frontend-design` | Vue-only skills |
| GSAP animation | relevant `gsap-*` skill | framework-specific GSAP skill | generic motion advice |
| Visual QA | Playwright/testing skill | `frontend-design` for review criteria | implementation-only skills |
| Pet/character asset | `hatch-pet` | sprite/asset pipeline if available | layout/design-system skills |

## Tie Breakers

- If the user names a skill, use that skill.
- If a project has an existing design doc, tokens, or component library, read those before applying generic style guidance.
- If the UI task is in Vue, always consider `vue-code-discipline`.
- If the task is only a visual review, do not edit code until the user asks for fixes.
- If implementation touches a third-party UI library, query current docs with Context7.
