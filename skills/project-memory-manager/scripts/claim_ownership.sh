#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  claim_ownership.sh [repo-root] --task T-xxx --owner NAME --path PATH [--lock L-xxx] [--branch NAME] [--mode write|read|review|integration] [--expires TEXT] [--notes TEXT]

Appends an ACTIVE ownership row to docs/project-memory/10-ownership-locks.md
after checking the task exists, the path is inside the task's writable scope,
and no overlapping active lock conflicts by mode.
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
TASK_STATE=""
TASK_SCOPE=""
LOCK_DIR=""

trim() {
  local value="$1"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  printf '%s' "${value}"
}

normalize_path() {
  local path
  path="$(trim "$1")"
  if [[ "${path}" == /* ]]; then
    echo "ERROR absolute paths are not allowed in project-memory ownership: ${path}" >&2
    exit 1
  fi
  path="${path#./}"
  while [[ "${path}" == *"//"* ]]; do
    path="${path//\/\//\/}"
  done
  path="${path%/}"
  if [[ -z "${path}" ]]; then
    path="."
  fi
  if [[ "${path}" == ".." || "${path}" == "../"* || "${path}" == *"/../"* || "${path}" == *"/.." ]]; then
    echo "ERROR '..' path components are not allowed in project-memory ownership: ${path}" >&2
    exit 1
  fi
  printf '%s' "${path}"
}

acquire_process_lock() {
  local lock_parent="${TARGET_ROOT}/docs/project-memory/.locks"
  LOCK_DIR="${lock_parent}/ownership.lock.d"
  mkdir -p "${lock_parent}"
  if ! mkdir "${LOCK_DIR}" 2>/dev/null; then
    echo "ERROR ownership update is locked by another process: ${LOCK_DIR}" >&2
    exit 1
  fi
  trap 'rm -rf "${LOCK_DIR}"' EXIT INT TERM
}

paths_overlap() {
  local left right
  left="$(normalize_path "$1")"
  right="$(normalize_path "$2")"
  [[ "${left}" == "." || "${right}" == "." ]] && return 0
  [[ "${left}" == "${right}" ]] && return 0
  [[ "${left}" == "${right}/"* ]] && return 0
  [[ "${right}" == "${left}/"* ]] && return 0
  return 1
}

path_within_scope() {
  local path="$1"
  local scope="$2"
  local normalized_path token normalized_scope
  normalized_path="$(normalize_path "${path}")"
  scope="${scope//，/,}"
  scope="${scope//;/,}"
  scope="${scope//；/,}"
  scope="${scope//、/,}"
  IFS=',' read -r -a scope_items <<< "${scope}"
  for token in "${scope_items[@]}"; do
    normalized_scope="$(normalize_path "${token}")"
    [[ "${normalized_scope}" == "." || "${normalized_scope}" == "-" ]] && continue
    [[ "${normalized_scope}" == "*" ]] && return 0
    [[ "${normalized_path}" == "${normalized_scope}" ]] && return 0
    [[ "${normalized_path}" == "${normalized_scope}/"* ]] && return 0
  done
  return 1
}

modes_conflict() {
  local left="$1"
  local right="$2"
  [[ "${left}" == "read" || "${right}" == "read" ]] && return 1
  [[ "${left}" == "integration" || "${right}" == "integration" ]] && return 0
  [[ "${left}" == "write" && "${right}" == "write" ]] && return 0
  return 1
}

task_status_allows_mode() {
  local state="$1"
  local mode="$2"
  case "${mode}" in
    write)
      [[ "${state}" == "READY" || "${state}" == "IN_PROGRESS" ]]
      ;;
    integration)
      [[ "${state}" == "REVIEW" || "${state}" == "VERIFIED" ]]
      ;;
    review)
      [[ "${state}" == "REVIEW" || "${state}" == "VERIFIED" || "${state}" == "DONE" ]]
      ;;
    read)
      return 0
      ;;
  esac
}

load_task() {
  local task_file="$1"
  local row
  row="$(
    awk -F'|' -v task="${TASK_ID}" '
      $0 ~ /^\|/ {
        for (i = 1; i <= NF; i++) {
          gsub(/^[[:space:]]+|[[:space:]]+$/, "", $i)
        }
        if ($2 == task) {
          print $6 "\t" $9
          found = 1
          exit
        }
      }
      END { exit found ? 0 : 1 }
    ' "${task_file}" || true
  )"
  [[ -n "${row}" ]] || return 1
  TASK_STATE="${row%%$'\t'*}"
  TASK_SCOPE="${row#*$'\t'}"
  return 0
}

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
TASK_FILE="${TARGET_ROOT}/docs/project-memory/04-task-board.md"

OWNED_PATH="$(normalize_path "${OWNED_PATH}")"

if [[ ! -f "${LOCK_FILE}" ]]; then
  echo "ERROR missing ownership file: ${LOCK_FILE}" >&2
  exit 1
fi

if [[ ! -f "${TASK_FILE}" ]]; then
  echo "ERROR missing task board: ${TASK_FILE}" >&2
  exit 1
fi

acquire_process_lock

if ! load_task "${TASK_FILE}"; then
  echo "ERROR task does not exist in 04-task-board.md: ${TASK_ID}" >&2
  exit 1
fi

if ! task_status_allows_mode "${TASK_STATE}" "${MODE}"; then
  echo "ERROR task ${TASK_ID} state ${TASK_STATE} cannot claim ${MODE} ownership" >&2
  exit 1
fi

if ! path_within_scope "${OWNED_PATH}" "${TASK_SCOPE}"; then
  echo "ERROR path ${OWNED_PATH} is outside task ${TASK_ID} writable scope: ${TASK_SCOPE}" >&2
  exit 1
fi

if [[ -z "${LOCK_ID}" ]]; then
  next_num="$(
    (grep -Eo 'L-[0-9]{3}' "${LOCK_FILE}" || true) \
      | sed 's/L-//' \
      | sort -n \
      | tail -n 1 \
      | awk '{ if ($1 == "") print 1; else print $1 + 1 }'
  )"
  if [[ -z "${next_num}" ]]; then
    next_num="1"
  fi
  LOCK_ID="$(printf 'L-%03d' "${next_num}")"
fi

if [[ ! "${LOCK_ID}" =~ ^L-[0-9][0-9][0-9]$ ]]; then
  echo "ERROR invalid --lock: ${LOCK_ID}" >&2
  exit 1
fi

if awk -F'|' -v mode="${MODE}" -v path="${OWNED_PATH}" '
  function trim(value) {
    gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
    return value
  }
  function normalize(value) {
    value = trim(value)
    if (value ~ /^\// || value == ".." || value ~ /^\.\.\// || value ~ /\/\.\.\// || value ~ /\/\.\.$/) {
      return "\001INVALID"
    }
    sub(/^\.\//, "", value)
    gsub(/\/+/, "/", value)
    sub(/\/$/, "", value)
    if (value == "") {
      value = "."
    }
    return value
  }
  function overlaps(left, right) {
    left = normalize(left)
    right = normalize(right)
    if (left == "." || right == ".") return 1
    if (left == right) return 1
    if (index(left, right "/") == 1) return 1
    if (index(right, left "/") == 1) return 1
    return 0
  }
  function conflicts(left, right) {
    if (left == "read" || right == "read") return 0
    if (left == "integration" || right == "integration") return 1
    if (left == "write" && right == "write") return 1
    return 0
  }
  $0 ~ /^\|/ {
    for (i = 1; i <= NF; i++) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", $i)
    }
    if ($8 == "ACTIVE" && overlaps(path, $6) && conflicts(mode, $7)) {
      found = 1
    }
  }
  END { exit found ? 0 : 1 }
' "${LOCK_FILE}"; then
  echo "ERROR ACTIVE ownership conflict exists for ${MODE}:${OWNED_PATH}" >&2
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
