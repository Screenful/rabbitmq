#!/bin/sh
set -eu

THRESHOLD="${QUEUE_ALERT_THRESHOLD:-1000}"
INITIAL_DELAY_SECONDS="${QUEUE_MONITOR_INITIAL_DELAY_SECONDS:-20}"
INTERVAL_SECONDS="${QUEUE_MONITOR_INTERVAL_SECONDS:-600}"

echo "Queue monitor started"

check_queues() {
  output="$(rabbitmqctl list_queues -q name messages 2>/dev/null || true)"

  queue_count="$(printf '%s\n' "$output" | sed '/^$/d' | wc -l | tr -d ' ')"

  printf '%s\n' "$output" | while IFS='\t' read -r queue_name queue_length; do
    queue_name="${queue_name:-}"
    queue_length="${queue_length:-0}"

    case "$queue_length" in
      ''|*[!0-9]*)
        continue
        ;;
    esac

    if [ "$queue_length" -gt "$THRESHOLD" ]; then
      echo "SERROR Queue '${queue_name}' has ${queue_length} items (threshold=${THRESHOLD})"
    fi
  done

  echo "Queue monitor: check successfully finished (queue count=${queue_count})"
}

sleep "$INITIAL_DELAY_SECONDS"

while true; do
  check_queues
  sleep "$INTERVAL_SECONDS"
done
