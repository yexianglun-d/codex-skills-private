#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  init_project_control.sh [repo-root] [--force]

Compatibility wrapper. Prefer project-memory-manager.
Creates docs/project-memory files when project-memory-manager is installed.
Existing files are not overwritten unless --force is provided.
USAGE
}

CODEX_HOME_DIR="${CODEX_HOME:-${HOME}/.codex}"
MEMORY_INIT="${CODEX_HOME_DIR}/skills/project-memory-manager/scripts/init_project_memory.sh"

if [[ -x "${MEMORY_INIT}" ]]; then
  exec "${MEMORY_INIT}" "$@"
fi

echo "ERROR missing project-memory-manager init script: ${MEMORY_INIT}" >&2
echo "Install or restore the project-memory-manager skill; this wrapper no longer creates legacy docs/project." >&2
exit 1
