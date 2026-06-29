#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  reconcile_inbox_update.sh [repo-root] --file PATH --status accepted|partially-accepted|rejected --reviewer NAME [--note TEXT] [--archive]

Adds a main-thread review block to an inbox thread update. With --archive, moves
the reviewed file from docs/project-memory/inbox/thread-updates/ to
docs/project-memory/inbox/archive/.
USAGE
}

TARGET_ROOT="."
UPDATE_FILE=""
STATUS=""
REVIEWER=""
NOTE=""
ARCHIVE="false"

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --file)
      UPDATE_FILE="${2:-}"
      shift 2
      ;;
    --status)
      STATUS="${2:-}"
      shift 2
      ;;
    --reviewer)
      REVIEWER="${2:-}"
      shift 2
      ;;
    --note)
      NOTE="${2:-}"
      shift 2
      ;;
    --archive)
      ARCHIVE="true"
      shift
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

case "${STATUS}" in
  accepted|partially-accepted|rejected) ;;
  *)
    echo "ERROR invalid --status: ${STATUS}" >&2
    usage >&2
    exit 1
    ;;
esac

if [[ -z "${UPDATE_FILE}" || -z "${REVIEWER}" ]]; then
  echo "ERROR --file and --reviewer are required" >&2
  usage >&2
  exit 1
fi

TARGET_ROOT="$(cd "${TARGET_ROOT}" && pwd)"
if [[ "${UPDATE_FILE}" != /* ]]; then
  UPDATE_FILE="${TARGET_ROOT}/${UPDATE_FILE}"
fi
UPDATE_FILE="$(cd "$(dirname "${UPDATE_FILE}")" && pwd)/$(basename "${UPDATE_FILE}")"

PENDING_DIR="${TARGET_ROOT}/docs/project-memory/inbox/thread-updates"
ARCHIVE_DIR="${TARGET_ROOT}/docs/project-memory/inbox/archive"

case "${UPDATE_FILE}" in
  "${PENDING_DIR}/"*.md) ;;
  *)
    echo "ERROR file must be under ${PENDING_DIR}" >&2
    exit 1
    ;;
esac

if [[ ! -f "${UPDATE_FILE}" ]]; then
  echo "ERROR missing file: ${UPDATE_FILE}" >&2
  exit 1
fi

if grep -q "^## Main Thread Review$" "${UPDATE_FILE}"; then
  echo "ERROR update already has a Main Thread Review block: ${UPDATE_FILE}" >&2
  exit 1
fi

reviewed_at="$(date '+%Y-%m-%d %H:%M')"

{
  printf '\n## Main Thread Review\n\n'
  printf -- '- Review Status: %s\n' "${STATUS}"
  printf -- '- Reviewed By: %s\n' "${REVIEWER}"
  printf -- '- Reviewed At: %s\n' "${reviewed_at}"
  printf -- '- Review Note: %s\n' "${NOTE:-无}"
} >> "${UPDATE_FILE}"

if [[ "${ARCHIVE}" == "true" ]]; then
  mkdir -p "${ARCHIVE_DIR}"
  target="${ARCHIVE_DIR}/${STATUS}-$(basename "${UPDATE_FILE}")"
  if [[ -e "${target}" ]]; then
    echo "ERROR archive target already exists: ${target}" >&2
    exit 1
  fi
  mv "${UPDATE_FILE}" "${target}"
  echo "${target}"
else
  echo "${UPDATE_FILE}"
fi
