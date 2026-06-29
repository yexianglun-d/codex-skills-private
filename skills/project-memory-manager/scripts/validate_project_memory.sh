#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  validate_project_memory.sh [repo-root]

Checks the lightweight docs/project-memory project journal structure.
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
ERRORS=0
WARNINGS=0

error() {
  echo "ERROR $*" >&2
  ERRORS=$((ERRORS + 1))
}

warn() {
  echo "WARN $*" >&2
  WARNINGS=$((WARNINGS + 1))
}

require_file() {
  local rel="$1"
  local title="$2"
  local file="${TARGET_DIR}/${rel}"

  if [[ ! -f "${file}" ]]; then
    error "missing ${rel}"
    return
  fi

  if ! grep -qF "${title}" "${file}"; then
    error "${rel}: missing title marker '${title}'"
  fi
}

if [[ ! -d "${TARGET_DIR}" ]]; then
  error "missing docs/project-memory directory"
else
  require_file "00-current-status.md" "# Current Status"
  require_file "01-activity-log.md" "# Activity Log"
  require_file "02-decisions.md" "# Decisions"
  require_file "03-next-handoff.md" "# Next Handoff"
fi

if [[ "${ERRORS}" -gt 0 ]]; then
  echo "Project journal validation failed: ${ERRORS} error(s), ${WARNINGS} warning(s)." >&2
  exit 1
fi

echo "Project journal validation passed: ${TARGET_DIR} (${WARNINGS} warning(s))."
