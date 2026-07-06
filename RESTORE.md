# Restore Guide

Language: English | [中文](RESTORE.zh-CN.md)

This guide is for a new Codex machine or another AI agent receiving this repository.

## What This Repo Can Restore Directly

- Non-system skills under `skills/`
- Global instruction snapshot from `global/AGENTS.md`
- Sanitized MCP config blocks from `mcp/config.sanitized.toml`
- Capability and sync documentation: `CAPABILITY_MAP.md`, `SYNC_STATUS.md`, `INVENTORY.md`

## What Must Be Reconfigured Locally

- Context7 API key
- Firecrawl API key
- GitHub MCP bearer token env var, if using GitHub MCP
- Figma login, if using Figma MCP write/read operations
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

The restored project-memory workflow uses:

- `project-memory-manager` as the explicit-only lightweight project journal for repository-local `docs/project-memory/`.
- `codex-project-orchestrator` only for advanced PRD decomposition, milestones, task boards, multi-thread coordination, progress audits, or integration planning.

The restored design workflow uses:

- `ai-design-router` as the auto-invoked router for UI, UX, frontend visual, Figma, motion, and visual QA tasks.
- It selects the smallest useful specialist skill set and prevents default stacking of overlapping design skills.
- It vendors `VoltAgent/awesome-design-md` under `skills/ai-design-router/AI-Design-Library/08-design-references/` as a local `DESIGN.md` reference library.
- `typeui` is documented as a candidate only; it is not installed as an MCP, CLI, plugin, or default skill.

The restored coding workflow uses:

- `coding-router` as the auto-invoked router for code engineering tasks: bugs, failing tests, build errors, new features, refactors, code reviews, Java/Vue discipline, third-party library/API/CLI usage, and completion verification.
- It selects the smallest useful engineering workflow and prevents default stacking of `root-cause-fixer`, `java-code-discipline`, `vue-code-discipline`, `implementation-planner`, `technical-solution-designer`, and `superpowers` sub-skills.
- It defers visual UI/UX/Figma work to `ai-design-router`, project memory to `project-memory-manager`, and formal PRD/milestone/multi-thread orchestration to `codex-project-orchestrator`.

The restored writing workflow includes:

- `humanizer` as an explicit-only prose/Markdown rewrite skill for reducing AI-sounding patterns.
- It should not be used automatically for technical truth, validation logs, project memory, bug reports, or code explanations.

Important behavior:

- `project-memory-manager` creates only four files: `00-current-status.md`, `01-activity-log.md`, `02-decisions.md`, and `03-next-handoff.md`.
- It does not default to heavy project-management or worker-coordination workflows.
- `codex-project-orchestrator/scripts/init_project_control.sh` only forwards to `project-memory-manager`; it no longer creates legacy `docs/project`.
- `project-memory-manager` uses `${CODEX_HOME:-$HOME/.codex}` in examples and scripts instead of a personal absolute path.
- Run `project-memory-manager/scripts/validate_project_memory.sh` after initializing or changing project memory files; it only checks the lightweight journal structure.

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
codex mcp add firecrawl --env FIRECRAWL_API_KEY=<SET_IN_LOCAL_CODEX_CONFIG> -- npx -y firecrawl-mcp
codex mcp add postman --url https://mcp.postman.com/mcp
codex mcp add figma --url https://mcp.figma.com/mcp
codex mcp add github --url https://api.githubcopilot.com/mcp/ --bearer-token-env-var GITHUB_PAT_TOKEN
```

Then edit `~/.codex/config.toml` and set:

```toml
[mcp_servers.context7]
startup_timeout_sec = 20

[mcp_servers.context7.env]
CONTEXT7_API_KEY = "<SET_IN_LOCAL_CODEX_CONFIG>"

[mcp_servers.firecrawl.env]
FIRECRAWL_API_KEY = "<SET_IN_LOCAL_CODEX_CONFIG>"
```

For Firecrawl CLI:

```bash
npm install -g firecrawl-cli
firecrawl login --api-key "$FIRECRAWL_API_KEY"
firecrawl --status
```

For Postman, authenticate locally if needed:

```bash
codex mcp login postman
```

For GitHub MCP, set `GITHUB_PAT_TOKEN` locally before use. Do not commit the token.

For Figma MCP, authenticate from the target Codex/Figma environment if the server reports `Not logged in`.

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
