#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
target="${CODEX_HOME:-$HOME/.codex}/skills"

mkdir -p "$target"

find "$repo_root/skills" -mindepth 1 -maxdepth 1 -type d | sort | while read -r skill_dir; do
  name="$(basename "$skill_dir")"
  rsync -a --delete --exclude '.DS_Store' "$skill_dir/" "$target/$name/"
  printf 'restored %s -> %s\n' "$name" "$target/$name"
done

printf '\nDone. Restart Codex or open a new thread if skills do not appear immediately.\n'
