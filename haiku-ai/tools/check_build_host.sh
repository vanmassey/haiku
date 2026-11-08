#!/usr/bin/env bash
# Validate the documented host prerequisites before starting a Haiku build.
set -Eeuo pipefail

missing=()
required=(
    awk bison flex lex gcc g++ make autoheader automake nasm wget unzip xorriso
    as ld ar ranlib objcopy strip mformat mcopy mmd python3 git
)

for tool in "${required[@]}"; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        missing+=("$tool")
    fi
done

if (("${#missing[@]}" > 0)); then
    printf 'Missing required host commands:\n' >&2
    printf '  %s\n' "${missing[@]}" >&2
    exit 1
fi

if ! command -v pkg-config >/dev/null 2>&1; then
    printf 'ERROR: pkg-config is required to check zlib and zstd development libraries.\n' >&2
    exit 1
fi

if ! pkg-config --exists zlib libzstd; then
    printf 'ERROR: zlib and/or libzstd development files were not found by pkg-config.\n' >&2
    exit 1
fi

# Haiku requires a case-sensitive filesystem. Verify this in a temporary
# directory rather than creating probe files in the source checkout.
probe_dir="$(mktemp -d)"
trap 'rm -rf "$probe_dir"' EXIT
: > "$probe_dir/HaikuAI-case-probe"
if ! ( : > "$probe_dir/haikuai-case-probe" ) 2>/dev/null; then
    printf 'ERROR: the filesystem containing the temporary directory is not case-sensitive.\n' >&2
    exit 1
fi

printf 'Host prerequisite check passed.\n'
printf 'Compiler: %s\n' "$(gcc --version | head -n 1)"
printf 'zlib: %s\n' "$(pkg-config --modversion zlib)"
printf 'zstd: %s\n' "$(pkg-config --modversion libzstd)"
