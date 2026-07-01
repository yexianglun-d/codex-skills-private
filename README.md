# Codex Skills Private

Private backup and transfer kit for Deng's local Codex setup.

This repository is meant to be handed to another Codex instance or another AI agent so it can understand what is installed locally and restore the useful parts without guessing.

## Read Order

1. `INVENTORY.md` - exact list of skills, MCP servers, and plugins.
2. `RESTORE.md` - restore procedure for a new machine.
3. `skills/` - vendored non-system local skills.
4. `mcp/config.sanitized.toml` - sanitized MCP config blocks.
5. `global/AGENTS.md` - global Codex collaboration rules snapshot.

## Safety Rules

Keep this repository private.

Do not commit:

- `~/.codex/auth.json`
- raw `~/.codex/config.toml`
- API keys
- OAuth tokens
- bearer tokens
- `.env` files

`CONTEXT7_API_KEY` is intentionally stored as `<SET_IN_LOCAL_CODEX_CONFIG>`.

## Current Snapshot

Snapshot date: 2026-07-01

- Non-system local skills: 32
- System skills noted but not vendored: 5
- MCP servers: 7
- Unique plugin entries: 18
- Plugin-provided skill files observed in cache: 87

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
