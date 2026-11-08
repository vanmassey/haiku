#!/usr/bin/env bash
# Build a Haiku x86_64 nightly anyboot image using the upstream build system.
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
BUILDTOOLS_DIR="${BUILDTOOLS_DIR:-$(cd "$ROOT/.." && pwd)/buildtools}"
BUILD_DIR="${BUILD_DIR:-$ROOT/generated.x86_64}"
JOBS="${JOBS:-2}"
HOST_BIN="$BUILD_DIR/host-bin"

fail() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

[[ -d "$BUILDTOOLS_DIR/jam" ]] || fail "Buildtools not found at $BUILDTOOLS_DIR. Clone https://review.haiku-os.org/buildtools beside this Haiku checkout, or set BUILDTOOLS_DIR."
command -v make >/dev/null 2>&1 || fail "make is required"
command -v gcc >/dev/null 2>&1 || fail "gcc is required"
command -v git >/dev/null 2>&1 || fail "git is required"
command -v python3 >/dev/null 2>&1 || fail "python3 is required"

printf 'Haiku source: %s\n' "$ROOT"
printf 'Buildtools:   %s\n' "$BUILDTOOLS_DIR"
printf 'Build output: %s\n' "$BUILD_DIR"
printf 'Parallel jobs: %s\n' "$JOBS"

# Build Haiku's own Jam. Distribution-packaged Jam variants are not suitable.
make -C "$BUILDTOOLS_DIR/jam"
[[ -x "$BUILDTOOLS_DIR/jam/jam0" ]] || fail "Expected Jam executable was not produced at $BUILDTOOLS_DIR/jam/jam0"

mkdir -p "$HOST_BIN" "$BUILD_DIR"
ln -sf "$BUILDTOOLS_DIR/jam/jam0" "$HOST_BIN/jam"
export PATH="$HOST_BIN:$PATH"

# Configure the official x86_64 cross-toolchain in an ignored generated directory.
cd "$BUILD_DIR"
"$ROOT/configure" --cross-tools-source "$BUILDTOOLS_DIR" --build-cross-tools x86_64

# Build the official anyboot image target. This can take a long time and needs
# substantial free disk space. Preserve the full output in build.log.
set +e
jam -q "-j$JOBS" @nightly-anyboot 2>&1 | tee "$BUILD_DIR/build.log"
status=${PIPESTATUS[0]}
set -e
exit "$status"
