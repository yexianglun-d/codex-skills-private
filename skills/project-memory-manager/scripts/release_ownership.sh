#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  release_ownership.sh [repo-root] --lock L-xxx [--status RELEASED|BLOCKED|STALE] [--note TEXT]

Updates an ownership row in docs/project-memory/10-ownership-locks.md.
USAGE
}

TARGET_ROOT="."
LOCK_ID=""
STATUS="RELEASED"
NOTE=""

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --lock)
      LOCK_ID="${2:-}"
      shift 2
      ;;
    --status)
      STATUS="${2:-}"
      shift 2
      ;;
    --note)
      NOTE="${2:-}"
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

if [[ ! "${LOCK_ID}" =~ ^L-[0-9][0-9][0-9]$ ]]; then
  echo "ERROR --lock is required and must look like L-001" >&2
  usage >&2
  exit 1
fi

case "${STATUS}" in
  RELEASED|BLOCKED|STALE) ;;
  *)
    echo "ERROR invalid --status: ${STATUS}" >&2
    exit 1
    ;;
esac

TARGET_ROOT="$(cd "${TARGET_ROOT}" && pwd)"
LOCK_FILE="${TARGET_ROOT}/docs/project-memory/10-ownership-locks.md"

if [[ ! -f "${LOCK_FILE}" ]]; then
  echo "ERROR missing ownership file: ${LOCK_FILE}" >&2
  exit 1
fi

tmp_file="$(mktemp)"

awk -F'|' -v lock="${LOCK_ID}" -v status="${STATUS}" -v note="${NOTE}" '
  BEGIN { OFS = "|"; found = 0 }
  function trim(value) {
    gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
    return value
  }
  $0 ~ /^\|/ {
    for (i = 1; i <= NF; i++) {
      fields[i] = trim($i)
    }
    if (fields[2] == lock) {
      fields[8] = status
      if (note != "") {
        if (fields[11] == "") {
          fields[11] = note
        } else {
          fields[11] = fields[11] "; " note
        }
      }
      print "| " fields[2] " | " fields[3] " | " fields[4] " | " fields[5] " | " fields[6] " | " fields[7] " | " fields[8] " | " fields[9] " | " fields[10] " | " fields[11] " |"
      found = 1
      next
    }
  }
  { print }
  END { exit found ? 0 : 1 }
' "${LOCK_FILE}" > "${tmp_file}" || {
  rm -f "${tmp_file}"
  echo "ERROR lock not found: ${LOCK_ID}" >&2
  exit 1
}

mv "${tmp_file}" "${LOCK_FILE}"
echo "${LOCK_ID}"
