#!/usr/bin/env bash
# Boot a locally built Haiku x86_64 anyboot image in QEMU.
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
BUILD_DIR="${BUILD_DIR:-$ROOT/generated.x86_64}"
IMAGE="${IMAGE:-$BUILD_DIR/haiku-nightly-anyboot.iso}"
QEMU="${QEMU:-qemu-system-x86_64}"
MEMORY="${MEMORY:-2048}"
CPUS="${CPUS:-2}"

fail() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

[[ "$MEMORY" =~ ^[1-9][0-9]*$ ]] || fail "MEMORY must be a positive integer in MiB"
[[ "$CPUS" =~ ^[1-9][0-9]*$ ]] || fail "CPUS must be a positive integer"
[[ -s "$IMAGE" ]] || fail "Haiku image not found or empty: $IMAGE"
command -v "$QEMU" >/dev/null 2>&1 || fail "QEMU executable not found: $QEMU"

printf 'Booting image: %s\n' "$IMAGE"
printf 'Memory:       %s MiB\n' "$MEMORY"
printf 'CPUs:         %s\n' "$CPUS"
printf 'QEMU:         %s\n' "$QEMU"

exec "$QEMU" \
    -m "$MEMORY" \
    -smp "$CPUS" \
    -cdrom "$IMAGE" \
    -boot order=d
