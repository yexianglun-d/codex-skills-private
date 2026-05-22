#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  init_project_control.sh [repo-root] [--force]

Creates docs/project control files for Codex multi-thread project orchestration.
Existing files are not overwritten unless --force is provided.
USAGE
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_DIR="${SKILL_DIR}/assets/project-control"

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
TARGET_DIR="${TARGET_ROOT}/docs/project"

mkdir -p "${TARGET_DIR}"

created=0
skipped=0

for template in "${TEMPLATE_DIR}"/*.md; do
  name="$(basename "${template}")"
  target="${TARGET_DIR}/${name}"
  if [[ -e "${target}" && "${FORCE}" != "true" ]]; then
    echo "SKIP ${target}"
    skipped=$((skipped + 1))
    continue
  fi
  cp "${template}" "${target}"
  echo "WRITE ${target}"
  created=$((created + 1))
done

echo "Project control initialized: ${TARGET_DIR}"
echo "Created or overwritten: ${created}; skipped: ${skipped}"
