# 项目记忆文件结构

默认目录：

```text
docs/project-memory/
  00-start-here.md
  01-product-brief.md
  02-feature-map.md
  03-milestones.md
  04-task-board.md
  05-architecture-map.md
  06-decision-log.md
  07-thread-handoff.md
  08-validation-log.md
  09-open-questions.md
  inbox/
    README.md
    thread-updates/
  sessions/
    README.md
```

## 文件职责

| 文件 | 职责 |
| --- | --- |
| `00-start-here.md` | 新线程第一入口，记录当前项目状态、下一步、关键真相源 |
| `01-product-brief.md` | 产品目标、用户、场景、边界、验收口径 |
| `02-feature-map.md` | 全部功能点和完成状态 |
| `03-milestones.md` | 依赖顺序、阶段目标、完成标准 |
| `04-task-board.md` | 可分派给线程/worker 的任务 |
| `05-architecture-map.md` | 模块边界、关键文件、数据流、外部依赖 |
| `06-decision-log.md` | 关键产品/技术/验收决策 |
| `07-thread-handoff.md` | 线程和 worker 之间的交接记录 |
| `08-validation-log.md` | 测试、构建、接口、浏览器、真实环境验证 |
| `09-open-questions.md` | 未确认问题、阻塞、需用户决策项 |
| `inbox/thread-updates/` | worker/新线程提交给主线程审核的事实上报 |
| `sessions/` | 每轮重要会话快照 |

## 新线程启动最低读取集

新线程继续项目前至少读取：

- `00-start-here.md`
- `04-task-board.md`
- `06-decision-log.md`
- `07-thread-handoff.md`
- 与当前任务相关的 `05-architecture-map.md` 部分

## 完成任务最低写入集

完成一个任务后至少更新：

- `07-thread-handoff.md`
- `08-validation-log.md`
- `inbox/thread-updates/`

然后由主线程审核并更新：

- `04-task-board.md`

如果产生关键决策，还要追加：

- `06-decision-log.md`

如果改变功能范围或架构边界，还要更新：

- `02-feature-map.md`
- `05-architecture-map.md`

这些核心文件默认由主线程写入；worker/新线程只上报事实。
