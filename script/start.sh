#!/bin/sh
set -eu

bin="${1:?missing udp2raw binary name (e.g. udp2raw_amd64)}"
shift

echo "-----------------------------------------------------"
echo "Starting ${bin} with args: $*"
echo "-----------------------------------------------------"

# Run udp2raw as PID 1 so it receives SIGTERM directly from `docker stop`
# and can clean up iptables rules added by `-a/--auto-rule`.
exec "${bin}" "$@"