# Capability Map

Language: English | [中文](CAPABILITY_MAP.zh-CN.md)

Snapshot date: 2026-07-06

This file explains what each local skill and MCP is for. Use it before installing more overlapping tools.

## How To Read This Stack

There are three layers:

1. **Routers** decide which specialist workflow to use.
2. **Local skills** provide reusable instructions and constraints.
3. **MCP / plugins / CLI tools** provide external capabilities such as docs lookup, browser control, Figma, Firecrawl, GitHub, and Postman.

Do not treat every installed capability as always-on. The default rule is smallest useful set.

## Primary Routers

| Capability | Trigger | Use for | Do not use for |
| --- | --- | --- | --- |
| `coding-router` | auto | Bug fixes, build/test failures, new code, refactors, code review, Java/Vue discipline, third-party library usage, completion verification. | Pure UI direction, project memory, PRD orchestration, prose polish. |
| `ai-design-router` | auto | UI/UX, frontend visual design, Figma, motion, visual QA, named design references. | Backend/API/data bugs, non-visual frontend logic, deployment, Git tasks. |

## Project And Planning

| Capability | Trigger | Use for |
| --- | --- | --- |
| `project-memory-manager` | explicit only | Lightweight repo-local project journal under `docs/project-memory/`: current status, activity log, decisions, next handoff. |
| `codex-project-orchestrator` | explicit only | Formal PRD decomposition, milestones, task board, main-thread progress analysis, multi-thread / multi-worker coordination. |
| `product-co-creator` | default | Turning a product idea into MVP scope, flows, and requirements. |
| `technical-solution-designer` | default | Turning PRD/product plan into architecture, data model, API, module boundaries, and technical risks. |
| `implementation-planner` | default | Turning an accepted technical direction into phases, tasks, acceptance criteria, and verification plan. |

## Engineering Quality

| Capability | Trigger | Use for |
| --- | --- | --- |
| `root-cause-fixer` | default | Bug-fix protocol with evidence gates, diagnostic playbooks, root-cause proof, boundary-correct fixes, and validation gates. |
| `java-code-discipline` | auto | Java/Spring/MyBatis/Maven/Gradle code with compact Alibaba Java manual discipline and project-style reuse. |
| `vue-code-discipline` | auto | Vue/Nuxt/Vite/uni-app code discipline, component/data-flow rules, enterprise directory structure, and validation. |
| `playwright` | default | Terminal browser automation, form filling, snapshots, screenshots, and UI/data extraction. |
| `playwright-interactive` | default | Persistent browser or Electron interaction for iterative UI debugging. |

## Design, Figma, Motion, Assets

| Capability | Trigger | Use for |
| --- | --- | --- |
| `frontend-design` | default | Production-grade frontend UI creation and polish. |
| `taste-skill` | explicit only | Anti-template visual taste, critique, premium UI direction. |
| `ui-ux-pro-max` | explicit only | Private UI/UX intelligence and design-system reference work. |
| `figma` | default | Figma MCP read/design-to-code workflow: design context, screenshot, assets, and implementation guidance. |
| `figma-implement-design` | default | Implement UI from Figma designs. |
| `figma-create-design-system-rules` | default | Generate project-specific Figma design system rules. |
| `figma-code-connect-components` | default | Map Figma components to code components. |
| `gsap-*` | default | GSAP animation: core API, timelines, ScrollTrigger, plugins, React, non-React frameworks, utilities, and performance. |
| `hatch-pet` | default | Create, repair, validate, visually QA, and package Codex animated pets and spritesheets. |

## Documents, Writing, Context

| Capability | Trigger | Use for |
| --- | --- | --- |
| `humanizer` | explicit only | Humanizing or polishing prose/Markdown. Do not use for technical truth, bug reports, validation logs, or project memory. |
| `pdf` | default | Reading, creating, inspecting, rendering, and visually verifying PDF files. |
| `chronicle` | default | Local screen/history context when recent user activity matters. |
| `liu-ying-chat-style` | explicit only | Private relationship/chat style skill. Keep private. |

## MCP Servers

| MCP | Use for | Notes |
| --- | --- | --- |
| `context7` | Current documentation for libraries, frameworks, SDKs, APIs, CLIs, and cloud services. | Prefer over memory for version-specific technical usage. |
| `sequential-thinking` | Structured reasoning for complex bugs, architecture, migrations, multi-module refactors, and high-risk decisions. | Do not use for small local edits. |
| `firecrawl` | Public web data collection: websites, docs not covered by Context7, help centers, blogs, changelogs, competitor pages, web-to-Markdown/JSON. | Do not use for logged-in private pages, sensitive data, or visual/browser-state verification. |
| `figma` | Figma MCP operations. | Login may be required; current source snapshot showed Figma not logged in. |
| `github` | GitHub repository/PR/issue work through MCP. | Requires local `GITHUB_PAT_TOKEN` if needed. |
| `postman` | Postman collections/environments and API workflow. | Requires OAuth login on target machine. |
| `node_repl` | Persistent Node kernel and plugin-backed browser/Chrome control. | Codex app runtime managed; path may change with app versions. |
| `computer-use` | Local Mac app UI operation. | Plugin-managed by Codex bundled Computer Use. |

## Additional CLI Tools

| CLI | Use for | Restore |
| --- | --- | --- |
| `firecrawl` | Manual scrape/crawl/search/parse/monitor workflows from terminal. | `npm install -g firecrawl-cli`; then `firecrawl login --api-key "$FIRECRAWL_API_KEY"`. |

## Plugin-Managed Capabilities

Plugin caches provide additional skills, but the restore strategy is to install/enable plugins, not copy cache directories.

High-level groups:

| Plugin group | Use for |
| --- | --- |
| `browser` / `chrome` / `computer-use` | Browser and local app control. |
| `build-web-apps` | Frontend app building, testing/debugging, React, shadcn, Stripe, Supabase. |
| `build-ios-apps` / `build-macos-apps` | Apple platform build, run, debug, SwiftUI/AppKit, signing, packaging, performance. |
| `figma` / `product-design` | Figma operations, product design, prototyping, image-to-code, design QA. |
| `game-studio` | Browser game architecture, Phaser, Three.js, sprites, playtesting. |
| `github` | GitHub PR/issue/CI workflows. |
| `google-drive` | Google Drive, Docs, Sheets, Slides, comments. |
| `hyperframes` / `remotion` / `heygen` | Video, animation, website-to-video, avatar/video generation. |
| `superpowers` | Explicit engineering process toolbox: debugging, planning, TDD, worktrees, verification, reviews. |
| `documents` / `pdf` / `presentations` / `spreadsheets` | Office/PDF artifacts through primary runtime plugins. |

## Practical Routing Examples

| User intent | First route |
| --- | --- |
| "这个 bug 为什么发生，别糊弄" | `coding-router` -> `root-cause-fixer` |
| "Java 接口按项目风格修一下" | `coding-router` -> `java-code-discipline` |
| "Vue 页面逻辑和目录结构规范一下" | `coding-router` -> `vue-code-discipline` |
| "这个页面做得像 Linear / Apple" | `ai-design-router` -> design reference + frontend stack |
| "把 Figma 这个节点落到代码里" | `ai-design-router` -> Figma implementation + stack discipline |
| "这个项目上次做到哪了" | `project-memory-manager` |
| "把 PRD 拆成功能点、里程碑、多线程任务" | `codex-project-orchestrator` |
| "查这个库最新版怎么配置" | `context7` |
| "抓这个公开官网整理功能和价格" | `firecrawl` |
| "后台登录后的页面为什么不对" | Chrome / browser / Playwright, not Firecrawl |
