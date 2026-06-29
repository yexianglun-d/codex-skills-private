#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  claim_ownership.sh [repo-root] --task T-xxx --owner NAME --path PATH [--lock L-xxx] [--branch NAME] [--mode write|read|review|integration] [--expires TEXT] [--notes TEXT]

Appends an ACTIVE ownership row to docs/project-memory/10-ownership-locks.md
after checking that no identical active mode/path lock already exists.
USAGE
}

TARGET_ROOT="."
LOCK_ID=""
TASK_ID=""
OWNER=""
OWNED_PATH=""
BRANCH="未创建"
MODE="write"
EXPIRES=""
NOTES=""

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --lock)
      LOCK_ID="${2:-}"
      shift 2
      ;;
    --task)
      TASK_ID="${2:-}"
      shift 2
      ;;
    --owner)
      OWNER="${2:-}"
      shift 2
      ;;
    --path)
      OWNED_PATH="${2:-}"
      shift 2
      ;;
    --branch)
      BRANCH="${2:-}"
      shift 2
      ;;
    --mode)
      MODE="${2:-}"
      shift 2
      ;;
    --expires)
      EXPIRES="${2:-}"
      shift 2
      ;;
    --notes)
      NOTES="${2:-}"
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

case "${MODE}" in
  read|write|review|integration) ;;
  *)
    echo "ERROR invalid --mode: ${MODE}" >&2
    exit 1
    ;;
esac

if [[ -z "${TASK_ID}" || -z "${OWNER}" || -z "${OWNED_PATH}" ]]; then
  echo "ERROR --task, --owner, and --path are required" >&2
  usage >&2
  exit 1
fi

if [[ ! "${TASK_ID}" =~ ^T-[0-9][0-9][0-9]$ ]]; then
  echo "ERROR invalid --task: ${TASK_ID}" >&2
  exit 1
fi

TARGET_ROOT="$(cd "${TARGET_ROOT}" && pwd)"
LOCK_FILE="${TARGET_ROOT}/docs/project-memory/10-ownership-locks.md"

if [[ ! -f "${LOCK_FILE}" ]]; then
  echo "ERROR missing ownership file: ${LOCK_FILE}" >&2
  exit 1
fi

if [[ -z "${LOCK_ID}" ]]; then
  next_num="$(
    grep -Eo 'L-[0-9]{3}' "${LOCK_FILE}" \
      | sed 's/L-//' \
      | sort -n \
      | tail -n 1 \
      | awk '{ if ($1 == "") print 1; else print $1 + 1 }'
  )"
  LOCK_ID="$(printf 'L-%03d' "${next_num}")"
fi

if [[ ! "${LOCK_ID}" =~ ^L-[0-9][0-9][0-9]$ ]]; then
  echo "ERROR invalid --lock: ${LOCK_ID}" >&2
  exit 1
fi

if awk -F'|' -v mode="${MODE}" -v path="${OWNED_PATH}" '
  $0 ~ /^\|/ {
    for (i = 1; i <= NF; i++) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", $i)
    }
    if ($7 == mode && $8 == "ACTIVE" && $6 == path) {
      found = 1
    }
  }
  END { exit found ? 0 : 1 }
' "${LOCK_FILE}"; then
  echo "ERROR ACTIVE ownership already exists for ${MODE}:${OWNED_PATH}" >&2
  exit 1
fi

started_at="$(date '+%Y-%m-%d %H:%M')"
row="| ${LOCK_ID} | ${TASK_ID} | ${OWNER} | ${BRANCH} | ${OWNED_PATH} | ${MODE} | ACTIVE | ${started_at} | ${EXPIRES} | ${NOTES} |"
tmp_file="$(mktemp)"

awk -v row="${row}" '
  BEGIN { in_table = 0; inserted = 0 }
  /^\| Lock ID \| Task ID \|/ { in_table = 1; print; next }
  in_table && $0 !~ /^\|/ && !inserted {
    print row
    inserted = 1
    in_table = 0
  }
  { print }
  END {
    if (!inserted) {
      print row
    }
  }
' "${LOCK_FILE}" > "${tmp_file}"

mv "${tmp_file}" "${LOCK_FILE}"
echo "${LOCK_ID}"
