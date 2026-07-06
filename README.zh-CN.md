# Codex Skills Private

语言：[English](README.md) | 中文

Deng 本机 Codex 环境的私有备份与迁移包。

这个仓库的目标不是原样镜像 `~/.codex`，而是让另一台机器上的 Codex 或其他 AI 能快速理解：当前装了什么、各自做什么、怎么恢复、哪些密钥需要本地重新配置。

## 阅读顺序

1. `CAPABILITY_MAP.zh-CN.md` - 每个 skill、MCP、CLI、插件组分别做什么。
2. `SYNC_STATUS.zh-CN.md` - 最近一次本机和仓库的同步对账结果。
3. `INVENTORY.zh-CN.md` - skills、MCP、插件、CLI 工具清单。
4. `RESTORE.zh-CN.md` - 新机器恢复步骤。
5. `skills/` - 已备份的非系统本地 skills。
6. `mcp/config.sanitized.toml` - 脱敏后的 MCP 配置块。
7. `global/AGENTS.md` - 全局 Codex 协作规则快照。

英文版本使用原始文件名，例如 `README.md`、`CAPABILITY_MAP.md`。

## 安全规则

此仓库必须保持私有。

不要提交：

- `~/.codex/auth.json`
- 原始 `~/.codex/config.toml`
- API key
- OAuth token
- bearer token
- `.env` 文件

`CONTEXT7_API_KEY` 和 `FIRECRAWL_API_KEY` 只允许以 `<SET_IN_LOCAL_CODEX_CONFIG>` 占位形式出现。

## 当前快照

快照日期：2026-07-06

- 非系统本地 skills：32
- 仅记录、不备份的系统 skills：5
- MCP servers：8
- 额外记录的本地 CLI 工具：1
- 插件缓存里的唯一插件名：20
- 插件缓存 source/version 条目：22
- 插件提供的 skill 文件：112

## 快速恢复

只恢复本地 skills：

```bash
bash scripts/restore-skills.sh
```

然后按 `RESTORE.zh-CN.md` 恢复 MCP 和插件。

恢复 skills、MCP 或插件后，重启 Codex 或新开一个线程。
