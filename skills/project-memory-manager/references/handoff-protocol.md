# 线程交接协议

## 交接原则

- 交接记录必须能让另一个 Codex 线程不依赖聊天历史继续工作。
- 交接必须写清楚事实、证据和未完成项，不写乐观判断。
- 交接只记录当前任务接续所必需的信息，不写泛化路线图和额外线程建议。
- worker 不直接拥有项目总状态；worker 把事实写入 `inbox/thread-updates/`，主线程负责审核归档。
- 并行 worker 必须有互不重叠的写入范围。
- 并行 worker 开始前必须在 `10-ownership-locks.md` 记录 `ACTIVE` ownership，或由主线程明确说明该任务只读。

## Worker 派发模板

```text
你是 Codex worker，不是主线程。

任务 ID:
目标:
可改文件范围:
禁止修改:
必须先读:
验收方式:
完成后返回:
- Task ID
- 完成内容
- 修改文件
- 验证方式和结果
- 对外影响
- 遗留问题
- 下一步仅限解除阻塞或接续当前任务所必需的动作
- 已写入或应写入的 inbox 文件路径

注意：
- 你不是唯一线程，不要回滚、覆盖或格式化他人改动。
- 不要扩大任务范围。
- 不要直接改 docs/project-memory 的核心状态文件，除非主线程明确授权。
- 默认只追加 docs/project-memory/inbox/thread-updates、07-thread-handoff.md、08-validation-log.md、sessions/。
```

## 新线程接手模板

```text
你是一个新的 Codex 线程。请先读取项目记忆，不要直接写代码。

必须先读：
- docs/project-memory/00-start-here.md
- docs/project-memory/04-task-board.md
- docs/project-memory/06-decision-log.md
- docs/project-memory/07-thread-handoff.md
- docs/project-memory/10-ownership-locks.md

本线程目标：

要求：
1. 先复述当前任务边界和已知风险。
2. 只处理指定任务或模块。
3. 修改前理解项目结构、调用链和已有风格。
4. 完成后返回标准交接报告。
```

## Handoff 记录模板

```md
## YYYY-MM-DD HH:mm / thread-or-worker-name

### 对应任务
- Task ID:
- Feature ID:

### 当前状态
- 状态:
- 分支/Worktree:
- 负责范围:

### 完成内容
-

### 修改文件
-

### 验证结果
- 命令:
- 手动验证:
- 结果:

### 对外影响
- 接口:
- 数据:
- 页面:
- 配置:
- 文档:

### 遗留问题
-

### 下个线程从哪里开始
只写当前任务的直接接续点；如果没有，写“无”。
-

### 禁止重复做
-
```

## Inbox 上报模板

```md
# Thread Update / T-xxx / thread-name / YYYY-MM-DD HH:mm

## Metadata

- Task ID:
- Feature ID:
- Thread:
- Branch/Worktree:
- Status: proposed / ready-for-review / blocked / verified

## Scope

- Owned files:
- Files changed:
- Files intentionally not touched:

## Facts To Merge

-

## Validation Evidence

- Commands:
- Manual checks:
- Result:

## Blockers

-

## Direct Next Step

-

## Noise Check

- Anything speculative or unrelated removed: yes/no
```

## 集成前检查

集成线程必须确认：

- `04-task-board.md` 中任务状态不是 `TODO` 或无边界的 `IN_PROGRESS`。
- `07-thread-handoff.md` 有对应任务记录。
- `08-validation-log.md` 有验证记录或说明无法验证原因。
- 修改文件范围没有和其他线程未集成工作冲突。
- 共享文件、迁移、路由、全局状态、接口协议已单独检查。

建议集成前运行：

```bash
bash "${CODEX_HOME:-$HOME/.codex}/skills/project-memory-manager/scripts/validate_project_memory.sh" .
```
