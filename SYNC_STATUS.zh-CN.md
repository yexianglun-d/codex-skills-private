# 同步状态

语言：[English](SYNC_STATUS.md) | 中文

快照日期：2026-07-06

本文件记录源机器和本恢复仓库之间的最近一次人工对账结果。

## 摘要

| 区域 | 源机器 | 仓库 | 状态 |
| --- | ---: | ---: | --- |
| 带 `SKILL.md` 的非系统本地 skills | 32 | 32 | 已同步 |
| MCP servers | 8 | 8 | 已同步 |
| 额外记录的 CLI 工具 | 1 | 1 | 已同步 |
| 插件缓存里的唯一插件名 | 20 | 20 | 已更新 |
| 插件缓存 source/version 条目 | 22 | 22 | 已更新 |
| 插件提供的 skill 文件 | 112 | 112 | 已更新 |
| 插件提供的唯一 skill 名 | 96 | 只做审计记录 | 信息项 |

## 本地 Skill 对比

对比命令：

```bash
find ~/.codex/skills -mindepth 2 -maxdepth 2 -name SKILL.md
find ./skills -mindepth 2 -maxdepth 2 -name SKILL.md
```

结果：

- 仓库缺失：无
- 仓库多余：无

备注：源机器存在 `~/.codex/skills/codex-primary-runtime` 目录，但它没有 `SKILL.md`，因此不视为本地 skill，也不做 vendored 备份。

## MCP 对比

当前源机器 MCP：

| MCP | 状态 |
| --- | --- |
| `computer-use` | 已启用，插件管理 |
| `context7` | 已启用 |
| `firecrawl` | 已启用 |
| `figma` | 已启用，未登录 |
| `github` | 已启用，使用 bearer token env |
| `node_repl` | 已启用，Codex App 运行时管理 |
| `sequential-thinking` | 已启用 |
| `postman` | 已启用，OAuth |

已更新的仓库文件：

- `mcp/inventory.md`
- `mcp/config.sanitized.toml`
- `RESTORE.md`

密钥只保留占位：

- `CONTEXT7_API_KEY`
- `FIRECRAWL_API_KEY`
- `GITHUB_PAT_TOKEN`

## 插件缓存对比

源机器观察到的插件缓存条目：

| 插件 | 版本 / Build | 来源类型 |
| --- | --- | --- |
| `browser` | `26.623.101652` | `openai-bundled` |
| `chrome` | `26.623.101652` | `openai-bundled` |
| `computer-use` | `1.0.857` | `openai-bundled` |
| `build-ios-apps` | `0.1.2` | `openai-curated-remote` |
| `build-macos-apps` | `0.1.4` | `openai-curated-remote` |
| `figma` | `2.0.12` | `openai-curated-remote` |
| `google-drive` | `0.1.7` | `openai-curated-remote` |
| `hyperframes` | `0.1.2` | `openai-curated-remote` |
| `product-design` | `0.1.47` | `openai-curated-remote` |
| `superpowers` | `5.1.4` | `openai-curated-remote` |
| `build-web-apps` | `d6169bef` | `openai-curated` |
| `figma` | `d6169bef` | `openai-curated` |
| `game-studio` | `d6169bef` | `openai-curated` |
| `github` | `d6169bef` | `openai-curated` |
| `heygen` | `d6169bef` | `openai-curated` |
| `hyperframes` | `d6169bef` | `openai-curated` |
| `remotion` | `d6169bef` | `openai-curated` |
| `documents` | `26.630.12135` | `openai-primary-runtime` |
| `pdf` | `26.630.12135` | `openai-primary-runtime` |
| `presentations` | `26.630.12135` | `openai-primary-runtime` |
| `spreadsheets` | `26.630.12135` | `openai-primary-runtime` |
| `template-creator` | `26.630.12135` | `openai-primary-runtime` |

恢复说明：插件缓存路径和 Codex 版本/构建相关。恢复时应安装或启用对应插件，不要复制这些缓存目录。
