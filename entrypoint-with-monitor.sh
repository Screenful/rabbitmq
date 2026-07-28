#!/bin/sh
set -eu

/usr/local/bin/monitor-queues.sh &

exec docker-entrypoint.sh "$@"
