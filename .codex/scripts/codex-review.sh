#!/usr/bin/env bash
set -uo pipefail

review_out="$(mktemp "${TMPDIR:-/tmp}/codex-review-final.XXXXXX")"
review_log="$(mktemp "${TMPDIR:-/tmp}/codex-review-log.XXXXXX")"
keep_log=0
review_pid=""
heartbeat_pid=""
heartbeat_seconds="${CODEX_REVIEW_HEARTBEAT_SECONDS:-60}"
stalled_warn_seconds="${CODEX_REVIEW_STALLED_WARN_SECONDS:-900}"

positive_seconds_or_default() {
  local value="$1"
  local default="$2"

  if [[ "$value" =~ ^[1-9][0-9]*$ ]]; then
    printf '%s' "$value"
  else
    printf '%s' "$default"
  fi
}

format_duration() {
  local total_seconds="$1"
  local hours=$((total_seconds / 3600))
  local minutes=$(((total_seconds % 3600) / 60))
  local seconds=$((total_seconds % 60))

  if ((hours > 0)); then
    printf '%dh%02dm%02ds' "$hours" "$minutes" "$seconds"
  elif ((minutes > 0)); then
    printf '%dm%02ds' "$minutes" "$seconds"
  else
    printf '%ds' "$seconds"
  fi
}

log_size_bytes() {
  wc -c <"$review_log" | tr -d '[:space:]'
}

heartbeat_review() {
  local pid="$1"
  local started_at="$2"
  local interval="$3"
  local warn_after="$4"
  local last_size
  local last_change_at
  local now
  local current_size
  local elapsed
  local quiet_for
  local log_detail
  local warning_detail

  last_size="$(log_size_bytes)"
  last_change_at="$started_at"

  while kill -0 "$pid" 2>/dev/null; do
    sleep "$interval" || return 0
    if ! kill -0 "$pid" 2>/dev/null; then
      return 0
    fi

    now="$(date +%s)"
    current_size="$(log_size_bytes)"
    elapsed=$((now - started_at))

    if [[ "$current_size" != "$last_size" ]]; then
      last_size="$current_size"
      last_change_at="$now"
      log_detail="log grew to ${current_size} bytes"
    else
      quiet_for=$((now - last_change_at))
      log_detail="log unchanged for $(format_duration "$quiet_for") (${current_size} bytes)"
    fi

    warning_detail=""
    if ((now - last_change_at >= warn_after)); then
      warning_detail="; still alive, be patient before intervening"
    fi

    printf '[codex-review] still running: elapsed=%s pid=%s %s%s\n' \
      "$(format_duration "$elapsed")" \
      "$pid" \
      "$log_detail" \
      "$warning_detail" >&2
  done
}

stop_heartbeat() {
  if [[ -n "${heartbeat_pid:-}" ]]; then
    kill "$heartbeat_pid" 2>/dev/null || true
    wait "$heartbeat_pid" 2>/dev/null || true
    heartbeat_pid=""
  fi
}

cleanup() {
  stop_heartbeat
  rm -f "$review_out"
  if [[ "$keep_log" != "1" ]]; then
    rm -f "$review_log"
  fi
}
trap cleanup EXIT

heartbeat_seconds="$(positive_seconds_or_default "$heartbeat_seconds" 60)"
stalled_warn_seconds="$(positive_seconds_or_default "$stalled_warn_seconds" 900)"

codex exec review -m gpt-5.5 -c model_reasoning_effort='"xhigh"' -c sandbox_mode='"read-only"' --output-last-message "$review_out" --base origin/main >"$review_log" 2>&1 &
review_pid=$!
printf '[codex-review] review started: pid=%s heartbeat=%ss\n' "$review_pid" "$heartbeat_seconds" >&2
heartbeat_review "$review_pid" "$(date +%s)" "$heartbeat_seconds" "$stalled_warn_seconds" &
heartbeat_pid=$!
wait "$review_pid"
status=$?
stop_heartbeat

if [[ -s "$review_out" ]]; then
  cat "$review_out"
else
  cat "$review_log"
fi

if [[ "$status" -ne 0 ]]; then
  keep_log=1
  printf '\nFull Codex review log: %s\n' "$review_log" >&2
fi

exit "$status"
