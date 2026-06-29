#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  validate_project_memory.sh [repo-root]

Checks docs/project-memory schema, Markdown tables, IDs, states, validation
evidence, inbox review lifecycle, ownership path conflicts, completion evidence,
and tracked handoff append-only behavior.

Set ALLOW_HANDOFF_REWRITE=1 to bypass the Git append-only deletion check.
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
ROW_CELLS=()
FEATURE_IDS=()
TASK_IDS=()
MILESTONE_IDS=()
QUESTION_IDS=()
LOCK_IDS=()
ACTIVE_PATHS=()
ACTIVE_MODES=()
ACTIVE_LINES=()
TASK_STATES=()
COMPLETED_TASK_IDS=()
VALIDATION_TASK_IDS=()
HANDOFF_TASK_IDS=()
ACCEPTED_INBOX_TASK_IDS=()

error() {
  echo "ERROR $*" >&2
  ERRORS=$((ERRORS + 1))
}

warn() {
  echo "WARN $*" >&2
  WARNINGS=$((WARNINGS + 1))
}

ok() {
  echo "OK $*"
}

trim() {
  local value="$1"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  printf '%s' "${value}"
}

contains_value() {
  local needle="$1"
  shift
  local item
  for item in "$@"; do
    [[ "${item}" == "${needle}" ]] && return 0
  done
  return 1
}

valid_state() {
  contains_value "$1" TODO READY IN_PROGRESS REVIEW VERIFIED DONE BLOCKED
}

valid_priority() {
  contains_value "$1" P0 P1 P2 P3
}

valid_question_state() {
  contains_value "$1" OPEN ANSWERED BLOCKING DEFERRED
}

valid_lock_status() {
  contains_value "$1" ACTIVE RELEASED BLOCKED STALE
}

valid_lock_mode() {
  contains_value "$1" read write review integration
}

valid_inbox_status() {
  contains_value "$1" proposed ready-for-review blocked verified
}

valid_review_status() {
  contains_value "$1" accepted partially-accepted rejected
}

normalize_path() {
  local path
  path="$(trim "$1")"
  path="${path#./}"
  while [[ "${path}" == *"//"* ]]; do
    path="${path//\/\//\/}"
  done
  path="${path%/}"
  if [[ -z "${path}" ]]; then
    path="."
  fi
  printf '%s' "${path}"
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

modes_conflict() {
  local left="$1"
  local right="$2"
  [[ "${left}" == "read" || "${right}" == "read" ]] && return 1
  [[ "${left}" == "integration" || "${right}" == "integration" ]] && return 0
  [[ "${left}" == "write" && "${right}" == "write" ]] && return 0
  return 1
}

is_placeholder() {
  local value
  value="$(trim "$1")"
  [[ -z "${value}" || "${value}" == "-" || "${value}" == "未分配" || "${value}" == "未创建" || "${value}" == "未更新" || "${value}" == "未验证" ]]
}

split_markdown_row() {
  local line="$1"
  local body cell i
  ROW_CELLS=()
  [[ "${line}" == \|* ]] || return 1
  body="${line#|}"
  body="${body%|}"
  IFS='|' read -r -a ROW_CELLS <<< "${body}"
  for ((i = 0; i < ${#ROW_CELLS[@]}; i++)); do
    cell="$(trim "${ROW_CELLS[$i]}")"
    ROW_CELLS[$i]="${cell}"
  done
}

find_header_line() {
  local file="$1"
  local header="$2"
  grep -nF "${header}" "${file}" | head -n 1 | cut -d: -f1
}

require_table() {
  local rel="$1"
  local header="$2"
  local file="${TARGET_DIR}/${rel}"
  local line_no sep_line
  line_no="$(find_header_line "${file}" "${header}")"
  if [[ -z "${line_no}" ]]; then
    error "${rel}: missing table header: ${header}"
    return 1
  fi
  sep_line="$(sed -n "$((line_no + 1))p" "${file}")"
  if [[ "${sep_line}" != \|*---* ]]; then
    error "${rel}: missing Markdown table separator after header"
    return 1
  fi
  return 0
}

iter_table_rows() {
  local rel="$1"
  local header="$2"
  local expected_cols="$3"
  local file="${TARGET_DIR}/${rel}"
  local header_line start line line_no
  header_line="$(find_header_line "${file}" "${header}")"
  [[ -n "${header_line}" ]] || return 1
  start=$((header_line + 2))
  line_no=0
  while IFS= read -r line; do
    line_no=$((line_no + 1))
    [[ "${line_no}" -lt "${start}" ]] && continue
    [[ -z "$(trim "${line}")" ]] && break
    [[ "${line}" == \|* ]] || break
    split_markdown_row "${line}" || {
      error "${rel}:${line_no}: invalid Markdown table row"
      continue
    }
    if [[ "${#ROW_CELLS[@]}" -ne "${expected_cols}" ]]; then
      error "${rel}:${line_no}: expected ${expected_cols} table columns, got ${#ROW_CELLS[@]}"
    fi
    printf '%s\n' "${line_no}|${ROW_CELLS[*]}"
  done < "${file}"
}

check_required_files() {
  local required rel
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
    "10-ownership-locks.md"
    "inbox/README.md"
    "inbox/archive/README.md"
    "inbox/thread-updates/README.md"
    "sessions/README.md"
  )

  if [[ ! -d "${TARGET_DIR}" ]]; then
    error "missing directory: ${TARGET_DIR}"
    return
  fi

  for rel in "${required[@]}"; do
    if [[ ! -f "${TARGET_DIR}/${rel}" ]]; then
      error "missing ${TARGET_DIR}/${rel}"
    else
      ok "${rel}"
    fi
  done

  if [[ -d "${TARGET_ROOT}/docs/project" ]]; then
    warn "legacy docs/project exists; keep it read-only unless the user explicitly migrates it"
  fi

  if ! grep -q 'Schema Version: `project-memory/v2`' "${TARGET_DIR}/00-start-here.md"; then
    error "00-start-here.md: missing Schema Version: project-memory/v2"
  fi
}

check_feature_map() {
  local rel="02-feature-map.md"
  local header="| Feature ID | 功能点 | 模块 | 优先级 | 状态 | 负责人/线程 | 依赖 | 验收标准 | 验证记录 |"
  local item line_no id priority state verification
  require_table "${rel}" "${header}" || return
  while IFS= read -r item; do
    line_no="${item%%|*}"
    split_markdown_row "$(sed -n "${line_no}p" "${TARGET_DIR}/${rel}")"
    if [[ "${#ROW_CELLS[@]}" -ne 9 ]]; then
      error "${rel}:${line_no}: expected 9 table columns, got ${#ROW_CELLS[@]}"
      continue
    fi
    id="${ROW_CELLS[0]:-}"
    priority="${ROW_CELLS[3]:-}"
    state="${ROW_CELLS[4]:-}"
    verification="${ROW_CELLS[8]:-}"
    [[ "${id}" =~ ^F-[0-9][0-9][0-9]$ ]] || error "${rel}:${line_no}: invalid Feature ID: ${id}"
    contains_value "${id}" "${FEATURE_IDS[@]}" && error "${rel}:${line_no}: duplicate Feature ID: ${id}"
    FEATURE_IDS+=("${id}")
    valid_priority "${priority}" || error "${rel}:${line_no}: invalid priority: ${priority}"
    valid_state "${state}" || error "${rel}:${line_no}: invalid state: ${state}"
    if contains_value "${state}" VERIFIED DONE && is_placeholder "${verification}"; then
      error "${rel}:${line_no}: ${state} feature requires verification record"
    fi
  done < <(iter_table_rows "${rel}" "${header}" 9)
}

check_milestones() {
  local rel="03-milestones.md"
  local header="| Milestone ID | 目标 | 包含功能点 | 前置依赖 | 完成标准 | 状态 |"
  local item line_no id features state feature
  require_table "${rel}" "${header}" || return
  while IFS= read -r item; do
    line_no="${item%%|*}"
    split_markdown_row "$(sed -n "${line_no}p" "${TARGET_DIR}/${rel}")"
    if [[ "${#ROW_CELLS[@]}" -ne 6 ]]; then
      error "${rel}:${line_no}: expected 6 table columns, got ${#ROW_CELLS[@]}"
      continue
    fi
    id="${ROW_CELLS[0]:-}"
    features="${ROW_CELLS[2]:-}"
    state="${ROW_CELLS[5]:-}"
    [[ "${id}" =~ ^M-[0-9][0-9][0-9]$ ]] || error "${rel}:${line_no}: invalid Milestone ID: ${id}"
    contains_value "${id}" "${MILESTONE_IDS[@]}" && error "${rel}:${line_no}: duplicate Milestone ID: ${id}"
    MILESTONE_IDS+=("${id}")
    valid_state "${state}" || error "${rel}:${line_no}: invalid state: ${state}"
    for feature in ${features//,/ }; do
      [[ "${feature}" =~ ^F-[0-9][0-9][0-9]$ ]] || continue
      contains_value "${feature}" "${FEATURE_IDS[@]}" || error "${rel}:${line_no}: unknown Feature ID reference: ${feature}"
    done
  done < <(iter_table_rows "${rel}" "${header}" 6)
}

check_task_board() {
  local rel="04-task-board.md"
  local header="| Task ID | Feature ID | 任务说明 | 类型 | 状态 | 负责线程 | 分支/Worktree | 可改文件范围 | 禁止修改 | 验收方式 | 最后更新 |"
  local item line_no id feature state owned validation
  require_table "${rel}" "${header}" || return
  while IFS= read -r item; do
    line_no="${item%%|*}"
    split_markdown_row "$(sed -n "${line_no}p" "${TARGET_DIR}/${rel}")"
    if [[ "${#ROW_CELLS[@]}" -ne 11 ]]; then
      error "${rel}:${line_no}: expected 11 table columns, got ${#ROW_CELLS[@]}"
      continue
    fi
    id="${ROW_CELLS[0]:-}"
    feature="${ROW_CELLS[1]:-}"
    state="${ROW_CELLS[4]:-}"
    owned="${ROW_CELLS[7]:-}"
    validation="${ROW_CELLS[9]:-}"
    [[ "${id}" =~ ^T-[0-9][0-9][0-9]$ ]] || error "${rel}:${line_no}: invalid Task ID: ${id}"
    contains_value "${id}" "${TASK_IDS[@]}" && error "${rel}:${line_no}: duplicate Task ID: ${id}"
    TASK_IDS+=("${id}")
    TASK_STATES+=("${id}:${state}")
    valid_state "${state}" || error "${rel}:${line_no}: invalid state: ${state}"
    if [[ "${feature}" =~ ^F-[0-9][0-9][0-9]$ ]]; then
      contains_value "${feature}" "${FEATURE_IDS[@]}" || error "${rel}:${line_no}: unknown Feature ID reference: ${feature}"
    elif ! is_placeholder "${feature}"; then
      error "${rel}:${line_no}: invalid Feature ID reference: ${feature}"
    fi
    if contains_value "${state}" READY IN_PROGRESS REVIEW VERIFIED DONE && is_placeholder "${owned}"; then
      error "${rel}:${line_no}: ${state} task requires owned file scope"
    fi
    if contains_value "${state}" VERIFIED DONE && is_placeholder "${validation}"; then
      error "${rel}:${line_no}: ${state} task requires validation method"
    fi
    if contains_value "${state}" VERIFIED DONE; then
      COMPLETED_TASK_IDS+=("${id}")
    fi
  done < <(iter_table_rows "${rel}" "${header}" 11)
}

check_validation_log() {
  local rel="08-validation-log.md"
  local header="| 日期 | Task ID | 范围 | 命令/方式 | 结果 | 证据 | 备注 |"
  local item line_no date task scope method result evidence
  require_table "${rel}" "${header}" || return
  while IFS= read -r item; do
    line_no="${item%%|*}"
    split_markdown_row "$(sed -n "${line_no}p" "${TARGET_DIR}/${rel}")"
    if [[ "${#ROW_CELLS[@]}" -ne 7 ]]; then
      error "${rel}:${line_no}: expected 7 table columns, got ${#ROW_CELLS[@]}"
      continue
    fi
    date="${ROW_CELLS[0]:-}"
    task="${ROW_CELLS[1]:-}"
    scope="${ROW_CELLS[2]:-}"
    method="${ROW_CELLS[3]:-}"
    result="${ROW_CELLS[4]:-}"
    evidence="${ROW_CELLS[5]:-}"
    if is_placeholder "${date}" && is_placeholder "${task}" && is_placeholder "${scope}" && is_placeholder "${method}" && is_placeholder "${result}" && is_placeholder "${evidence}"; then
      continue
    fi
    if [[ "${task}" =~ ^T-[0-9][0-9][0-9]$ ]]; then
      contains_value "${task}" "${TASK_IDS[@]}" || error "${rel}:${line_no}: unknown Task ID reference: ${task}"
      VALIDATION_TASK_IDS+=("${task}")
    else
      error "${rel}:${line_no}: validation row requires Task ID"
    fi
    is_placeholder "${scope}" && error "${rel}:${line_no}: validation row requires scope"
    is_placeholder "${method}" && error "${rel}:${line_no}: validation row requires command or method"
    is_placeholder "${result}" && error "${rel}:${line_no}: validation row requires result"
    is_placeholder "${evidence}" && error "${rel}:${line_no}: validation row requires evidence"
  done < <(iter_table_rows "${rel}" "${header}" 7)
}

check_open_questions() {
  local rel="09-open-questions.md"
  local header="| ID | 问题 | 影响范围 | 当前假设 | 需要谁确认 | 状态 | 最后更新 |"
  local item line_no id state
  require_table "${rel}" "${header}" || return
  while IFS= read -r item; do
    line_no="${item%%|*}"
    split_markdown_row "$(sed -n "${line_no}p" "${TARGET_DIR}/${rel}")"
    if [[ "${#ROW_CELLS[@]}" -ne 7 ]]; then
      error "${rel}:${line_no}: expected 7 table columns, got ${#ROW_CELLS[@]}"
      continue
    fi
    id="${ROW_CELLS[0]:-}"
    state="${ROW_CELLS[5]:-}"
    [[ "${id}" =~ ^Q-[0-9][0-9][0-9]$ ]] || error "${rel}:${line_no}: invalid question ID: ${id}"
    contains_value "${id}" "${QUESTION_IDS[@]}" && error "${rel}:${line_no}: duplicate question ID: ${id}"
    QUESTION_IDS+=("${id}")
    valid_question_state "${state}" || error "${rel}:${line_no}: invalid question state: ${state}"
  done < <(iter_table_rows "${rel}" "${header}" 7)
}

check_ownership_locks() {
  local rel="10-ownership-locks.md"
  local header="| Lock ID | Task ID | Owner/Thread | Branch/Worktree | Owned Path | Mode | Status | Started At | Expires/Review At | Notes |"
  local item line_no id task path mode status active_path existing_i existing_mode existing_path existing_line
  require_table "${rel}" "${header}" || return
  while IFS= read -r item; do
    line_no="${item%%|*}"
    split_markdown_row "$(sed -n "${line_no}p" "${TARGET_DIR}/${rel}")"
    if [[ "${#ROW_CELLS[@]}" -ne 10 ]]; then
      error "${rel}:${line_no}: expected 10 table columns, got ${#ROW_CELLS[@]}"
      continue
    fi
    id="${ROW_CELLS[0]:-}"
    task="${ROW_CELLS[1]:-}"
    path="${ROW_CELLS[4]:-}"
    mode="${ROW_CELLS[5]:-}"
    status="${ROW_CELLS[6]:-}"
    [[ "${id}" =~ ^L-[0-9][0-9][0-9]$ ]] || error "${rel}:${line_no}: invalid Lock ID: ${id}"
    contains_value "${id}" "${LOCK_IDS[@]}" && error "${rel}:${line_no}: duplicate Lock ID: ${id}"
    LOCK_IDS+=("${id}")
    if [[ "${task}" =~ ^T-[0-9][0-9][0-9]$ ]]; then
      contains_value "${task}" "${TASK_IDS[@]}" || error "${rel}:${line_no}: unknown Task ID reference: ${task}"
    else
      error "${rel}:${line_no}: invalid Task ID reference: ${task}"
    fi
    valid_lock_mode "${mode}" || error "${rel}:${line_no}: invalid Mode: ${mode}"
    valid_lock_status "${status}" || error "${rel}:${line_no}: invalid Status: ${status}"
    if [[ "${status}" == "ACTIVE" ]]; then
      is_placeholder "${path}" && error "${rel}:${line_no}: ACTIVE lock requires Owned Path"
      active_path="$(normalize_path "${path}")"
      for ((existing_i = 0; existing_i < ${#ACTIVE_PATHS[@]}; existing_i++)); do
        existing_path="${ACTIVE_PATHS[$existing_i]}"
        existing_mode="${ACTIVE_MODES[$existing_i]}"
        existing_line="${ACTIVE_LINES[$existing_i]}"
        if paths_overlap "${active_path}" "${existing_path}" && modes_conflict "${mode}" "${existing_mode}"; then
          error "${rel}:${line_no}: ACTIVE ${mode}:${active_path} conflicts with line ${existing_line} ${existing_mode}:${existing_path}"
        fi
      done
      ACTIVE_PATHS+=("${active_path}")
      ACTIVE_MODES+=("${mode}")
      ACTIVE_LINES+=("${line_no}")
    fi
  done < <(iter_table_rows "${rel}" "${header}" 10)
}

extract_field() {
  local file="$1"
  local field="$2"
  local line
  line="$(grep -E "^- ${field}:" "${file}" | tail -n 1 || true)"
  printf '%s' "${line}" | sed -E "s/^- ${field}:[[:space:]]*//"
}

require_section() {
  local file="$1"
  local section="$2"
  grep -qE "^## ${section}$" "${file}" || error "${file#${TARGET_ROOT}/}: missing section ## ${section}"
}

check_inbox_updates() {
  local file task feature status result
  shopt -s nullglob
  for file in "${TARGET_DIR}/inbox/thread-updates/"*.md; do
    [[ "$(basename "${file}")" == "README.md" ]] && continue
    require_section "${file}" "Metadata"
    require_section "${file}" "Scope"
    require_section "${file}" "Facts To Merge"
    require_section "${file}" "Validation Evidence"
    require_section "${file}" "Noise Check"
    task="$(extract_field "${file}" "Task ID")"
    feature="$(extract_field "${file}" "Feature ID")"
    status="$(extract_field "${file}" "Status")"
    [[ "${task}" =~ ^T-[0-9][0-9][0-9]$ ]] || error "${file#${TARGET_ROOT}/}: invalid or missing Task ID"
    contains_value "${task}" "${TASK_IDS[@]}" || error "${file#${TARGET_ROOT}/}: unknown Task ID reference: ${task}"
    if [[ "${feature}" =~ ^F-[0-9][0-9][0-9]$ ]]; then
      contains_value "${feature}" "${FEATURE_IDS[@]}" || error "${file#${TARGET_ROOT}/}: unknown Feature ID reference: ${feature}"
    elif ! is_placeholder "${feature}"; then
      error "${file#${TARGET_ROOT}/}: invalid Feature ID reference: ${feature}"
    fi
    valid_inbox_status "${status}" || error "${file#${TARGET_ROOT}/}: invalid Status: ${status}"
    result="$(extract_field "${file}" "Result")"
    if contains_value "${status}" ready-for-review verified && is_placeholder "${result}"; then
      error "${file#${TARGET_ROOT}/}: ${status} inbox update requires validation result"
    fi
  done
  shopt -u nullglob
}

check_inbox_archive() {
  local file task status reviewer reviewed_at
  shopt -s nullglob
  for file in "${TARGET_DIR}/inbox/archive/"*.md; do
    [[ "$(basename "${file}")" == "README.md" ]] && continue
    task="$(extract_field "${file}" "Task ID")"
    status="$(extract_field "${file}" "Review Status")"
    reviewer="$(extract_field "${file}" "Reviewed By")"
    reviewed_at="$(extract_field "${file}" "Reviewed At")"
    if [[ "${task}" =~ ^T-[0-9][0-9][0-9]$ ]]; then
      contains_value "${task}" "${TASK_IDS[@]}" || error "${file#${TARGET_ROOT}/}: unknown Task ID reference: ${task}"
      if [[ "${status}" == "accepted" ]]; then
        ACCEPTED_INBOX_TASK_IDS+=("${task}")
      fi
    else
      error "${file#${TARGET_ROOT}/}: invalid or missing Task ID"
    fi
    valid_review_status "${status}" || error "${file#${TARGET_ROOT}/}: invalid or missing Review Status"
    is_placeholder "${reviewer}" && error "${file#${TARGET_ROOT}/}: missing Reviewed By"
    is_placeholder "${reviewed_at}" && error "${file#${TARGET_ROOT}/}: missing Reviewed At"
  done
  shopt -u nullglob
}

check_handoff_task_ids() {
  local rel="07-thread-handoff.md"
  local file="${TARGET_DIR}/${rel}"
  local line_no=0 line task
  while IFS= read -r line; do
    line_no=$((line_no + 1))
    if [[ "${line}" =~ ^-[[:space:]]*Task[[:space:]]ID:[[:space:]]*(T-[0-9][0-9][0-9])[[:space:]]*$ ]]; then
      task="${BASH_REMATCH[1]}"
      contains_value "${task}" "${TASK_IDS[@]}" || error "${rel}:${line_no}: unknown Task ID reference: ${task}"
      HANDOFF_TASK_IDS+=("${task}")
    fi
  done < "${file}"
}

check_completed_task_evidence() {
  local task
  for task in "${COMPLETED_TASK_IDS[@]}"; do
    contains_value "${task}" "${VALIDATION_TASK_IDS[@]}" || error "04-task-board.md: ${task} is VERIFIED/DONE but has no 08-validation-log evidence"
    contains_value "${task}" "${HANDOFF_TASK_IDS[@]}" || error "04-task-board.md: ${task} is VERIFIED/DONE but has no 07-thread-handoff entry"
    contains_value "${task}" "${ACCEPTED_INBOX_TASK_IDS[@]}" || error "04-task-board.md: ${task} is VERIFIED/DONE but has no accepted inbox archive"
  done
}

check_decision_statuses() {
  local rel="06-decision-log.md"
  local file="${TARGET_DIR}/${rel}"
  local in_code=0 line_no=0 line status
  while IFS= read -r line; do
    line_no=$((line_no + 1))
    [[ "${line}" == '```'* ]] && {
      if [[ "${in_code}" -eq 0 ]]; then in_code=1; else in_code=0; fi
      continue
    }
    [[ "${in_code}" -eq 1 ]] && continue
    if [[ "${line}" =~ ^-[[:space:]]*状态[:：][[:space:]]*(.+)$ ]]; then
      status="$(trim "${BASH_REMATCH[1]}")"
      contains_value "${status}" proposed accepted superseded || error "${rel}:${line_no}: invalid decision status: ${status}"
    fi
  done < "${file}"
}

check_handoff_append_only() {
  local rel="docs/project-memory/07-thread-handoff.md"
  local deleted
  [[ "${ALLOW_HANDOFF_REWRITE:-}" == "1" ]] && return
  git -C "${TARGET_ROOT}" rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 0
  git -C "${TARGET_ROOT}" ls-files --error-unmatch "${rel}" >/dev/null 2>&1 || return 0
  deleted="$(git -C "${TARGET_ROOT}" diff --unified=0 -- "${rel}" | awk '/^-[^-]/ { print; found=1 } END { exit found ? 0 : 1 }' || true)"
  if [[ -n "${deleted}" ]]; then
    error "${rel}: tracked handoff has deleted lines; append new handoff entries instead of rewriting history"
  fi
}

check_required_files

if [[ "${ERRORS}" -eq 0 ]]; then
  check_feature_map
  check_milestones
  check_task_board
  check_validation_log
  check_open_questions
  check_ownership_locks
  check_inbox_updates
  check_inbox_archive
  check_handoff_task_ids
  check_completed_task_evidence
  check_decision_statuses
  check_handoff_append_only
fi

if [[ "${ERRORS}" -gt 0 ]]; then
  echo "Project memory validation failed: ${ERRORS} error(s), ${WARNINGS} warning(s)." >&2
  exit 1
fi

echo "Project memory validation passed: ${TARGET_DIR} (${WARNINGS} warning(s))"
