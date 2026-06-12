#!/usr/bin/env bash
set -euo pipefail

PROFILE="${1-default}"
if [[ ! "$PROFILE" =~ ^[A-Za-z0-9._-]+$ || "$PROFILE" == "." || "$PROFILE" == ".." ]]; then
  echo "Invalid profile name: $PROFILE (allowed chars: A-Z a-z 0-9 . _ -, excluding . and ..)" >&2
  exit 1
fi
VERSION="v0.1.0-beta.1"
RELEASE_BASE_URL="${AGENTRAIL_RELEASE_BASE_URL:-https://github.com/BlueMarlin1999/agentrail-public-assets/releases/download/${VERSION}}"
ARCHIVE_NAME="AgentRail-Friend-Test-Pack-v0.1.0-beta.1.tar.gz"
ARCHIVE_URL="${RELEASE_BASE_URL}/${ARCHIVE_NAME}"
TMP_DIR="$(mktemp -d)"
ARCHIVE_PATH="$TMP_DIR/$ARCHIVE_NAME"
EXTRACT_DIR="$TMP_DIR/extracted"
DEST_DIR="$HOME/.hermes/profiles/$PROFILE/skills/software-development/agentrail"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing required command: $1" >&2
    exit 1
  }
}

need_cmd curl
need_cmd grep
need_cmd tar
need_cmd cp
need_cmd mkdir

printf 'Installing AgentRail skill for profile: %s\n' "$PROFILE"
printf 'Release source: %s\n' "$RELEASE_BASE_URL"
printf 'Downloading: %s\n' "$ARCHIVE_URL"

mkdir -p "$EXTRACT_DIR"
CURL_RETRY_FLAGS=(--retry 3 --retry-delay 1 --connect-timeout 10 --max-time 120)
CURL_HELP="$(curl --help all 2>/dev/null || true)"
if grep -q -- '--retry-all-errors' <<<"$CURL_HELP"; then
  CURL_RETRY_FLAGS+=(--retry-all-errors)
fi
curl -fL "${CURL_RETRY_FLAGS[@]}" "$ARCHIVE_URL" -o "$ARCHIVE_PATH"
ARCHIVE_LIST="$TMP_DIR/archive-members.txt"
tar -tzf "$ARCHIVE_PATH" > "$ARCHIVE_LIST"
if grep -qE '(^/|(^|/)\.\.(/|$))' "$ARCHIVE_LIST"; then
  echo "Refusing to extract archive containing parent-traversal paths" >&2
  exit 1
fi
tar -xzf "$ARCHIVE_PATH" -C "$EXTRACT_DIR"

SRC_DIR="$EXTRACT_DIR/AgentRail-Friend-Test-Pack-v0.1.0-beta.1/hermes-skill/agentrail"
if [[ ! -d "$SRC_DIR" ]]; then
  echo "Expected skill directory not found: $SRC_DIR" >&2
  exit 1
fi

mkdir -p "$(dirname "$DEST_DIR")"
rm -rf "$DEST_DIR"
cp -R "$SRC_DIR" "$DEST_DIR"

printf '\nInstalled AgentRail skill to:\n%s\n' "$DEST_DIR"
printf '\nNext steps:\n'
printf '1. Open Hermes and load the agentrail skill.\n'
printf '2. Optional: download the full test pack from %s\n' "$ARCHIVE_URL"
printf '3. Verify with: python3 perpetual_engine/cli.py version\n'
printf '4. To override the release source, set AGENTRAIL_RELEASE_BASE_URL before running.\n'
