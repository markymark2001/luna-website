# Launch Script Auto Port Implementation Plan

> **For agentic workers:** Follow this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `.codex/scripts/launch-website.sh` automatically serve on the next available local port when the preferred port is busy.

**Architecture:** Keep the launcher as a self-contained Bash script that uses Python standard-library socket checks before starting `python3 -m http.server`. Replace the single hard-fail port check with a bounded upward scan from `LUNA_WEBSITE_PORT` or `8080`, then build `URL` after the selected port is known.

**Tech Stack:** Bash, Python 3 sockets, Python `http.server`, macOS `open`.

---

### Task 1: Update Port Selection

**Files:**
- Modify: `.codex/scripts/launch-website.sh`

- [ ] **Step 1: Move URL construction after port selection**

Keep:

```bash
REQUESTED_PORT="${LUNA_WEBSITE_PORT:-8080}"
HOST="127.0.0.1"
PORT=""
URL=""
```

Expected: the script can select a different `PORT` before assigning `URL`.

- [ ] **Step 2: Add a reusable port availability check**

Add a `port_is_available()` Bash function that runs Python socket bind against `$HOST` and the candidate port:

```bash
port_is_available() {
  local candidate_port="$1"
  python3 - "$HOST" "$candidate_port" <<'PY' >/dev/null 2>&1
import socket
import sys

host = sys.argv[1]
port = int(sys.argv[2])
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
    sock.bind((host, port))
PY
}
```

Expected: function returns success only when the candidate port can be bound on `127.0.0.1`.

- [ ] **Step 3: Scan upward from the preferred port**

Add a `select_port()` Bash function:

```bash
select_port() {
  local start_port="$1"
  local max_port="${LUNA_WEBSITE_MAX_PORT:-65535}"
  local candidate_port

  [[ "$start_port" =~ ^[0-9]+$ ]] || fail "LUNA_WEBSITE_PORT must be a number."
  [[ "$max_port" =~ ^[0-9]+$ ]] || fail "LUNA_WEBSITE_MAX_PORT must be a number."
  (( start_port >= 1 && start_port <= 65535 )) || fail "LUNA_WEBSITE_PORT must be between 1 and 65535."
  (( max_port >= start_port && max_port <= 65535 )) || fail "LUNA_WEBSITE_MAX_PORT must be between LUNA_WEBSITE_PORT and 65535."

  for ((candidate_port = start_port; candidate_port <= max_port; candidate_port++)); do
    if port_is_available "$candidate_port"; then
      PORT="$candidate_port"
      return 0
    fi
  done

  fail "No available port found from $start_port to $max_port."
}
```

Expected: the launcher chooses `8081` when `8080` is busy, and still honors `LUNA_WEBSITE_PORT` as the starting point.

- [ ] **Step 4: Use selected port for server and URL**

Call:

```bash
select_port "$REQUESTED_PORT"
URL="http://$HOST:$PORT/"
```

Expected: `python3 -m http.server "$PORT" --bind "$HOST" --directory "$ROOT_DIR"` starts on the selected port.

### Task 2: Verify Launcher Behavior

**Files:**
- Verify: `.codex/scripts/launch-website.sh`

- [ ] **Step 1: Run shell syntax check**

Run:

```bash
bash -n .codex/scripts/launch-website.sh
```

Expected: no output and exit code `0`.

- [ ] **Step 2: Reproduce the busy-port case**

Start a temporary server on `8080`:

```bash
python3 -m http.server 8080 --bind 127.0.0.1
```

In another shell, run:

```bash
./.codex/scripts/launch-website.sh
```

Expected: the launcher prints `Serving ... at http://127.0.0.1:8081/` or the next available port, instead of failing with "Port 8080 is already in use." Stop it with Ctrl-C after verification.

- [ ] **Step 3: Verify explicit starting port**

Run with a high explicit port:

```bash
LUNA_WEBSITE_PORT=8090 ./.codex/scripts/launch-website.sh
```

Expected: the launcher serves at `http://127.0.0.1:8090/` when `8090` is free. Stop it with Ctrl-C after verification.

### Task 3: Commit And Push

**Files:**
- Stage: `.codex/scripts/launch-website.sh`
- Stage: `docs/plans/2026-05-25-launch-script-auto-port.md`

- [ ] **Step 1: Confirm status**

Run:

```bash
git status --short --branch
```

Expected: only the launch script and this plan are changed.

- [ ] **Step 2: Commit scoped changes**

Run:

```bash
git add .codex/scripts/launch-website.sh docs/plans/2026-05-25-launch-script-auto-port.md
git commit -m "Make website launcher choose available port"
```

Expected: commit succeeds.

- [ ] **Step 3: Push according to checkout state**

If the checkout is detached, create one `codex/` branch at the current HEAD, push it, and open a non-draft pull request into `main`.
