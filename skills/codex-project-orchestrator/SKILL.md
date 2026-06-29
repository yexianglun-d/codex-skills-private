---
name: codex-project-orchestrator
description: Advanced project orchestration for Codex. Use only when the user explicitly wants PRD decomposition, milestones, task boards, multi-thread or multi-worker coordination, integration planning, or a main-thread progress analysis. For simple cross-session project history, use $project-memory-manager instead.
---

# Codex Project Orchestrator

## 定位

这是高级项目编排 skill，不是默认项目记忆。

默认情况下，如果用户只是想知道“这个项目做过什么、现在到哪、下个会话怎么继续”，使用 `$project-memory-manager` 的轻量项目日志即可。

只有当用户明确需要以下能力时，才使用本 skill：

- 根据 PRD 或产品方案拆功能点。
- 生成里程碑、任务看板、验收标准。
- 多个 Codex 会话或 worker 并行开发，需要主线程规划边界。
- 盘点大项目进度，判断哪些模块已完成、阻塞或需要集成。
- 为开发线程生成明确的任务提示词。
- 做跨线程集成、验收或发布前状态分析。

## 默认角色

本 skill 默认按主线程执行。

主线程只做：

- 需求分析
- 功能拆分
- 里程碑和任务边界
- 进度判断
- 多线程协作提示
- 集成和验收计划

除非用户明确要求切换成开发线程，否则不要直接改业务代码。

## 和项目日志的关系

本 skill 不再维护复杂项目记忆结构。

如需保存项目状态，调用 `$project-memory-manager` 并写入轻量项目日志：

- `docs/project-memory/00-current-status.md`
- `docs/project-memory/01-activity-log.md`
- `docs/project-memory/02-decisions.md`
- `docs/project-memory/03-next-handoff.md`

正式 PRD 拆解结果可以先输出在回复里；只有用户要求落盘时，再写入项目日志。不要默认创建 feature map、task board、ownership、inbox 或 worker 审核流程。

## 工作方式

### 1. 先判断是否真的需要编排

如果只是普通开发、Bug 修复、提交推送、一次性问答、简单状态查询，不使用本 skill。

如果只是跨会话记录项目历史，改用 `$project-memory-manager`。

### 2. 拆需求

当用户给出 PRD、灵感或模糊目标时，输出最小可执行拆分：

- 目标
- 核心场景
- 功能点
- 模块边界
- 里程碑
- 可执行任务
- 验收标准
- 待确认问题

需求不完整时，基于现有信息做合理假设，并标明假设，不要因为没有正式 PRD 就停止。

### 3. 多线程协作

只有用户明确要多线程或 worker 并行时，才给出线程拆分。

每个线程建议必须包含：

- 任务目标
- 可改范围
- 禁止修改范围
- 需要先读的文件
- 验证方式
- 交接内容

不要生成无关 worker 建议，不要把窄任务扩成大路线图。

### 4. 交付

回复保持简洁：

- 当前判断
- 拆分结果
- 推荐下一步
- 需要确认的问题

如本轮产生需要保留的项目事实，再用 `$project-memory-manager` 更新轻量项目日志。
