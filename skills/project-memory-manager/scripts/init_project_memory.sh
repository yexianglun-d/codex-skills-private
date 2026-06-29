#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  init_project_memory.sh [repo-root] [--force]

Creates a lightweight docs/project-memory project journal.
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

if [[ "${FORCE}" == "true" && -d "${TARGET_DIR}" ]]; then
  rm -rf "${TARGET_DIR}"
fi

mkdir -p "${TARGET_DIR}"

written=0
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
  written=$((written + 1))
done < <(find "${TEMPLATE_DIR}" -type f | sort)

echo "Project journal initialized: ${TARGET_DIR}"
echo "Written: ${written}; skipped: ${skipped}"
