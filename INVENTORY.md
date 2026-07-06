# Inventory

Snapshot date: 2026-07-06

This inventory intentionally lists entries once. Some plugins may exist in multiple cache locations; the table below deduplicates them by plugin name.

## Non-System Local Skills

These are vendored under `skills/` and can be restored directly.

| Skill | Trigger policy | Notes |
| --- | --- | --- |
| `ai-design-router` | auto | Routes UI, UX, frontend visual, Figma, motion, visual QA, and named `DESIGN.md` style-reference tasks to the smallest useful set of design-related skills. Vendors `VoltAgent/awesome-design-md` references; `typeui` remains a candidate only. |
| `chronicle` | default | Local screen/history context skill. |
| `codex-project-orchestrator` | explicit only | Advanced PRD decomposition, milestones, task boards, multi-thread coordination, progress audits, and integration planning. Use only when lightweight project history is not enough. |
| `coding-router` | auto | Routes code engineering tasks to the smallest useful debugging, language-discipline, planning, docs/MCP, and verification workflow. Avoids default stacking of root-cause, Java/Vue discipline, planning, and superpowers skills. |
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
| `hatch-pet` | default | Create, repair, validate, QA, and package Codex animated pets and spritesheets. |
| `humanizer` | explicit only | Rewrite prose or Markdown to reduce AI-sounding patterns. Use only when explicitly asked to humanize, rewrite, or polish text. |
| `implementation-planner` | default | Technical plan to implementation phases and task breakdown. |
| `java-code-discipline` | auto | Java root-cause, project-style, minimal-change discipline. |
| `liu-ying-chat-style` | explicit only | Private relationship/chat style skill. Keep private. |
| `pdf` | default | PDF reading/rendering/layout workflows. |
| `playwright` | default | Browser automation from terminal. |
| `playwright-interactive` | default | Persistent browser/Electron interaction. |
| `product-co-creator` | default | Product idea to MVP, flows, requirements, roadmap. |
| `project-memory-manager` | explicit only | Lightweight repository-local project journal under `docs/project-memory`: current status, activity log, decisions, and next handoff. |
| `root-cause-fixer` | default | Reproduce, diagnose, fix, and validate bugs. |
| `taste-skill` | explicit only | Anti-template frontend visual direction; main skill name is `design-taste-frontend`. |
| `technical-solution-designer` | default | PRD/product plan to technical architecture and APIs. |
| `ui-ux-pro-max` | explicit only | Private UI/UX intelligence and design system skill. |
| `vue-code-discipline` | auto | Vue code discipline, enterprise directory structure, component/data-flow rules, and validation. |

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
| `firecrawl` | enabled | Restore with `npx -y firecrawl-mcp`, then set `FIRECRAWL_API_KEY` locally. |
| `figma` | enabled, not logged in | Restore URL; authenticate in Figma/Codex if design operations require login. |
| `github` | enabled with bearer token env | Restore URL, then set `GITHUB_PAT_TOKEN` locally if this MCP is needed. |
| `node_repl` | enabled | Codex app runtime managed; verify path on target machine. |
| `sequential-thinking` | enabled | Restore with `npx -y @modelcontextprotocol/server-sequential-thinking`. |
| `postman` | enabled OAuth | Restore URL and re-auth with `codex mcp login postman` if needed. |

## Additional Local CLI Tools

| Tool | Version in source machine | Restore method |
| --- | --- | --- |
| `firecrawl` | `1.19.24` | `npm install -g firecrawl-cli`, then authenticate with `firecrawl login --api-key "$FIRECRAWL_API_KEY"`. |

## Plugins

Unique plugin entries observed on the source machine:

| Plugin | Version / Build | Source type |
| --- | --- | --- |
| `browser` | `26.623.42026` | openai-bundled |
| `chrome` | `26.623.42026` | openai-bundled |
| `computer-use` | `1.0.857` | openai-bundled |
| `build-ios-apps` | `0.1.2` | openai-curated-remote |
| `build-web-apps` | `0.1.2` | openai-curated |
| `figma` | `2.0.12` | openai-curated / remote cache |
| `game-studio` | `0.1.2` | openai-curated |
| `github` | `0.1.6` | openai-curated |
| `google-drive` | `0.1.7` | openai-curated-remote |
| `heygen` | `2.2.4` | openai-curated |
| `hyperframes` | `0.1.2` | openai-curated |
| `remotion` | `1.0.3` | openai-curated |
| `product-design` | `0.1.47` | openai-curated-remote |
| `documents` | `26.623.12021` | openai-primary-runtime |
| `pdf` | `26.623.12021` | openai-primary-runtime |
| `presentations` | `26.623.12021` | openai-primary-runtime |
| `spreadsheets` | `26.623.12021` | openai-primary-runtime |
| `template-creator` | `26.623.12021` | openai-primary-runtime |

## Plugin-Provided Skill Groups

These are not vendored in `skills/`; restore them by installing/enabling the corresponding plugin.

| Plugin | Skills |
| --- | --- |
| `browser` | `control-in-app-browser` |
| `chrome` | `control-chrome` |
| `computer-use` | `computer-use` |
| `build-ios-apps` | `ios-app-intents`, `ios-debugger-agent`, `ios-ettrace-performance`, `ios-memgraph-leaks`, `ios-simulator-browser`, `swiftui-liquid-glass`, `swiftui-performance-audit`, `swiftui-ui-patterns`, `swiftui-view-refactor` |
| `build-web-apps` | `frontend-app-builder`, `frontend-testing-debugging`, `react-best-practices`, `shadcn-best-practices`, `stripe-best-practices`, `supabase-best-practices` |
| `figma` | `figma-code-connect`, `figma-create-new-file`, `figma-generate-design`, `figma-generate-diagram`, `figma-generate-library`, `figma-implement-motion`, `figma-swiftui`, `figma-use`, `figma-use-figjam`, `figma-use-motion`, `figma-use-slides` |
| `game-studio` | `game-playtest`, `game-studio`, `game-ui-frontend`, `phaser-2d-game`, `react-three-fiber-game`, `sprite-pipeline`, `three-webgl-game`, `web-3d-asset-pipeline`, `web-game-foundations` |
| `github` | `gh-address-comments`, `gh-fix-ci`, `github`, `yeet` |
| `google-drive` | `google-docs`, `google-drive`, `google-drive-comments`, `google-sheets`, `google-slides` |
| `heygen` | `heygen-avatar`, `heygen-video` |
| `hyperframes` | `gsap`, `hyperframes`, `hyperframes-cli`, `hyperframes-registry`, `website-to-hyperframes` |
| `remotion` | `remotion` |
| `product-design` | `audit`, `design-qa`, `get-context`, `ideate`, `image-to-code`, `index`, `prototype`, `research`, `share`, `url-to-code`, `user-context` |
| `documents` | `documents` |
| `pdf` | `pdf` |
| `presentations` | `presentations` |
| `spreadsheets` | `spreadsheets` |
| `template-creator` | `template-creator` |
