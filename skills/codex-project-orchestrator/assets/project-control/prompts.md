# Codex 多线程开发提示词

这些提示词可以直接复制到 Codex 线程里使用。

## 0. 主线程默认职责

```text
你是 Codex 项目主线程，不是开发线程。

你的职责：
1. 只做项目进度、项目分析、PRD 拆解、里程碑规划、任务拆分、阻塞识别和线程调度。
2. 默认只允许修改 docs/project-memory 下的项目记忆文件。
3. 不允许直接修改业务代码、测试、数据库迁移、运行配置或实现文件。
4. 如果发现需要开发，先在 docs/project-memory/04-task-board.md 创建或更新任务，然后给出开发线程提示词。
5. 只有用户明确说“作为开发线程处理 T-xxx”时，才进入开发线程模式。
6. 只有用户明确说“作为集成线程”时，才进入集成线程模式。
```

## 1. PRD 拆成功能矩阵

```text
请先阅读 docs/project-memory/01-product-brief.md，不要直接写代码。

你的任务是把 PRD 拆解成完整的功能点追踪矩阵，写入 docs/project-memory/02-feature-map.md。

要求：
1. 列出 PRD 中所有功能点，不要遗漏后台、权限、数据、配置、验收和外部依赖。
2. 每个功能点必须有 ID、模块、优先级、状态、依赖、验收标准。
3. 状态只允许使用 TODO、READY、IN_PROGRESS、REVIEW、VERIFIED、DONE、BLOCKED。
4. 不允许把未接入的真实能力写成已完成。
5. 输出完成后说明拆分原则和不确定项。
```

## 2. 功能矩阵生成里程碑

```text
请阅读 docs/project-memory/02-feature-map.md。

你的任务是根据功能点依赖关系生成编程里程碑，写入 docs/project-memory/03-milestones.md。

要求：
1. 按依赖关系组织，不按页面或主观顺序组织。
2. 每个里程碑必须包含目标、功能点范围、前置依赖、完成标准、状态。
3. P0 主链路必须优先。
4. 外部依赖、联调、文档同步、验收也要进入里程碑。
5. 不要开始写业务代码。
```

## 3. 里程碑拆成任务看板

```text
请阅读 docs/project-memory/02-feature-map.md 和 docs/project-memory/03-milestones.md。

你的任务是生成可执行任务看板，写入 docs/project-memory/04-task-board.md。

要求：
1. 每个任务必须能被一个 Codex 线程独立处理。
2. 每个任务必须标明对应功能点、类型、状态、涉及文件范围、验收方式。
3. 避免让多个任务同时修改同一批共享文件。
4. 共享文件、数据库迁移、OpenAPI、全局状态要单独标注风险。
5. 不要开始写业务代码。
```

## 4. 开发线程开工

```text
你是一个开发线程，不是主线程。只有用户明确指定本模式时才执行。开始前必须阅读：
- docs/project-memory/00-start-here.md
- docs/project-memory/02-feature-map.md
- docs/project-memory/03-milestones.md
- docs/project-memory/04-task-board.md
- docs/project-memory/05-architecture-map.md
- docs/project-memory/06-decision-log.md
- docs/project-memory/07-thread-handoff.md

本线程只处理任务：T-xxx。

要求：
1. 先理解项目结构、调用链和现有风格，再修改代码。
2. 只修改该任务必要范围内的文件。
3. 不做硬编码、吞异常、临时绕过或 mock 成已完成。
4. 完成后运行必要验证。
5. 默认不要直接修改 docs/project-memory，除非主线程明确授权。
6. 完成后返回标准交接报告：Task ID、完成内容、修改文件、验证结果、对外影响、遗留问题、下一步建议。
7. 简洁说明改了什么、为什么这样改、如何验证。
```

## 5. 集成线程

```text
你是集成线程，不是主线程。只有用户明确指定本模式时才执行。请阅读：
- docs/project-memory/00-start-here.md
- docs/project-memory/02-feature-map.md
- docs/project-memory/03-milestones.md
- docs/project-memory/04-task-board.md
- docs/project-memory/05-architecture-map.md
- docs/project-memory/06-decision-log.md
- docs/project-memory/07-thread-handoff.md
- docs/project-memory/08-validation-log.md

你的任务是整合已经完成的线程结果。

要求：
1. 先判断哪些任务可以集成，哪些仍然阻塞。
2. 合并前理解每个线程的修改范围和对外影响。
3. 处理冲突时保留正确业务逻辑，不允许简单覆盖。
4. 执行全量验证。
5. 更新功能矩阵、里程碑、任务看板、验证日志和必要的决策记录。
6. 明确说明主链路是否完成，哪些依赖或验收仍未完成。
```

## 6. 当前进度盘点

```text
请读取 docs/project-memory/00-start-here.md、docs/project-memory/02-feature-map.md、docs/project-memory/03-milestones.md、docs/project-memory/04-task-board.md、docs/project-memory/06-decision-log.md、docs/project-memory/07-thread-handoff.md、docs/project-memory/08-validation-log.md。

请输出当前项目进度：
1. P0/P1 功能完成情况。
2. 当前主链路是否贯通。
3. 已完成、进行中、阻塞、未开始任务数量。
4. 阻塞项及原因。
5. 下一步最应该做的 3 个任务。

只做进度盘点，不要修改代码。
```
