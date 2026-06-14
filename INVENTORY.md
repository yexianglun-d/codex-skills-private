# Inventory

Snapshot date: 2026-06-14

This inventory intentionally lists entries once. Some plugins may exist in multiple cache locations; the table below deduplicates them by plugin name.

## Non-System Local Skills

These are vendored under `skills/` and can be restored directly.

| Skill | Trigger policy | Notes |
| --- | --- | --- |
| `chronicle` | default | Local screen/history context skill. |
| `codex-project-orchestrator` | explicit only | Main-thread project progress, milestones, task board, and thread handoff. |
| `figma` | default | Figma MCP read/design-to-code helper. |
| `figma-code-connect-components` | default | Figma Code Connect component mapping. |
| `figma-create-design-system-rules` | default | Generate project-specific Figma design system rules. |
| `figma-implement-design` | default | Implement UI from Figma designs. |
| `frontend-design` | default | Production-grade frontend UI design. |
| `gsap-core` | default | GSAP core tween API. |
| `gsap-frameworks` | default | GSAP with Vue, Svelte, and other non-React frameworks. |
| `gsap-performance` | default | GSAP performance and jank reduction. |
| `gsap-plugins` | default | GSAP plugins such as Flip, Draggable, SplitText, SVG plugins. |
| `gsap-react` | default | GSAP in React and Next.js. |
| `gsap-scrolltrigger` | default | ScrollTrigger and scroll-driven animation. |
| `gsap-timeline` | default | GSAP timeline sequencing. |
| `gsap-utils` | default | `gsap.utils` helpers. |
| `implementation-planner` | default | Technical plan to implementation phases and task breakdown. |
| `java-code-discipline` | auto | Java root-cause, project-style, minimal-change discipline. |
| `liu-ying-chat-style` | explicit only | Private relationship/chat style skill. Keep private. |
| `pdf` | default | PDF reading/rendering/layout workflows. |
| `playwright` | default | Browser automation from terminal. |
| `playwright-interactive` | default | Persistent browser/Electron interaction. |
| `product-co-creator` | default | Product idea to MVP, flows, requirements, roadmap. |
| `root-cause-fixer` | default | Reproduce, diagnose, fix, and validate bugs. |
| `technical-solution-designer` | default | PRD/product plan to technical architecture and APIs. |
| `ui-ux-pro-max` | explicit only | Private UI/UX intelligence and design system skill. |

## System Skills Not Vendored

These are expected to come from Codex/system installation.

| Skill |
| --- |
| `imagegen` |
| `openai-docs` |
| `plugin-creator` |
| `skill-creator` |
| `skill-installer` |

## MCP Servers

| MCP | Status in source machine | Restore method |
| --- | --- | --- |
| `computer-use` | enabled | Plugin-managed by Codex bundled Computer Use. |
| `context7` | enabled | Restore config, then set `CONTEXT7_API_KEY` locally. |
| `node_repl` | enabled | Codex app runtime managed; verify path on target machine. |
| `sequential-thinking` | enabled | Restore with `npx -y @modelcontextprotocol/server-sequential-thinking`. |
| `postman` | enabled OAuth | Restore URL and re-auth with `codex mcp login postman` if needed. |

## Plugins

Unique plugin entries observed on the source machine:

| Plugin | Version / Build | Source type |
| --- | --- | --- |
| `browser` | `26.609.41114` | openai-bundled |
| `chrome` | `26.609.41114` | openai-bundled |
| `computer-use` | `1.0.809` | openai-bundled |
| `build-web-apps` | `0.1.2` | openai-curated |
| `figma` | `2.0.9` | openai-curated / remote cache |
| `game-studio` | `0.1.2` | openai-curated |
| `github` | `0.1.2` | openai-curated |
| `heygen` | `2.2.3` | openai-curated / remote cache |
| `hyperframes` | `0.1.2` | openai-curated |
| `remotion` | `1.0.2` | openai-curated |
| `product-design` | `0.1.46` | openai-curated-remote |
| `documents` | `26.601.10930` | openai-primary-runtime |
| `presentations` | `26.601.10930` | openai-primary-runtime |
| `spreadsheets` | `26.601.10930` | openai-primary-runtime |

## Plugin-Provided Skill Groups

These are not vendored in `skills/`; restore them by installing/enabling the corresponding plugin.

| Plugin | Skills |
| --- | --- |
| `browser` | `control-in-app-browser` |
| `chrome` | `control-chrome` |
| `computer-use` | `computer-use` |
| `build-web-apps` | `frontend-app-builder`, `frontend-testing-debugging`, `react-best-practices`, `shadcn-best-practices`, `stripe-best-practices`, `supabase-best-practices` |
| `figma` | `figma-code-connect`, `figma-create-new-file`, `figma-generate-design`, `figma-generate-diagram`, `figma-generate-library`, `figma-use`, `figma-use-figjam`, `figma-use-slides` |
| `game-studio` | `game-playtest`, `game-studio`, `game-ui-frontend`, `phaser-2d-game`, `react-three-fiber-game`, `sprite-pipeline`, `three-webgl-game`, `web-3d-asset-pipeline`, `web-game-foundations` |
| `github` | `gh-address-comments`, `gh-fix-ci`, `github`, `yeet` |
| `heygen` | `heygen-avatar`, `heygen-video` |
| `hyperframes` | `gsap`, `hyperframes`, `hyperframes-cli`, `hyperframes-registry`, `website-to-hyperframes` |
| `remotion` | `remotion` |
| `product-design` | `audit`, `design-qa`, `get-context`, `ideate`, `image-to-code`, `index`, `prototype`, `research`, `share`, `url-to-code`, `user-context` |
| `documents` | `documents` |
| `presentations` | `presentations` |
| `spreadsheets` | `spreadsheets` |
