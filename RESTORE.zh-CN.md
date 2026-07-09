# 恢复指南

语言：[English](RESTORE.md) | 中文

本指南用于新 Codex 机器，或收到本仓库的其他 AI agent。

## 本仓库可以直接恢复什么

- `skills/` 下的非系统 skills
- `global/AGENTS.md` 全局规则快照
- `mcp/config.sanitized.toml` 脱敏 MCP 配置块
- 能力与同步说明：`CAPABILITY_MAP.zh-CN.md`、`SYNC_STATUS.zh-CN.md`、`INVENTORY.zh-CN.md`

## 必须在本地重新配置什么

- Context7 API key
- Firecrawl API key
- GitHub MCP bearer token env var，如需使用 GitHub MCP
- Figma 登录状态，如需 Figma MCP 读写
- Postman OAuth 登录
- Codex 登录状态
- Codex App 中的插件安装或启用状态
- 插件管理的运行时路径，例如 `computer-use`、`browser`、`chrome`、`node_repl`

## Step 1：恢复 Skills

在仓库根目录运行：

```bash
bash scripts/restore-skills.sh
```

脚本会按名称把每个 skill 目录复制到：

```text
~/.codex/skills/
```

它不会复制 `.system` skills，也不会删除目标机器上无关的已有 skills。

恢复后的项目记忆工作流：

- `project-memory-manager`：主动调用的轻量项目日志，写入仓库内 `docs/project-memory/`。
- `codex-project-orchestrator`：仅用于高级 PRD 拆解、里程碑、任务看板、多线程协作、进度审计或集成计划。

恢复后的设计工作流：

- `ai-design-router`：自动触发的 UI/UX/前端视觉/Figma/动效/视觉 QA 路由器。
- 它选择最小必要设计 skill 组合，避免默认叠加多个重叠设计 skill。
- 它把 `VoltAgent/awesome-design-md` vendored 到 `skills/ai-design-router/AI-Design-Library/08-design-references/`。
- `typeui` 只作为候选记录，不是已安装 MCP、CLI、插件或默认 skill。

恢复后的代码工程工作流：

- `coding-router`：自动触发的代码工程路由器，覆盖 Bug、测试失败、构建错误、新功能、重构、代码评审、Java/Vue 规范、第三方库/API/CLI 用法、完成前验证。
- 它选择最小必要工程 workflow，避免默认叠加 `root-cause-fixer`、`java-code-discipline`、`vue-code-discipline`、`implementation-planner`、`technical-solution-designer` 和 `superpowers` 子 skill。
- 它把视觉 UI/UX/Figma 任务让给 `ai-design-router`，把项目记忆让给 `project-memory-manager`，把正式 PRD/里程碑/多线程编排让给 `codex-project-orchestrator`。

恢复后的写作工作流：

- `humanizer`：主动调用的文案/Markdown 去 AI 味润色 skill。
- 不应自动用于技术事实、验证日志、项目记忆、Bug 报告或代码解释。

重要行为：

- `project-memory-manager` 只创建四个文件：`00-current-status.md`、`01-activity-log.md`、`02-decisions.md`、`03-next-handoff.md`。
- 它不默认创建重型项目管理或 worker 协作流程。
- `codex-project-orchestrator/scripts/init_project_control.sh` 只转发到 `project-memory-manager`，不再创建旧的 `docs/project`。
- `project-memory-manager` 示例和脚本使用 `${CODEX_HOME:-$HOME/.codex}`，不使用个人绝对路径。
- 初始化或修改项目记忆后，可以运行 `project-memory-manager/scripts/validate_project_memory.sh` 校验轻量日志结构。

## Step 2：恢复全局规则

如果目标机器要使用同一套全局 Codex 规则：

```bash
mkdir -p ~/.codex
cp global/AGENTS.md ~/.codex/AGENTS.md
```

如果目标机器已经有重要规则，请手动合并，不要直接覆盖。

## Step 3：恢复 MCP Servers

以 `mcp/config.sanitized.toml` 为准。

推荐命令：

```bash
codex mcp add sequential-thinking --env DISABLE_THOUGHT_LOGGING=true -- npx -y @modelcontextprotocol/server-sequential-thinking
codex mcp add context7 -- npx -y @upstash/context7-mcp
codex mcp add firecrawl --env FIRECRAWL_API_KEY=<SET_IN_LOCAL_CODEX_CONFIG> -- npx -y firecrawl-mcp
codex mcp add wecom-bot --env 'WECOM_WEBHOOK_URL=https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=<SET_IN_LOCAL_CODEX_CONFIG>' -- uvx wecom-bot-mcp-server
codex mcp add postman --url https://mcp.postman.com/mcp
codex mcp add figma --url https://mcp.figma.com/mcp
codex mcp add github --url https://api.githubcopilot.com/mcp/ --bearer-token-env-var GITHUB_PAT_TOKEN
```

然后编辑 `~/.codex/config.toml`，设置：

```toml
[mcp_servers.context7]
startup_timeout_sec = 20

[mcp_servers.context7.env]
CONTEXT7_API_KEY = "<SET_IN_LOCAL_CODEX_CONFIG>"

[mcp_servers.firecrawl.env]
FIRECRAWL_API_KEY = "<SET_IN_LOCAL_CODEX_CONFIG>"

[mcp_servers.wecom-bot.env]
WECOM_WEBHOOK_URL = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=<SET_IN_LOCAL_CODEX_CONFIG>"
```

Firecrawl CLI：

```bash
npm install -g firecrawl-cli
firecrawl login --api-key "$FIRECRAWL_API_KEY"
firecrawl --status
```

Postman 如需使用，在本地登录：

```bash
codex mcp login postman
```

GitHub MCP 使用前，在本地设置 `GITHUB_PAT_TOKEN`。不要提交 token。

Figma MCP 如果提示 `Not logged in`，需要在目标 Codex/Figma 环境登录。

企业微信使用前，需要在目标企业微信群创建群机器人，并替换 `WECOM_WEBHOOK_URL` 中的占位 key。Webhook URL 视为密钥处理。

`node_repl` 和 `computer-use` 通常由 Codex App 和 bundled 插件管理。Codex App 版本不同时，不要盲目复制旧的绝对运行时路径。

## Step 4：恢复插件

安装或启用 `INVENTORY.zh-CN.md` 中列出的插件。

不要把插件缓存目录作为主要恢复方式。插件缓存路径包含 Codex build/version 相关文件，不一定可移植。

## Step 5：验证

检查 MCP：

```bash
codex mcp list
codex mcp get context7
codex mcp get sequential-thinking
codex mcp get wecom-bot
```

检查 skills：

```bash
find ~/.codex/skills -maxdepth 2 -name SKILL.md | sort
```

如果目标机器有 `skill-creator`：

```bash
for skill in ~/.codex/skills/*/SKILL.md; do
  python3 ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py "${skill%/SKILL.md}"
done
```

恢复 skills、MCP 或插件后，重启 Codex 或新开线程。
