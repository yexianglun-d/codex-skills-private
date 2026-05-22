# 03 任务看板

每个 Codex 线程从这里领取任务，并在结束时更新状态。

| Task ID | 对应功能点 | 任务说明 | 类型 | 状态 | 负责线程 | 分支/Worktree | 涉及文件范围 | 验收方式 | 最后更新 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| T-001 | F-001 | 示例：实现登录接口 | backend | TODO | 未分配 | 未创建 | server/auth | 单元测试 + 接口测试 | 未更新 |

## 任务类型

- backend
- frontend
- mobile
- database
- api-doc
- integration
- test
- devops
- docs

## 领取任务规则

线程开工前必须确认：

- 任务状态是 `READY`
- 依赖任务已完成或不阻塞
- 涉及文件范围清楚
- 验收方式清楚
- 不与其他线程修改同一批核心文件

## 完成任务规则

线程结束前必须做：

- 把状态更新为 `REVIEW` 或 `VERIFIED`
- 填写验证记录
- 在 `04-thread-handoff.md` 新增交接记录
- 如果有阻塞，状态改为 `BLOCKED`，并写明阻塞原因
