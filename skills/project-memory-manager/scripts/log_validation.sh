#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  log_validation.sh [repo-root] --task T-xxx --scope TEXT --method TEXT --result TEXT --evidence TEXT [--date YYYY-MM-DD] [--notes TEXT]

Appends a validation row inside docs/project-memory/08-validation-log.md.
USAGE
}

TARGET_ROOT="."
TASK_ID=""
SCOPE=""
METHOD=""
RESULT=""
EVIDENCE=""
DATE="$(date '+%Y-%m-%d')"
NOTES=""

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --task)
      TASK_ID="${2:-}"
      shift 2
      ;;
    --scope)
      SCOPE="${2:-}"
      shift 2
      ;;
    --method)
      METHOD="${2:-}"
      shift 2
      ;;
    --result)
      RESULT="${2:-}"
      shift 2
      ;;
    --evidence)
      EVIDENCE="${2:-}"
      shift 2
      ;;
    --date)
      DATE="${2:-}"
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

if [[ ! "${TASK_ID}" =~ ^T-[0-9][0-9][0-9]$ ]]; then
  echo "ERROR --task is required and must look like T-001" >&2
  exit 1
fi

for required_value in "${SCOPE}" "${METHOD}" "${RESULT}" "${EVIDENCE}"; do
  if [[ -z "${required_value}" || "${required_value}" == "-" ]]; then
    echo "ERROR --scope, --method, --result, and --evidence are required" >&2
    exit 1
  fi
done

TARGET_ROOT="$(cd "${TARGET_ROOT}" && pwd)"
TASK_FILE="${TARGET_ROOT}/docs/project-memory/04-task-board.md"
VALIDATION_FILE="${TARGET_ROOT}/docs/project-memory/08-validation-log.md"

if [[ ! -f "${TASK_FILE}" || ! -f "${VALIDATION_FILE}" ]]; then
  echo "ERROR missing task board or validation log" >&2
  exit 1
fi

if ! awk -F'|' -v task="${TASK_ID}" '
  $0 ~ /^\|/ {
    for (i = 1; i <= NF; i++) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", $i)
    }
    if ($2 == task) {
      found = 1
      exit
    }
  }
  END { exit found ? 0 : 1 }
' "${TASK_FILE}"; then
  echo "ERROR task does not exist in 04-task-board.md: ${TASK_ID}" >&2
  exit 1
fi

row="| ${DATE} | ${TASK_ID} | ${SCOPE} | ${METHOD} | ${RESULT} | ${EVIDENCE} | ${NOTES} |"
tmp_file="$(mktemp)"

awk -v row="${row}" '
  BEGIN { in_table = 0; inserted = 0; after_separator = 0 }
  /^\| 日期 \| Task ID \|/ { in_table = 1; print; next }
  in_table && /^\| --- / { after_separator = 1; print; next }
  in_table && after_separator && /^\|[[:space:]]*\|/ && !inserted {
    print row
    inserted = 1
    print
    next
  }
  in_table && after_separator && $0 !~ /^\|/ && !inserted {
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
' "${VALIDATION_FILE}" > "${tmp_file}"

mv "${tmp_file}" "${VALIDATION_FILE}"
echo "${TASK_ID}"
