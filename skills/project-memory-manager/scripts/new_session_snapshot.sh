#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  new_session_snapshot.sh [repo-root] [--title "short title"] [--task T-xxx] [--status STATUS]

Creates a timestamped template under docs/project-memory/sessions/.
USAGE
}

TARGET_ROOT="."
TITLE="session-snapshot"
TASK_ID=""
STATUS=""

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --title)
      TITLE="${2:-}"
      shift 2
      ;;
    --task)
      TASK_ID="${2:-}"
      shift 2
      ;;
    --status)
      STATUS="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      TARGET_ROOT="$1"
      shift
      ;;
  esac
done

TARGET_ROOT="$(cd "${TARGET_ROOT}" && pwd)"
SESSION_DIR="${TARGET_ROOT}/docs/project-memory/sessions"
mkdir -p "${SESSION_DIR}"

timestamp="$(date '+%Y-%m-%d-%H%M')"
slug="$(printf '%s' "${TITLE}" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')"
if [[ -z "${slug}" ]]; then
  slug="session-snapshot"
fi

target="${SESSION_DIR}/${timestamp}-${slug}.md"

cat > "${target}" <<EOF
# ${timestamp} ${TITLE}

## Task

- Task ID: ${TASK_ID}
- Status: ${STATUS}

## Context

-

## What Changed

-

## Files Touched

-

## Validation

- Commands:
- Manual checks:
- Result:

## Decisions

-

## Open Questions

-

## Next Handoff

-
EOF

echo "${target}"
