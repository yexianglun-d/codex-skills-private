# Inbox

这里是 worker、新线程、开发线程向主线程上报事实的地方。

核心规则：

- 主线程维护权威项目状态。
- worker/新线程默认不直接改核心状态文件。
- worker/新线程把事实写到 `thread-updates/`。
- 主线程审核后再合并到 `00-start-here.md`、`02-feature-map.md`、`03-milestones.md`、`04-task-board.md`、`05-architecture-map.md`、`06-decision-log.md`、`09-open-questions.md`。

只上报当前任务相关事实，不写泛化建议。
