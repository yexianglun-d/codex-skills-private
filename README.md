# Codex Skills Private

This private repository stores a local backup of personal Codex skills and MCP configuration notes.

Keep this repository private. Do not commit live `~/.codex/auth.json`, raw `~/.codex/config.toml`, API keys, OAuth tokens, or environment files.

## Skills

This snapshot mirrors non-system skill folders from `~/.codex/skills/`.

- `chronicle`
- `codex-project-orchestrator`
- `figma`
- `figma-code-connect-components`
- `figma-create-design-system-rules`
- `figma-implement-design`
- `frontend-design`
- `gsap-core`
- `gsap-frameworks`
- `gsap-performance`
- `gsap-plugins`
- `gsap-react`
- `gsap-scrolltrigger`
- `gsap-timeline`
- `gsap-utils`
- `implementation-planner`
- `java-code-discipline`
- `liu-ying-chat-style`
- `pdf`
- `playwright`
- `playwright-interactive`
- `product-co-creator`
- `root-cause-fixer`
- `technical-solution-designer`
- `ui-ux-pro-max`

## MCP

`mcp/config.sanitized.toml` contains a sanitized MCP server snapshot from `~/.codex/config.toml`.

Current backed-up MCP entries:

- `postman`
- `sequential-thinking`
- `context7`
- `node_repl`

`CONTEXT7_API_KEY` is intentionally replaced with `<SET_IN_LOCAL_CODEX_CONFIG>`.

## Global Rules

`global/AGENTS.md` stores the current global Codex collaboration rules, including MCP trigger policy.

## Restore

Restore skills:

```bash
rsync -a skills/ ~/.codex/skills/
```

Restore MCP configuration manually by copying the relevant `[mcp_servers.*]` blocks from:

```text
mcp/config.sanitized.toml
```

Then put real secrets back only in the local machine config, for example:

```toml
[mcp_servers.context7.env]
CONTEXT7_API_KEY = "..."
```

Restart Codex or open a new thread if the skill or MCP list does not update immediately.
