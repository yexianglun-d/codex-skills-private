---
name: project-memory-manager
description: Maintain a lightweight repository-local project journal for Codex sessions. Use when the user wants to know what a project has done, continue a project in a new Codex conversation, record this session, summarize current status, or keep simple cross-session context under docs/project-memory. Do not use for ordinary one-off questions or tiny edits unless the user asks to record project history.
---

# Project Memory Manager

## 定位

这是一个轻量项目日志 skill。它只解决一个问题：

> 一个项目下面有很多 Codex 会话时，后续会话怎么快速知道这个项目做过什么、现在停在哪、下一步从哪里继续。

它不是项目管理系统，不默认拆 PRD、不默认创建任务看板、不做 ownership 锁、不做 worker inbox，也不替代代码审查、Git 分支、测试或真实验证。

## 默认文件

默认目录：`docs/project-memory/`

只维护 4 个文件：

- `00-current-status.md`：一页读懂当前项目状态。
- `01-activity-log.md`：按时间追加每个会话真正做过的事。
- `02-decisions.md`：只记录会影响后续判断的关键决定。
- `03-next-handoff.md`：给下一个会话看的最短接续说明。

## 使用时机

使用本 skill：

- 用户问“这个项目之前做了什么”“现在进度到哪”“下个会话怎么继续”。
- 用户说要在多个 Codex 会话之间同步项目上下文。
- 用户要求记录本次工作、更新项目记忆、初始化项目记忆。
- 当前任务不是一次性小问题，后续很可能还会继续做。

不使用本 skill：

- 普通问答、翻译、解释概念。
- 很小的改文案、局部修复、单次命令。
- 用户只要求提交、推送、查看状态，且没有要求记录项目历史。
- 需要正式 PRD 拆解、里程碑、任务看板、多 worker 协调时，改用 `$codex-project-orchestrator`。

## 会话开始

如果项目已有 `docs/project-memory/`，开始前读取：

1. `00-current-status.md`
2. `03-next-handoff.md`
3. `01-activity-log.md` 最近 3 条
4. 和本轮任务直接相关的代码或文档

如果目录不存在，且用户要求记录项目历史或继续长期项目，初始化：

```bash
bash "${CODEX_HOME:-$HOME/.codex}/skills/project-memory-manager/scripts/init_project_memory.sh" .
```

## 会话结束

只在本轮确实产生项目事实时更新：

1. 更新 `00-current-status.md` 的当前状态。
2. 向 `01-activity-log.md` 追加本次会话摘要。
3. 如有关键产品/技术/验收决定，追加到 `02-decisions.md`。
4. 更新 `03-next-handoff.md`，写清下个会话最该接哪里。

每条活动记录只写：

- 做了什么
- 修改文件
- 验证方式
- 验证结果
- 没做完/风险
- 下次继续

不要写泛化建议、长路线图、无关优化、未确认计划。

## 初始化与校验

初始化：

```bash
bash "${CODEX_HOME:-$HOME/.codex}/skills/project-memory-manager/scripts/init_project_memory.sh" .
```

覆盖重建：

```bash
bash "${CODEX_HOME:-$HOME/.codex}/skills/project-memory-manager/scripts/init_project_memory.sh" . --force
```

校验结构：

```bash
bash "${CODEX_HOME:-$HOME/.codex}/skills/project-memory-manager/scripts/validate_project_memory.sh" .
```

## 输出要求

回复保持简洁，优先说明：

- 读了哪些项目日志文件
- 更新了哪些项目日志文件
- 本次新增了什么项目事实
- 下个会话从哪里继续
