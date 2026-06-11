# MCP Inventory

Snapshot date: 2026-06-11

This file records the MCP servers shown by `codex mcp list`. Use `config.sanitized.toml` for copyable user config blocks. Plugin-managed MCPs may be enabled by Codex/plugin state rather than by a direct block in `~/.codex/config.toml`.

## Enabled MCPs

| Name | Source | Transport | Restore note |
| --- | --- | --- | --- |
| `computer-use` | Codex bundled plugin | stdio | Plugin-managed; reinstall/enable the Codex bundled Computer Use plugin if missing. |
| `context7` | `~/.codex/config.toml` | stdio via `npx -y @upstash/context7-mcp` | Restore from `config.sanitized.toml`, then set `CONTEXT7_API_KEY` locally. |
| `node_repl` | `~/.codex/config.toml` / Codex app runtime | stdio | Restore from `config.sanitized.toml`; paths may vary by Codex app version. |
| `sequential-thinking` | `~/.codex/config.toml` | stdio via `npx -y @modelcontextprotocol/server-sequential-thinking` | Restore from `config.sanitized.toml`. |
| `postman` | `~/.codex/config.toml` | streamable HTTP | Restore URL from `config.sanitized.toml`, then re-auth OAuth if needed. |

## Secret Handling

- `CONTEXT7_API_KEY` is intentionally not stored here.
- OAuth credentials, Codex auth files, and bearer tokens must remain local only.
