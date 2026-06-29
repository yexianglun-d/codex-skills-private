# 项目记忆操作规则

## 读写边界

- 默认只读写 `docs/project-memory/`。
- 不把项目进度写入 skill 目录、全局 `AGENTS.md` 或聊天总结。
- 更新前先查看是否已有 `docs/project-memory/` 和旧 `docs/project/`。
- 已有内容优先保留，新增内容追加或局部更新，不整文件重写。
- 不覆盖用户或其他线程刚写的内容；遇到冲突先合并事实，再标注不确定点。

## 主线程规则

主线程负责：

- 维护 `00-start-here.md` 的当前入口摘要。
- 维护功能、任务、决策、验证、交接记录。
- 给 worker 或新线程生成明确提示词。
- 接收 worker 结果后归档到项目记忆。

主线程禁止：

- 把业务实现细节写成已完成但没有验证。
- 把外部服务、真实支付、短信、地图、医疗数据等 mock 成完成。
- 让多个 worker 同时拥有同一批文件写权限。

## Worker 规则

worker 默认不直接改核心项目记忆，除非主线程明确授权。worker 完成后必须返回：

- Task ID
- 完成内容
- 修改文件
- 验证方式和结果
- 遗留问题
- 对外影响
- 下一步建议

主线程再把这些内容写入 `04-task-board.md`、`07-thread-handoff.md`、`08-validation-log.md` 和必要的 `06-decision-log.md`。

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
