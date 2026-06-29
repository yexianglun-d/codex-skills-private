# 04 Task Board

每个任务应该适合一个 Codex 线程或 worker 独立处理。

| Task ID | Feature ID | 任务说明 | 类型 | 状态 | 负责线程 | 分支/Worktree | 可改文件范围 | 禁止修改 | 验收方式 | 最后更新 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| T-001 | F-001 |  | backend/frontend/docs/test/integration | TODO | 未分配 | 未创建 |  |  |  | 未更新 |

## 领取任务规则

- 状态必须是 `READY`。
- 依赖任务已完成或不阻塞。
- 可改文件范围清楚。
- 禁止修改范围清楚。
- 验收方式清楚。
- 不与其他线程修改同一批核心文件。

## 完成任务规则

- 状态更新为 `REVIEW` 或 `VERIFIED`。
- 写明验证记录。
- 在 `07-thread-handoff.md` 追加交接记录。
- 如果阻塞，状态改为 `BLOCKED` 并写明原因。
