# Sync Status

Language: English | [中文](SYNC_STATUS.zh-CN.md)

Snapshot date: 2026-07-09

This file records the latest manual audit between the source machine and this restore repository.

## Summary

| Area | Source machine | Repository | Status |
| --- | ---: | ---: | --- |
| Non-system local skills with `SKILL.md` | 32 | 32 | synced |
| MCP servers | 9 | 9 | synced |
| Additional tracked CLI tools | 1 | 1 | synced |
| Unique plugin names in cache | 20 | 20 | updated |
| Plugin cache entries by source/version | 22 | 22 | updated |
| Plugin-provided skill files observed in cache | 112 | 112 | updated |
| Unique plugin-provided skill names | 96 | documented in audit only | informational |

## Local Skill Comparison

Compared:

```bash
find ~/.codex/skills -mindepth 2 -maxdepth 2 -name SKILL.md
find ./skills -mindepth 2 -maxdepth 2 -name SKILL.md
```

Result:

- Missing in repository: none
- Extra in repository: none

Note: `~/.codex/skills/codex-primary-runtime` exists as a directory on the source machine but has no `SKILL.md`, so it is not treated as a local skill and is not vendored.

## MCP Comparison

Current source machine MCPs:

| MCP | Status |
| --- | --- |
| `computer-use` | enabled, plugin-managed |
| `context7` | enabled |
| `firecrawl` | enabled |
| `wecom-bot` | enabled with placeholder webhook |
| `figma` | enabled, not logged in |
| `github` | enabled with bearer token env |
| `node_repl` | enabled, Codex app runtime managed |
| `sequential-thinking` | enabled |
| `postman` | enabled with OAuth |

Repository files updated:

- `mcp/inventory.md`
- `mcp/config.sanitized.toml`
- `RESTORE.md`

Secrets remain placeholders only:

- `CONTEXT7_API_KEY`
- `FIRECRAWL_API_KEY`
- `WECOM_WEBHOOK_URL`
- `GITHUB_PAT_TOKEN`

## Plugin Cache Comparison

Plugin cache entries observed on the source machine:

| Plugin | Version / Build | Source type |
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

Restore note: plugin cache paths are version/build-specific. Restore by installing or enabling the corresponding plugin, not by copying these cache directories.
