#!/usr/bin/env bash
# Validate the documented host prerequisites before starting a Haiku build.
set -Eeuo pipefail

missing=()
required=(
    awk bison flex lex gcc g++ make autoheader automake nasm wget unzip xorriso
    as ld ar ranlib objcopy strip mformat mcopy mmd python3 git sha256sum
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

# A case-insensitive filesystem resolves the differently-cased name here.
probe_dir="$(mktemp -d)"
trap 'rm -rf "$probe_dir"' EXIT
: > "$probe_dir/HaikuAI-case-probe"
if [[ -e "$probe_dir/haikuai-case-probe" ]]; then
    printf 'ERROR: the filesystem containing the temporary directory is not case-sensitive.\n' >&2
    exit 1
fi
: > "$probe_dir/haikuai-case-probe"
if [[ ! -f "$probe_dir/HaikuAI-case-probe" || ! -f "$probe_dir/haikuai-case-probe" ]]; then
    printf 'ERROR: case-sensitivity probe did not create two distinct files.\n' >&2
    exit 1
fi

printf 'Host prerequisite check passed.\n'
printf 'Compiler: %s\n' "$(gcc --version | head -n 1)"
printf 'zlib: %s\n' "$(pkg-config --modversion zlib)"
printf 'zstd: %s\n' "$(pkg-config --modversion libzstd)"
