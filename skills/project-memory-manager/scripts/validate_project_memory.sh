#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  validate_project_memory.sh [repo-root]

Checks that docs/project-memory has the required project memory files.
USAGE
}

TARGET_ROOT="."

for arg in "$@"; do
  case "$arg" in
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

required=(
  "00-start-here.md"
  "01-product-brief.md"
  "02-feature-map.md"
  "03-milestones.md"
  "04-task-board.md"
  "05-architecture-map.md"
  "06-decision-log.md"
  "07-thread-handoff.md"
  "08-validation-log.md"
  "09-open-questions.md"
  "sessions/README.md"
)

missing=0

if [[ ! -d "${TARGET_DIR}" ]]; then
  echo "ERROR missing directory: ${TARGET_DIR}" >&2
  exit 1
fi

for rel in "${required[@]}"; do
  if [[ ! -f "${TARGET_DIR}/${rel}" ]]; then
    echo "ERROR missing ${TARGET_DIR}/${rel}" >&2
    missing=$((missing + 1))
  else
    echo "OK ${rel}"
  fi
done

if [[ "${missing}" -gt 0 ]]; then
  echo "Project memory validation failed: ${missing} missing file(s)." >&2
  exit 1
fi

echo "Project memory validation passed: ${TARGET_DIR}"
