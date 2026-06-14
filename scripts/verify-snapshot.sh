#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
validator="${CODEX_HOME:-$HOME/.codex}/skills/.system/skill-creator/scripts/quick_validate.py"

count="$(find "$repo_root/skills" -maxdepth 2 -name SKILL.md -type f | wc -l | tr -d ' ')"
printf 'skills in snapshot: %s\n' "$count"

if [[ -f "$validator" ]]; then
  find "$repo_root/skills" -maxdepth 2 -name SKILL.md -type f | sort | while read -r skill_md; do
    python3 "$validator" "${skill_md%/SKILL.md}" >/dev/null
  done
  printf 'skill validation: ok\n'
else
  failures=0
  while read -r skill_md; do
    if ! grep -q '^---$' "$skill_md" || ! grep -q '^name:' "$skill_md" || ! grep -q '^description:' "$skill_md"; then
      printf 'invalid skill metadata: %s\n' "$skill_md" >&2
      failures=$((failures + 1))
    fi
  done < <(find "$repo_root/skills" -maxdepth 2 -name SKILL.md -type f | sort)
  if [[ "$failures" -gt 0 ]]; then
    exit 1
  fi
  printf 'skill structural validation: ok; official validator not found at %s\n' "$validator"
fi

if command -v codex >/dev/null 2>&1; then
  codex mcp list
else
  printf 'codex CLI not found; skipped MCP check\n'
fi
