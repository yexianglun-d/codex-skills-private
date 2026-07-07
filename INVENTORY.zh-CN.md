# 清单

语言：[English](INVENTORY.md) | 中文

快照日期：2026-07-06

本清单会尽量去重记录。本地 skills 按目录列出；插件缓存则按 source/version 条目列出，因为同一个插件名可能同时出现在 curated 和 curated-remote 缓存中。

## 非系统本地 Skills

这些内容 vendored 在 `skills/` 下，可以直接恢复。

| Skill | 触发策略 | 说明 |
| --- | --- | --- |
| `ai-design-router` | 自动 | UI、UX、前端视觉、Figma、动效、视觉 QA、指定 `DESIGN.md` 风格参考的路由器。包含 `VoltAgent/awesome-design-md` 参考；`typeui` 仅作为候选。 |
| `chronicle` | 默认 | 本机屏幕/历史上下文 skill。 |
| `codex-project-orchestrator` | 主动调用 | 高级 PRD 拆解、里程碑、任务看板、多线程协作、进度审计和集成计划。轻量项目历史不够时才用。 |
| `coding-router` | 自动 | 代码工程路由器：Bug、语言规范、计划、文档/MCP、验证 workflow。避免默认叠加 root-cause、Java/Vue discipline、planning、superpowers。 |
| `figma` | 默认 | Figma MCP 读取和 design-to-code 辅助。 |
| `figma-code-connect-components` | 默认 | Figma Code Connect 组件映射。 |
| `figma-create-design-system-rules` | 默认 | 生成项目级 Figma 设计系统规则。 |
| `figma-implement-design` | 默认 | 从 Figma 设计实现 UI。 |
| `frontend-design` | 默认 | 生产级前端 UI 设计。 |
| `gsap-core` | 默认 | GSAP 核心 tween API。 |
| `gsap-frameworks` | 默认 | GSAP 在 Vue、Svelte 和其他非 React 框架中的用法。 |
| `gsap-performance` | 默认 | GSAP 性能和卡顿优化。 |
| `gsap-plugins` | 默认 | GSAP 插件，例如 Flip、Draggable、SplitText、SVG plugins。 |
| `gsap-react` | 默认 | GSAP 在 React 和 Next.js 中的用法。 |
| `gsap-scrolltrigger` | 默认 | ScrollTrigger 和滚动驱动动画。 |
| `gsap-timeline` | 默认 | GSAP timeline 编排。 |
| `gsap-utils` | 默认 | `gsap.utils` 工具。 |
| `hatch-pet` | 默认 | 创建、修复、验证、QA、打包 Codex 动态宠物和 spritesheet。 |
| `humanizer` | 主动调用 | 文案或 Markdown 去 AI 味润色。仅在明确要求 humanize、改写、润色时使用。 |
| `implementation-planner` | 默认 | 技术方案到开发阶段和任务拆解。 |
| `java-code-discipline` | 自动 | Java 根因定位、项目风格、最小改动纪律。 |
| `liu-ying-chat-style` | 主动调用 | 私人关系/聊天风格 skill，保持私有。 |
| `pdf` | 默认 | PDF 阅读、渲染、布局工作流。 |
| `playwright` | 默认 | 终端浏览器自动化。 |
| `playwright-interactive` | 默认 | 持久化浏览器/Electron 交互。 |
| `product-co-creator` | 默认 | 产品想法到 MVP、流程、需求、路线图。 |
| `project-memory-manager` | 主动调用 | 仓库本地轻量项目日志：当前状态、活动日志、决策、下次交接。 |
| `root-cause-fixer` | 默认 | 带证据闸门的 Bug 诊断和完整修复：诊断 playbook、根因证明、验证闸门。 |
| `taste-skill` | 主动调用 | 去模板感前端视觉方向；主 skill 名是 `design-taste-frontend`。 |
| `technical-solution-designer` | 默认 | PRD/产品方案到技术架构和 API。 |
| `ui-ux-pro-max` | 主动调用 | 私有 UI/UX intelligence 和设计系统 skill。 |
| `vue-code-discipline` | 自动 | Vue 代码纪律、企业级目录结构、组件/数据流规则和验证。 |

## 不做 Vendored 备份的系统 Skills

这些预期来自 Codex 或系统安装。

| Skill |
| --- |
| `imagegen` |
| `openai-docs` |
| `plugin-creator` |
| `skill-creator` |
| `skill-installer` |

## MCP Servers

| MCP | 源机器状态 | 恢复方式 |
| --- | --- | --- |
| `computer-use` | 已启用 | Codex bundled Computer Use 插件管理。 |
| `context7` | 已启用 | 恢复配置后，本地设置 `CONTEXT7_API_KEY`。 |
| `firecrawl` | 已启用 | 使用 `npx -y firecrawl-mcp` 恢复，然后本地设置 `FIRECRAWL_API_KEY`。 |
| `figma` | 已启用，未登录 | 恢复 URL；需要设计操作时在 Figma/Codex 中认证。 |
| `github` | 已启用，使用 bearer token env | 恢复 URL，如需使用则本地设置 `GITHUB_PAT_TOKEN`。 |
| `node_repl` | 已启用 | Codex App runtime 管理；目标机器需检查路径。 |
| `sequential-thinking` | 已启用 | `npx -y @modelcontextprotocol/server-sequential-thinking`。 |
| `postman` | 已启用，OAuth | 恢复 URL，必要时执行 `codex mcp login postman`。 |

## 额外本地 CLI 工具

| 工具 | 源机器版本 | 恢复方式 |
| --- | --- | --- |
| `firecrawl` | `1.19.24` | `npm install -g firecrawl-cli`，然后 `firecrawl login --api-key "$FIRECRAWL_API_KEY"`。 |

## 插件

源机器观察到的插件缓存条目。这里按 source/version 记录，同一个插件名可能有多个缓存来源。

| 插件 | 版本 / Build | 来源类型 |
| --- | --- | --- |
| `browser` | `26.623.101652` | openai-bundled |
| `chrome` | `26.623.101652` | openai-bundled |
| `computer-use` | `1.0.857` | openai-bundled |
| `build-ios-apps` | `0.1.2` | openai-curated-remote |
| `build-macos-apps` | `0.1.4` | openai-curated-remote |
| `figma` | `2.0.12` | openai-curated-remote |
| `google-drive` | `0.1.7` | openai-curated-remote |
| `hyperframes` | `0.1.2` | openai-curated-remote |
| `product-design` | `0.1.47` | openai-curated-remote |
| `superpowers` | `5.1.4` | openai-curated-remote |
| `build-web-apps` | `d6169bef` | openai-curated |
| `figma` | `d6169bef` | openai-curated |
| `game-studio` | `d6169bef` | openai-curated |
| `github` | `d6169bef` | openai-curated |
| `heygen` | `d6169bef` | openai-curated |
| `hyperframes` | `d6169bef` | openai-curated |
| `remotion` | `d6169bef` | openai-curated |
| `documents` | `26.630.12135` | openai-primary-runtime |
| `pdf` | `26.630.12135` | openai-primary-runtime |
| `presentations` | `26.630.12135` | openai-primary-runtime |
| `spreadsheets` | `26.630.12135` | openai-primary-runtime |
| `template-creator` | `26.630.12135` | openai-primary-runtime |

## 插件提供的 Skill 组

这些不在 `skills/` 下做 vendored 备份；恢复时安装/启用对应插件。

| 插件 | Skills |
| --- | --- |
| `browser` | `control-in-app-browser` |
| `chrome` | `control-chrome` |
| `computer-use` | `computer-use` |
| `build-ios-apps` | `ios-app-intents`, `ios-debugger-agent`, `ios-ettrace-performance`, `ios-memgraph-leaks`, `ios-simulator-browser`, `swiftui-liquid-glass`, `swiftui-performance-audit`, `swiftui-ui-patterns`, `swiftui-view-refactor` |
| `build-macos-apps` | `appkit-interop`, `build-run-debug`, `liquid-glass`, `packaging-notarization`, `signing-entitlements`, `swiftpm-macos`, `swiftui-patterns`, `telemetry`, `test-triage`, `view-refactor`, `window-management` |
| `build-web-apps` | `frontend-app-builder`, `frontend-testing-debugging`, `react-best-practices`, `shadcn-best-practices`, `stripe-best-practices`, `supabase-best-practices` |
| `figma` | `figma-code-connect`, `figma-create-new-file`, `figma-generate-design`, `figma-generate-diagram`, `figma-generate-library`, `figma-implement-motion`, `figma-swiftui`, `figma-use`, `figma-use-figjam`, `figma-use-motion`, `figma-use-slides` |
| `game-studio` | `game-playtest`, `game-studio`, `game-ui-frontend`, `phaser-2d-game`, `react-three-fiber-game`, `sprite-pipeline`, `three-webgl-game`, `web-3d-asset-pipeline`, `web-game-foundations` |
| `github` | `gh-address-comments`, `gh-fix-ci`, `github`, `yeet` |
| `google-drive` | `google-docs`, `google-drive`, `google-drive-comments`, `google-sheets`, `google-slides` |
| `heygen` | `heygen-avatar`, `heygen-video` |
| `hyperframes` | `gsap`, `hyperframes`, `hyperframes-cli`, `hyperframes-registry`, `website-to-hyperframes` |
| `remotion` | `remotion` |
| `product-design` | `audit`, `design-qa`, `get-context`, `ideate`, `image-to-code`, `index`, `prototype`, `research`, `share`, `url-to-code`, `user-context` |
| `superpowers` | `brainstorming`, `dispatching-parallel-agents`, `executing-plans`, `finishing-a-development-branch`, `receiving-code-review`, `requesting-code-review`, `subagent-driven-development`, `systematic-debugging`, `test-driven-development`, `using-git-worktrees`, `using-superpowers`, `verification-before-completion`, `writing-plans`, `writing-skills` |
| `documents` | `documents` |
| `pdf` | `pdf` |
| `presentations` | `presentations` |
| `spreadsheets` | `spreadsheets` |
| `template-creator` | `template-creator` |
