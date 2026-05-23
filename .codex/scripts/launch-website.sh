#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd -P)"
PORT="${LUNA_WEBSITE_PORT:-8080}"
HOST="127.0.0.1"
URL="http://$HOST:$PORT/"
SERVER_PID=""
SERVER_READY="false"

fail() {
  printf '[luna-website] ERROR: %s\n' "$*" >&2
  exit 1
}

cleanup() {
  if [[ -n "$SERVER_PID" ]] && kill -0 "$SERVER_PID" 2>/dev/null; then
    kill "$SERVER_PID" 2>/dev/null || true
    wait "$SERVER_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT INT TERM

command -v python3 >/dev/null 2>&1 || fail "python3 is required."
command -v open >/dev/null 2>&1 || fail "macOS open is required."
[[ -f "$ROOT_DIR/index.html" ]] || fail "index.html not found at $ROOT_DIR."

if ! python3 - "$HOST" "$PORT" <<'PY' >/dev/null 2>&1
import socket
import sys

host = sys.argv[1]
port = int(sys.argv[2])
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
    sock.bind((host, port))
PY
then
  fail "Port $PORT is already in use. Set LUNA_WEBSITE_PORT to another port and retry."
fi

python3 -m http.server "$PORT" --bind "$HOST" --directory "$ROOT_DIR" &
SERVER_PID="$!"

for _ in $(seq 1 50); do
  if python3 - "$URL" "$ROOT_DIR/index.html" <<'PY' >/dev/null 2>&1
import sys
from pathlib import Path
from urllib.request import urlopen

url = sys.argv[1]
index_path = Path(sys.argv[2])

with urlopen(url, timeout=0.2) as response:
    if response.read() != index_path.read_bytes():
        raise SystemExit(1)
PY
  then
    SERVER_READY="true"
    break
  fi
  sleep 0.1
done

if ! kill -0 "$SERVER_PID" 2>/dev/null; then
  wait "$SERVER_PID"
fi
[[ "$SERVER_READY" == "true" ]] || fail "Timed out waiting for $URL."

open -a "Google Chrome" "$URL"
printf '[luna-website] Serving %s at %s\n' "$ROOT_DIR" "$URL"
printf '[luna-website] Press Ctrl-C to stop.\n'
wait "$SERVER_PID"
