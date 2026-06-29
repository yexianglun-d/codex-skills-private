# 项目记忆操作规则

## 读写边界

- 默认只读写 `docs/project-memory/`。
- 不把项目进度写入 skill 目录、全局 `AGENTS.md` 或聊天总结。
- 更新前先查看是否已有 `docs/project-memory/` 和旧 `docs/project/`。
- 已有内容优先保留，新增内容追加或局部更新，不整文件重写。
- 不覆盖用户或其他线程刚写的内容；遇到冲突先合并事实，再标注不确定点。
- 只记录本轮任务直接相关事实，不把“可能有用”的建议写入项目记忆。
- 历史记忆只能作为线索；未在本轮确认的内容不要写成当前事实。

## 写权限模型

| 路径 | 默认写入者 | 规则 |
| --- | --- | --- |
| `00-start-here.md` | 主线程 | 权威入口摘要 |
| `02-feature-map.md` | 主线程 | 功能状态总表 |
| `03-milestones.md` | 主线程 | 里程碑状态 |
| `04-task-board.md` | 主线程 | 任务分派、状态、文件边界 |
| `05-architecture-map.md` | 主线程 | 架构和关键文件索引 |
| `06-decision-log.md` | 主线程 | 已确认决策 |
| `07-thread-handoff.md` | 所有线程追加 | 只追加交接事实 |
| `08-validation-log.md` | 所有线程追加 | 只追加验证证据 |
| `09-open-questions.md` | 主线程 | 未决问题总表 |
| `10-ownership-locks.md` | 主线程维护，worker 领取前追加 | 当前活跃任务的文件/目录写入权 |
| `inbox/thread-updates/` | worker/新线程 | 待主线程审核归档的上报 |
| `inbox/archive/` | 主线程 | 已审核的 inbox 上报 |
| `sessions/` | 所有线程追加 | 会话快照 |

## 噪音控制

默认不记录：

- 泛化的后续建议，例如“可以考虑压测”“可以整理上线清单”“可以重构模块”。
- 和本轮任务无直接关系的线程建议。
- 未绑定 Task ID、未绑定当前阻塞、未被用户确认的路线图。
- 只因为模型联想到而产生的工程优化项。

只有在以下情况下记录下一步：

- 用户明确要求规划下一步。
- 当前任务有阻塞，下一步是解除阻塞所必需。
- 当前任务完成后存在明确直接后续任务 ID。
- 这是给 worker 或新线程的必要交接入口。

提交/推送类任务的归档范围只包括：分支、远端、提交号、推送结果、验证命令、被排除的本地配置/敏感文件、真实告警和用户偏好修正。

## 主线程规则

主线程负责：

- 维护 `00-start-here.md` 的当前入口摘要。
- 维护功能、任务、决策、验证、交接记录。
- 给 worker 或新线程生成明确提示词。
- 接收 worker 结果后，先进入 `inbox/thread-updates/` 或读取已有 inbox，再归档到项目记忆。
- 审核 inbox 上报，筛掉噪音、未验证判断和越界建议。

主线程禁止：

- 把业务实现细节写成已完成但没有验证。
- 把外部服务、真实支付、短信、地图、医疗数据等 mock 成完成。
- 让多个 worker 同时拥有同一批文件写权限。

并行派发前，主线程必须检查或更新 `10-ownership-locks.md`：

- 同一 `Owned Path` 不能有两个 `ACTIVE` 写锁。
- 父子路径视为冲突，例如 `src` 与 `src/auth`。
- `write` 与 `integration` 互斥；`integration` 与 `write/review/integration` 互斥。
- worker 结束、任务取消或集成完成后，把对应锁改为 `RELEASED`、`BLOCKED` 或 `STALE`。
- 若任务必须共享路由、迁移、全局状态、公共组件等核心文件，先拆出集成任务，不给多个 worker 同时写。

领取 ownership 优先用脚本，避免手写表格行写错位置：

```bash
bash "${CODEX_HOME:-$HOME/.codex}/skills/project-memory-manager/scripts/claim_ownership.sh" . --task T-001 --owner worker-name --path src/module --mode write
```

释放 ownership 用脚本：

```bash
bash "${CODEX_HOME:-$HOME/.codex}/skills/project-memory-manager/scripts/release_ownership.sh" . --lock L-002 --status RELEASED --note "worker done"
```

记录验证证据用脚本：

```bash
bash "${CODEX_HOME:-$HOME/.codex}/skills/project-memory-manager/scripts/log_validation.sh" . --task T-001 --scope "auth work" --method "npm test" --result "passed" --evidence "local log"
```

## Worker 规则

worker 默认不直接改核心项目记忆，除非主线程明确授权。worker 完成后必须追加或返回一份 `inbox/thread-updates/` 上报，包含：

- Task ID
- 完成内容
- 修改文件
- 验证方式和结果
- 遗留问题
- 对外影响
- 下一步仅限解除阻塞或接续当前任务所必需的动作

worker 可以追加 `07-thread-handoff.md` 和 `08-validation-log.md`；核心状态文件由主线程归档。

主线程筛掉无关建议后，再把必要事实写入 `04-task-board.md`、`07-thread-handoff.md`、`08-validation-log.md` 和必要的 `06-decision-log.md`。

`VERIFIED` / `DONE` 任务必须有三类证据：

- `08-validation-log.md` 的同 Task ID 验证记录。
- `07-thread-handoff.md` 的同 Task ID 交接记录。
- `inbox/archive/` 的同 Task ID 且 `Review Status: accepted` 归档。

## Inbox 归档流程

1. worker/新线程完成任务后，在 `inbox/thread-updates/` 新增一份上报。
2. 主线程读取上报，检查 Task ID、文件范围、验证证据和噪音内容。
3. 主线程只把已确认事实合并到核心状态文件。
4. 已处理上报移动或标记为 `accepted`、`partially-accepted`、`rejected`。
5. 不确定内容进入 `09-open-questions.md`，不要写成已完成事实。

建议用脚本完成归档：

```bash
bash "${CODEX_HOME:-$HOME/.codex}/skills/project-memory-manager/scripts/reconcile_inbox_update.sh" . --file docs/project-memory/inbox/thread-updates/T-xxx.md --status accepted --reviewer main-thread --archive
```

## 状态规则

只使用这些状态：

| 状态 | 含义 |
| --- | --- |
| TODO | 已识别，但还不可直接开工 |
| READY | 依赖、边界、验收都清楚，可以开工 |
| IN_PROGRESS | 正在处理 |
| REVIEW | 已改代码或文档，等待评审或集成 |
| VERIFIED | 已完成局部验证，但未完全并入主链路 |
| DONE | 已实现、验证、文档同步并集成 |
| BLOCKED | 阻塞，必须记录原因和下一步 |

`DONE` 必须同时具备实现、验收证据、验证记录、必要文档同步和无隐藏外部依赖。

## 更新粒度

- 功能范围变化：更新 `02-feature-map.md`。
- 开发顺序变化：更新 `03-milestones.md`。
- 可执行任务变化：更新 `04-task-board.md`。
- 技术结构或关键文件变化：更新 `05-architecture-map.md`。
- 产品/技术/验收关键决策：追加 `06-decision-log.md`。
- 跨线程交接：追加 `07-thread-handoff.md`。
- 测试、构建、接口、手动验证：追加 `08-validation-log.md`。
- 未确认问题：更新 `09-open-questions.md`。
- 每轮重要工作结束：追加 `sessions/YYYY-MM-DD-*.md`。
