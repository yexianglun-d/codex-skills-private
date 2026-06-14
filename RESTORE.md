# Restore Guide

This guide is for a new Codex machine or another AI agent receiving this repository.

## What This Repo Can Restore Directly

- Non-system skills under `skills/`
- Global instruction snapshot from `global/AGENTS.md`
- Sanitized MCP config blocks from `mcp/config.sanitized.toml`

## What Must Be Reconfigured Locally

- Context7 API key
- Postman OAuth login
- Codex auth
- Plugin installation or enablement in the Codex app
- Plugin-managed runtime paths such as `computer-use`, `browser`, `chrome`, and `node_repl`

## Step 1: Restore Skills

From the repository root:

```bash
bash scripts/restore-skills.sh
```

The script copies each skill directory by name into:

```text
~/.codex/skills/
```

It does not copy `.system` skills and does not delete unrelated skills on the target machine.

## Step 2: Restore Global Rules

If the target machine should use the same global Codex rules:

```bash
mkdir -p ~/.codex
cp global/AGENTS.md ~/.codex/AGENTS.md
```

If the target already has important rules, merge manually instead of overwriting.

## Step 3: Restore MCP Servers

Use `mcp/config.sanitized.toml` as the source of truth.

Recommended commands:

```bash
codex mcp add sequential-thinking --env DISABLE_THOUGHT_LOGGING=true -- npx -y @modelcontextprotocol/server-sequential-thinking
codex mcp add context7 -- npx -y @upstash/context7-mcp
codex mcp add postman --url https://mcp.postman.com/mcp
```

Then edit `~/.codex/config.toml` and set:

```toml
[mcp_servers.context7]
startup_timeout_sec = 20

[mcp_servers.context7.env]
CONTEXT7_API_KEY = "..."
```

For Postman, authenticate locally if needed:

```bash
codex mcp login postman
```

`node_repl` and `computer-use` are normally installed or managed by the Codex app and bundled plugins. Do not blindly copy old absolute runtime paths if the Codex app version differs.

## Step 4: Restore Plugins

Install or enable the plugins listed in `INVENTORY.md`.

Do not copy plugin cache directories as the primary restore method. Plugin cache paths include Codex build/version-specific files and may not be portable.

## Step 5: Verify

Check MCP:

```bash
codex mcp list
codex mcp get context7
codex mcp get sequential-thinking
```

Check skills:

```bash
find ~/.codex/skills -maxdepth 2 -name SKILL.md | sort
```

If `skill-creator` exists on the target:

```bash
for skill in ~/.codex/skills/*/SKILL.md; do
  python3 ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py "${skill%/SKILL.md}"
done
```

Restart Codex or open a new thread after restore.
