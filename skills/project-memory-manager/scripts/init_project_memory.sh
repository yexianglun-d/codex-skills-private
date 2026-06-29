#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  init_project_memory.sh [repo-root] [--force]

Creates docs/project-memory files for Codex project memory.
Existing files are not overwritten unless --force is provided.
USAGE
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_DIR="${SKILL_DIR}/assets/project-memory"

TARGET_ROOT="."
FORCE="false"

for arg in "$@"; do
  case "$arg" in
    --force)
      FORCE="true"
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      TARGET_ROOT="$arg"
      ;;
  esac
done

TARGET_ROOT="$(cd "${TARGET_ROOT}" && pwd)"
TARGET_DIR="${TARGET_ROOT}/docs/project-memory"

mkdir -p "${TARGET_DIR}"

created=0
skipped=0

while IFS= read -r template; do
  rel="${template#${TEMPLATE_DIR}/}"
  target="${TARGET_DIR}/${rel}"
  mkdir -p "$(dirname "${target}")"
  if [[ -e "${target}" && "${FORCE}" != "true" ]]; then
    echo "SKIP ${target}"
    skipped=$((skipped + 1))
    continue
  fi
  cp "${template}" "${target}"
  echo "WRITE ${target}"
  created=$((created + 1))
done < <(find "${TEMPLATE_DIR}" -type f | sort)

echo "Project memory initialized: ${TARGET_DIR}"
echo "Created or overwritten: ${created}; skipped: ${skipped}"

if [[ -d "${TARGET_ROOT}/docs/project" ]]; then
  echo "NOTE legacy docs/project exists; read it before migrating useful state."
fi
