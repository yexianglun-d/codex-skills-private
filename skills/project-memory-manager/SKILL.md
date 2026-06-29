---
name: project-memory-manager
description: Manage repository-local Codex project memory files for explicit long-running or multi-thread development workflows. Use when the user asks to initialize docs/project-memory, record project state, create task boards, record decisions, write thread handoffs, log validation, generate session snapshots, or prepare a new Codex thread to continue a project. Do not use for ordinary one-off coding, commit/push, or generic status tasks unless the user explicitly asks to record them into project memory. This skill writes concise project memory only; it is not a coding implementation skill.
---

# Project Memory Manager

## 定位

这是一个项目级记忆管理 skill。它把长期项目上下文落到仓库内的 `docs/project-memory/`，让主线程、开发线程、worker、新线程都通过文件同步事实，而不是依赖聊天历史或模型记忆。

核心原则：只归档本轮任务相关事实、已验证证据、明确阻塞和用户已确认的下一步。不要为了“可能有用”生成泛化建议。

优先级：用户当轮要求 > 项目内更具体规则 > 本 skill > 通用记忆习惯。

## 职责边界

本 skill 只负责项目记忆文件：

- 初始化 `docs/project-memory/`
- 读取当前项目状态
- 更新功能地图、里程碑、任务看板、架构地图、决策日志、线程交接、验证日志和未决问题
- 生成会话快照
- 为新线程或 worker 生成交接提示词
- 校验项目记忆结构是否完整

本 skill 不负责：

- 直接实现业务代码
- 替代 `codex-project-orchestrator` 做任务调度
- 替代 `implementation-planner`、`technical-solution-designer`、`product-co-creator` 产出专业方案
- 在 skill 目录里保存某个项目的真实进度

## 使用时机

当任务涉及以下任一内容时使用：

- 用户要求“项目记忆”“长期记忆”“跨线程交接”“新线程继续”“记录当前进度”
- 项目需要连续开发、PRD 拆分、里程碑、任务看板或多 worker 协作
- 主线程需要把产品/技术/实现/验证结果归档
- worker 或开发线程完成后需要生成或整理 handoff
- 新线程接手前需要读取项目状态源

普通小改动、单次 Bug 修复、一次性问答、提交推送、只读状态查询不使用，除非用户明确要求“写入项目记忆”。

## 标准路径

默认项目记忆目录：

```text
docs/project-memory/
```

如果旧项目已经存在 `docs/project/`，先读取旧目录，不要自动迁移。只有用户明确要求结构治理或迁移时，才把有效内容合并到 `docs/project-memory/`。

## 工作流程

1. 修改前确认当前仓库、现有记忆目录、旧 `docs/project/` 目录和工作区状态。
2. 按任务加载参考文件：
   - 任意项目记忆读写：读 `references/operating-rules.md`。
   - 初始化或校验目录：读 `references/memory-file-schema.md`。
   - 跨线程或 worker 协作：读 `references/handoff-protocol.md`。
3. 初始化时优先运行：

```bash
bash /Users/deng/.codex/skills/project-memory-manager/scripts/init_project_memory.sh .
```

4. 更新时只写 `docs/project-memory/` 下的必要文件，不改业务代码。
5. 关键技术、产品、验收口径变化必须写入 `06-decision-log.md`。
6. 任务状态变化必须同步 `04-task-board.md`，必要时同步 `02-feature-map.md` 和 `03-milestones.md`。
7. 线程或 worker 结束必须追加 `07-thread-handoff.md`，并按需要追加 `08-validation-log.md` 和 `sessions/` 快照。
8. 完成后运行结构校验：

```bash
bash /Users/deng/.codex/skills/project-memory-manager/scripts/validate_project_memory.sh .
```

## 单一事实源规则

- `docs/project-memory/` 是项目状态源。
- `AGENTS.md` 只放长期协作规则，不放当前任务进度。
- 聊天历史、模型记忆、worker final message 只能作为输入，不能替代项目记忆文件。
- 同一项目不要同时维护多套任务看板；如果存在旧 `docs/project/`，需标注为 legacy 或合并迁移。
- 主线程默认拥有项目记忆写入权；worker 默认返回报告，由主线程归档。

## 噪音控制

以下内容默认不写入项目记忆：

- 和本轮任务没有直接关系的“以后可以做”“建议考虑”“上线前最好”等泛化建议。
- 没有用户确认、没有任务 ID、没有当前阻塞证据的线程建议。
- 大而全的路线图、技术栈迁移、重构建议、压测计划、上线清单。
- 从历史记忆里联想到但本轮没有重新验证的事实。

只有满足以下任一条件，才记录下一步：

- 用户明确要求规划下一步。
- 当前任务存在阻塞，且下一步是解除阻塞所必需。
- 当前任务已完成，且有一个明确的直接后续任务 ID。
- worker 交接必须说明下个线程从哪里继续。

提交/推送类任务如果需要归档，只记录分支、提交号、推送结果、验证命令、排除文件和真实告警，不扩展成项目路线图。

## 输出约束

最终回复保持简洁，优先说明：

- 更新了哪些项目记忆文件
- 为什么这样归档
- 如何验证结构或继续
- 哪些信息仍缺失
