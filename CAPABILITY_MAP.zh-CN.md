# 能力地图

语言：[English](CAPABILITY_MAP.md) | 中文

快照日期：2026-07-06

本文件说明每个本地 skill、MCP、CLI 和插件组分别用于什么场景。安装更多同类工具前，先看这里，避免重复和混乱。

## 如何理解这套能力

这套能力分三层：

1. **路由器**：判断当前任务该用哪个 specialist workflow。
2. **本地 skills**：提供可复用的协作规则、工程约束和工作流程。
3. **MCP / 插件 / CLI 工具**：提供外部能力，例如查文档、控制浏览器、操作 Figma、抓取网页、GitHub、Postman。

不要把所有已安装能力都当成默认开启。默认原则是：选择最小必要组合。

## 主要路由器

| 能力 | 触发策略 | 适合做什么 | 不适合做什么 |
| --- | --- | --- | --- |
| `coding-router` | 自动 | Bug、测试/构建失败、新代码、重构、代码评审、Java/Vue 规范、第三方库用法、完成前验证。 | 纯 UI 方向、项目记忆、PRD 编排、文本润色。 |
| `ai-design-router` | 自动 | UI/UX、前端视觉、Figma、动效、视觉验收、指定设计风格参考。 | 后端/API/数据 Bug、非视觉前端逻辑、部署、Git 任务。 |

## 项目与规划

| 能力 | 触发策略 | 用途 |
| --- | --- | --- |
| `project-memory-manager` | 主动调用 | 轻量项目日志：`docs/project-memory/` 下的当前状态、活动记录、关键决策、下次接续。 |
| `codex-project-orchestrator` | 主动调用 | 正式 PRD 拆解、里程碑、任务看板、主线程进度分析、多线程/多 worker 协作。 |
| `product-co-creator` | 默认 | 把产品想法整理成 MVP 范围、用户流程和需求。 |
| `technical-solution-designer` | 默认 | 把 PRD/产品方案转成架构、数据模型、API、模块边界和技术风险。 |
| `implementation-planner` | 默认 | 把已确认的技术方向拆成阶段、任务、验收标准和验证计划。 |

## 工程质量

| 能力 | 触发策略 | 用途 |
| --- | --- | --- |
| `root-cause-fixer` | 默认 | Bug 修复协议：证据闸门、诊断 playbook、根因证明、边界修复、验证闸门。 |
| `java-code-discipline` | 自动 | Java/Spring/MyBatis/Maven/Gradle 代码，压缩版阿里巴巴 Java 规范和项目风格复用。 |
| `vue-code-discipline` | 自动 | Vue/Nuxt/Vite/uni-app 代码规范、组件/数据流、企业级目录结构和验证。 |
| `playwright` | 默认 | 终端浏览器自动化、表单、截图、页面数据提取。 |
| `playwright-interactive` | 默认 | 持久化浏览器或 Electron 交互，适合迭代式 UI 调试。 |

## 设计、Figma、动效、资产

| 能力 | 触发策略 | 用途 |
| --- | --- | --- |
| `frontend-design` | 默认 | 生产级前端 UI 创建和视觉打磨。 |
| `taste-skill` | 主动调用 | 去模板感、视觉审美、premium UI 方向和评审。 |
| `ui-ux-pro-max` | 主动调用 | 私有 UI/UX 知识和设计系统参考。 |
| `figma` | 默认 | Figma MCP：读取设计上下文、截图、资源、设计到代码辅助。 |
| `figma-implement-design` | 默认 | 从 Figma 设计实现 UI。 |
| `figma-create-design-system-rules` | 默认 | 为项目生成 Figma 设计系统规则。 |
| `figma-code-connect-components` | 默认 | 建立 Figma 组件和代码组件映射。 |
| `gsap-*` | 默认 | GSAP 动效：核心 API、timeline、ScrollTrigger、插件、React、非 React 框架、工具和性能。 |
| `hatch-pet` | 默认 | 创建、修复、验证、视觉 QA 和打包 Codex 动态宠物/精灵图。 |

## 文档、写作、上下文

| 能力 | 触发策略 | 用途 |
| --- | --- | --- |
| `humanizer` | 主动调用 | 文案或 Markdown 去 AI 味润色。不要用于技术事实、Bug 报告、验证日志或项目记忆。 |
| `pdf` | 默认 | PDF 阅读、创建、检查、渲染和视觉验证。 |
| `chronicle` | 默认 | 当最近屏幕/历史操作对任务有帮助时，读取本机上下文。 |
| `liu-ying-chat-style` | 主动调用 | 私人聊天风格 skill，保持私有。 |

## MCP Servers

| MCP | 用途 | 备注 |
| --- | --- | --- |
| `context7` | 查询库、框架、SDK、API、CLI、云服务的当前文档。 | 版本相关技术用法优先使用它。 |
| `sequential-thinking` | 复杂 Bug、架构、迁移、多模块重构、高风险决策的结构化分析。 | 小改动不要默认使用。 |
| `firecrawl` | 公开网页资料采集：官网、Context7 未覆盖文档、帮助中心、博客、更新日志、竞品页面、网页转 Markdown/JSON。 | 不用于登录后私密页面、敏感数据、视觉/浏览器状态验证。 |
| `figma` | Figma MCP 操作。 | 可能需要登录；当前源机器快照显示 Figma 未登录。 |
| `github` | GitHub 仓库、PR、issue 工作。 | 如需使用，需要本地 `GITHUB_PAT_TOKEN`。 |
| `postman` | Postman collection、environment 和 API 工作流。 | 目标机器需要 OAuth 登录。 |
| `node_repl` | 持久化 Node kernel，以及插件支持的 browser/Chrome 控制。 | Codex App 运行时管理，路径可能随版本变化。 |
| `computer-use` | 操作本地 Mac App UI。 | Codex bundled Computer Use 插件管理。 |

## 额外 CLI 工具

| CLI | 用途 | 恢复方式 |
| --- | --- | --- |
| `firecrawl` | 终端手动 scrape/crawl/search/parse/monitor。 | `npm install -g firecrawl-cli`，然后 `firecrawl login --api-key "$FIRECRAWL_API_KEY"`。 |

## 插件管理能力

插件缓存提供额外 skills，但恢复策略是安装/启用对应插件，不要复制缓存目录。

| 插件组 | 用途 |
| --- | --- |
| `browser` / `chrome` / `computer-use` | 浏览器和本地 App 控制。 |
| `build-web-apps` | 前端应用构建、测试调试、React、shadcn、Stripe、Supabase。 |
| `build-ios-apps` / `build-macos-apps` | Apple 平台构建、运行、调试、SwiftUI/AppKit、签名、打包、性能。 |
| `figma` / `product-design` | Figma 操作、产品设计、原型、image-to-code、设计 QA。 |
| `game-studio` | 浏览器游戏架构、Phaser、Three.js、精灵图、试玩测试。 |
| `github` | GitHub PR/issue/CI 工作流。 |
| `google-drive` | Google Drive、Docs、Sheets、Slides、评论。 |
| `hyperframes` / `remotion` / `heygen` | 视频、动效、网站转视频、头像/视频生成。 |
| `superpowers` | 主动调用的工程流程工具箱：debugging、planning、TDD、worktrees、verification、review。 |
| `documents` / `pdf` / `presentations` / `spreadsheets` | Office/PDF 文件处理。 |

## 实用路由示例

| 用户意图 | 首选路线 |
| --- | --- |
| “这个 bug 为什么发生，别糊弄” | `coding-router` -> `root-cause-fixer` |
| “Java 接口按项目风格修一下” | `coding-router` -> `java-code-discipline` |
| “Vue 页面逻辑和目录结构规范一下” | `coding-router` -> `vue-code-discipline` |
| “这个页面做得像 Linear / Apple” | `ai-design-router` -> 设计参考 + 前端栈 |
| “把 Figma 这个节点落到代码里” | `ai-design-router` -> Figma 实现 + 技术栈规范 |
| “这个项目上次做到哪了” | `project-memory-manager` |
| “把 PRD 拆成功能点、里程碑、多线程任务” | `codex-project-orchestrator` |
| “查这个库最新版怎么配置” | `context7` |
| “抓这个公开官网整理功能和价格” | `firecrawl` |
| “后台登录后的页面为什么不对” | Chrome / browser / Playwright，不用 Firecrawl |
