# Localhost Launch Script Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add one simple script that serves the static Luna website locally and opens the homepage in Google Chrome.

**Architecture:** Keep the launcher repo-local under `.codex/scripts` beside the existing Codex review helper. Use Python's standard `http.server` for static file hosting, bind only to `127.0.0.1`, open `index.html` through `http://127.0.0.1:<port>/`, and stop the server when the script exits.

**Tech Stack:** Bash, Python 3 `http.server`, macOS `open`, Google Chrome.

---

### Task 1: Add Local Website Launcher

**Files:**
- Create: `.codex/scripts/launch-website.sh`

- [ ] **Step 1: Confirm repository shape**

Run:

```bash
find . -maxdepth 2 -type f | sort
```

Expected: the website is static HTML/CSS at the repository root, including `index.html`, `privacy.html`, `terms.html`, `support.html`, and `style.css`.

- [ ] **Step 2: Create the launcher**

Create `.codex/scripts/launch-website.sh` with:

```bash
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd -P)"
PORT="${LUNA_WEBSITE_PORT:-8080}"
HOST="127.0.0.1"
URL="http://$HOST:$PORT/"
SERVER_PID=""

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

python3 -m http.server "$PORT" --bind "$HOST" --directory "$ROOT_DIR" &
SERVER_PID="$!"

for _ in $(seq 1 50); do
  if python3 - "$HOST" "$PORT" <<'PY' >/dev/null 2>&1
import socket
import sys

host = sys.argv[1]
port = int(sys.argv[2])
with socket.create_connection((host, port), timeout=0.2):
    pass
PY
  then
    break
  fi
  sleep 0.1
done

if ! kill -0 "$SERVER_PID" 2>/dev/null; then
  wait "$SERVER_PID"
fi

open -a "Google Chrome" "$URL"
printf '[luna-website] Serving %s at %s\n' "$ROOT_DIR" "$URL"
printf '[luna-website] Press Ctrl-C to stop.\n'
wait "$SERVER_PID"
```

- [ ] **Step 3: Make the launcher executable**

Run:

```bash
chmod +x .codex/scripts/launch-website.sh
```

Expected: `test -x .codex/scripts/launch-website.sh` succeeds.

### Task 2: Verify Launcher Behavior

**Files:**
- Verify: `.codex/scripts/launch-website.sh`
- Verify: `docs/workflows/runtime-evidence.md`

- [ ] **Step 1: Syntax check**

Run:

```bash
bash -n .codex/scripts/launch-website.sh
```

Expected: exits with status 0 and prints nothing.

- [ ] **Step 2: Runtime check**

Run:

```bash
LUNA_WEBSITE_PORT=8080 ./.codex/scripts/launch-website.sh
```

Expected: Chrome opens `http://127.0.0.1:8080/`, the Luna landing page renders, and the terminal says the script is serving the repository root. Stop it with Ctrl-C after verification.

- [ ] **Step 3: HTTP smoke check**

While the launcher is running, run in another terminal:

```bash
curl -I http://127.0.0.1:8080/
```

Expected: `HTTP/1.0 200 OK` or `HTTP/1.1 200 OK`.

### Task 3: Commit and Push

**Files:**
- Commit: `.codex/scripts/launch-website.sh`
- Commit: `docs/plans/2026-05-23-localhost-launch-script.md`

- [ ] **Step 1: Create a branch if needed**

Run:

```bash
git status --short --branch
```

Expected: if the checkout is detached, create one branch named `codex/localhost-launch-script` at the current HEAD before committing.

- [ ] **Step 2: Commit**

Run:

```bash
git add .codex/scripts/launch-website.sh docs/plans/2026-05-23-localhost-launch-script.md
git commit -m "Add local website launch script"
```

Expected: commit succeeds.

- [ ] **Step 3: Review and push**

Run:

```bash
./.codex/scripts/codex-review.sh
git fetch origin main
git merge-tree "$(git merge-base HEAD origin/main)" HEAD origin/main >/tmp/luna-website-merge-check.txt
git push -u origin codex/localhost-launch-script
```

Expected: review passes or only false positives remain, merge check has no conflict markers, and the branch pushes.
