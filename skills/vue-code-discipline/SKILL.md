---
name: vue-code-discipline
description: Use this skill for Vue 2/Vue 3 development, Vue bug fixes, refactors, code reviews, component changes, Composition API, script setup, Pinia/Vuex state, router, form, API, style, build, lint, and frontend engineering quality work. This is a compact constraint workflow for Vue code discipline, not a visual design skill.
---

# Vue Code Discipline

## 定位

这是一个约束型 Vue skill，用来把 Vue 官方风格指南、eslint-plugin-vue 常见约束和前端工程实践压缩成可执行检查流程。它不替代项目内 `AGENTS.md`、README、开发规范、ESLint、Prettier、TypeScript 配置或用户当轮要求。

优先级：用户当轮要求 > 项目内更具体规则 > 本 skill > 通用 Vue 经验。

## 使用场景

当任务涉及以下内容时使用：

- Vue 2 / Vue 3 / Nuxt / Vite Vue 项目中的代码编写、修复、重构或评审。
- `.vue` 单文件组件、组件拆分、页面组件、业务组件、基础组件、composable、store、router、API 请求、表单、权限、状态和样式变更。
- Composition API、Options API、`<script setup>`、`defineProps`、`defineEmits`、Pinia / Vuex、Element Plus、Ant Design Vue、uni-app Vue 代码。
- 用户强调“符合 Vue 规范”“符合项目风格”“不要 AI 模板代码”“先定位根因”“不要临时兜底”。

如果用户明确要求只分析、只评审或只规划，不要直接改代码。

## 工作流程

1. 先判断任务类型：新增功能、Bug 修复、重构、代码评审、UI 交互修复、依赖或配置变更。
2. 修改前读取最小必要上下文：路由入口、页面组件、子组件、store、API 封装、样式体系、目录结构、构建脚本和同类实现。
3. 按任务加载参考清单：
   - 任意 Vue 代码变更：读 `references/pre-change-checklist.md`。
   - Bug 修复：读 `references/vue-bug-fix-discipline.md`。
   - 代码评审或重构：读 `references/vue-review-checklist.md`。
   - 需要贴合项目风格：读 `references/project-style-checklist.md`。
   - 新项目、模块新增、目录调整或文件放置不明确：读 `references/enterprise-directory-structure.md`。
4. 优先复用项目已有组件、composable、store、API client、类型定义、常量、校验器、错误处理和样式方案。
5. 只做完成目标所需的最小修改，不借机迁移 API 风格、替换 UI 库、引入新状态库或格式化无关文件。
6. 修改后按相关清单自查，再运行与改动范围匹配的 `lint`、`type-check`、单元测试、构建或浏览器验证。
7. 回复默认说明：改了什么、为什么这样改、如何验证、剩余问题。

## Vue 硬性约束

- 遵循当前项目已选 API 风格。项目已使用 Composition API / `<script setup>` 时不要混回 Options API；Vue 2 项目不要擅自引入 Vue 3 写法。
- `props` 和 `emits` 必须清晰声明；不要直接修改 `props`，需要本地状态时显式派生。
- `v-for` 必须使用稳定 `key`；避免在同一节点同时使用 `v-if` 和 `v-for`。
- 组件职责保持单一。页面编排、业务逻辑、可复用 UI、请求封装、状态管理不要堆在一个大组件里。
- 新项目或新增模块按企业级目录结构落位；已有项目先遵循当前目录风格，只有用户明确要求结构治理时才迁移历史文件。
- 异步请求必须有符合项目风格的 loading、error、empty、取消或竞态处理；不要用静默失败掩盖问题。
- 表单校验、权限判断、路由守卫、状态同步和错误提示优先走项目已有机制。
- 样式遵循项目已有方案，不混乱新增 Tailwind、Less、Sass、CSS Modules、inline style 或全局样式。
- 不把视觉设计 skill 的审美偏好强行写进业务组件；UI 改动必须服务当前需求和项目风格。

## 硬性禁止

- 不理解路由、组件树、数据流、store、API 封装和样式体系就直接改代码。
- 用硬编码、吞异常、临时 if-else、默认值掩盖、延迟定时器、强制刷新页面等方式只修表象。
- 为一个局部问题无必要新增状态库、事件总线、全局 mixin、插件、复杂 composable 或依赖。
- 顺手重构、格式化、重命名、迁移无关组件。
- 把 mock 数据、静态截图、单个页面能打开描述成真实功能完成。
- 覆盖、回滚或格式化用户或其他线程的未提交改动。

## 输出约束

最终回复保持简洁，优先使用：

- 改了什么
- 为什么这样改
- 如何验证
- 剩余问题

如果无法完成验证，必须说明原因、已做替代检查和剩余风险。
