# MCP Backup

This folder stores sanitized MCP configuration for Codex.

- `config.sanitized.toml` is safe to commit because live secrets are replaced with placeholders.
- Do not copy `~/.codex/config.toml` here directly.
- Do not commit `auth.json`, OAuth tokens, API keys, or `.env` files.

After restoring, replace placeholders only in the local `~/.codex/config.toml`.
