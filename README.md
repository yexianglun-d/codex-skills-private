# Codex Skills Private

Language: English | [中文](README.zh-CN.md)

Private backup and transfer kit for Deng's local Codex setup.

This repository is meant to be handed to another Codex instance or another AI agent so it can understand what is installed locally and restore the useful parts without guessing.

## Read Order

1. `CAPABILITY_MAP.md` - what each skill, MCP, CLI, and plugin group is for.
2. `SYNC_STATUS.md` - latest source-machine vs repository audit.
3. `INVENTORY.md` - exact list of skills, MCP servers, plugins, and tracked CLI tools.
4. `RESTORE.md` - restore procedure for a new machine.
5. `skills/` - vendored non-system local skills.
6. `mcp/config.sanitized.toml` - sanitized MCP config blocks.
7. `global/AGENTS.md` - global Codex collaboration rules snapshot.

Chinese versions are available as `*.zh-CN.md` for the main documents.

## Safety Rules

Keep this repository private.

Do not commit:

- `~/.codex/auth.json`
- raw `~/.codex/config.toml`
- API keys
- OAuth tokens
- bearer tokens
- `.env` files

`CONTEXT7_API_KEY`, `FIRECRAWL_API_KEY`, and the Enterprise WeChat webhook key are intentionally stored as `<SET_IN_LOCAL_CODEX_CONFIG>`.

## Current Snapshot

Snapshot date: 2026-07-13

- Non-system local skills: 32
- System skills noted but not vendored: 5
- MCP servers: 9
- Additional local CLI tools tracked: 1
- External design candidates recorded only: 2
- Unique plugin names observed in cache: 20
- Plugin cache entries by source/version: 22
- Plugin-provided skill files observed in cache: 112

## Quick Restore

Restore local skills only:

```bash
bash scripts/restore-skills.sh
```

Then restore MCP and plugins using:

```text
RESTORE.md
```

Restart Codex or open a new thread after restoring skills, MCPs, or plugins.
