---
name: java-code-discipline
description: Use this skill for Java development, Java bug fixes, Java refactors, Java code reviews, Spring/MyBatis/service-layer changes, exception/logging/transaction/database changes, or when the user asks to apply Alibaba Java manual style discipline, root-cause fixing, project-style reuse, minimal scoped edits, and validation. This is a compact constraint workflow, not a full Java manual.
---

# Java Code Discipline

## 定位

这是一个约束型 Java skill，用来把“阿里巴巴 Java 开发手册”的高价值原则压缩成可执行检查流程。它不复制完整手册，也不替代项目内 `AGENTS.md`、README、开发规范、静态检查或用户当轮要求。

优先级：用户当轮要求 > 项目内更具体规则 > 本 skill > 通用 Java 经验。

## 使用场景

当任务涉及以下内容时使用：

- Java / Spring / Spring Boot / MyBatis / Maven / Gradle 代码编写、修复、重构或评审。
- Controller、Service、Mapper、Entity、DTO、异常、日志、事务、数据库访问、接口返回结构的变更。
- 用户强调“先定位根因”“不要临时兜底”“符合系统风格”“遵循阿里巴巴 Java 开发手册”。

如果用户明确要求只分析、只评审或只规划，不要直接改代码。

## 工作流程

1. 先判断任务类型：新增功能、Bug 修复、重构、代码评审、依赖或配置变更。
2. 修改前读取最小必要上下文：模块边界、调用链、已有实现风格、可复用工具和未提交变更。
3. 按任务加载参考清单：
   - 任意代码变更：读 `references/pre-change-checklist.md`。
   - Bug 修复：读 `references/bug-fix-discipline.md`。
   - 代码评审或重构：读 `references/java-review-checklist.md`。
   - 需要贴合项目风格：读 `references/project-style-checklist.md`。
4. 只做完成目标所需的最小修改，优先复用项目已有结构、枚举、常量、异常体系、响应结构和工具类。
5. 修改后按相关清单自查，再运行与改动范围匹配的测试、构建、lint、接口验证或手动验证。
6. 回复默认说明：改了什么、为什么这样改、如何验证、剩余问题。

## 硬性禁止

- 不理解项目结构、调用链、数据来源和影响范围就直接改代码。
- 用硬编码、吞异常、临时 if-else、绕过校验、默认值掩盖来处理 Bug 表象。
- 无必要新增抽象、设计模式、工具类、依赖或机制。
- 顺手重构、格式化、清理、重命名无关代码。
- 把 mock、假数据、单点 2xx、代码看起来正确描述成真实功能完成。
- 覆盖、回滚或格式化用户或其他线程的未提交改动。

## 输出约束

最终回复保持简洁，优先使用：

- 改了什么
- 为什么这样改
- 如何验证
- 剩余问题

如果无法完成验证，必须说明原因、已做替代检查和剩余风险。
