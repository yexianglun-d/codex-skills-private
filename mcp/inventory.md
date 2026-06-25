# MCP Inventory

Snapshot date: 2026-06-25

This file records the MCP servers shown by `codex mcp list`. Use `config.sanitized.toml` for copyable user config blocks. Plugin-managed MCPs may be enabled by Codex/plugin state rather than by a direct block in `~/.codex/config.toml`.

## Enabled MCPs

| Name | Source | Transport | Restore note |
| --- | --- | --- | --- |
| `computer-use` | Codex bundled plugin | stdio | Plugin-managed; reinstall/enable the Codex bundled Computer Use plugin if missing. |
| `context7` | `~/.codex/config.toml` | stdio via `npx -y @upstash/context7-mcp` | Restore from `config.sanitized.toml`, then set `CONTEXT7_API_KEY` locally. |
| `figma` | Codex/Figma MCP config | streamable HTTP | Restore URL from `config.sanitized.toml`; login was not active in the source snapshot. |
| `github` | Codex/GitHub MCP config | streamable HTTP | Restore URL from `config.sanitized.toml`, then set `GITHUB_PAT_TOKEN` locally if needed. |
| `node_repl` | `~/.codex/config.toml` / Codex app runtime | stdio | Restore from `config.sanitized.toml`; paths may vary by Codex app version. |
| `sequential-thinking` | `~/.codex/config.toml` | stdio via `npx -y @modelcontextprotocol/server-sequential-thinking` | Restore from `config.sanitized.toml`. |
| `postman` | `~/.codex/config.toml` | streamable HTTP | Restore URL from `config.sanitized.toml`, then re-auth OAuth if needed. |

## Plugin Inventory

For plugins, use `../INVENTORY.md`. Do not restore plugins by copying cache directories unless the target Codex version explicitly supports that.

## Secret Handling

- `CONTEXT7_API_KEY` is intentionally not stored here.
- OAuth credentials, Codex auth files, Figma login state, GitHub bearer tokens, and other secrets must remain local only.
