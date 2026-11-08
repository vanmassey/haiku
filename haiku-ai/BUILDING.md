# Building Haiku AI

Haiku AI currently builds the upstream Haiku x86_64 target. At this stage the
purpose is to establish a repeatable baseline, not to claim that Haiku AI has
already changed the operating system.

## Source layout

Keep the Haiku checkout and the official buildtools checkout side by side:

```text
work/
├── haiku/       # this repository
└── buildtools/  # https://review.haiku-os.org/buildtools
```

The buildtools repository is a separate upstream project and is not copied
into this repository.

## Linux host prerequisites

Use the current official Haiku build prerequisites for your Linux distribution:
<https://www.haiku-os.org/guides/building/pre-reqs>

The compiling guide lists the required host tools and libraries, including a
C/C++ compiler, make, bison, flex, awk, nasm, wget, unzip, xorriso, mtools,
Python 3, zlib, and zstd. A case-sensitive filesystem is required.

Do not substitute an arbitrary distribution Jam package. Haiku requires its
own Jam version, built from the buildtools repository.

## First build

From a case-sensitive filesystem, clone buildtools next to this checkout:

```sh
git clone https://review.haiku-os.org/buildtools ../buildtools
```

Then run:

```sh
bash haiku-ai/scripts/build-x86_64.sh
```

Before compiling, the script runs `haiku-ai/tools/check_build_host.sh`. This
checks the documented command-line prerequisites, verifies that pkg-config can
find zlib and zstd development files, and tests whether the temporary build
filesystem is case-sensitive. It then builds Haiku's Jam from buildtools,
configures the x86_64 cross-toolchain, and runs the upstream `@nightly-anyboot`
target. The generated
image is placed in the `generated.x86_64` output directory. The full Jam
output is saved as `haiku-ai/build.log`.

The default parallelism is two jobs to avoid overwhelming modest machines.
Override it explicitly when appropriate:

```sh
JOBS=4 bash haiku-ai/scripts/build-x86_64.sh
```

If buildtools is elsewhere:

```sh
BUILDTOOLS_DIR=/absolute/path/to/buildtools bash haiku-ai/scripts/build-x86_64.sh
```

## Important notes

- The first run compiles the cross-toolchain and can take a long time.
- Ensure there is substantial free disk space before starting.
- Do not commit generated build output or build logs.
- A successful build proves compilation and image generation only. It does
  not prove that the image boots or that physical hardware is supported.
- Record the source commit, buildtools commit, host environment, command,
  exit status, image checksum, and log for every baseline build.

## Emulator smoke test

After a successful image build, use QEMU with the image path and a suitable
x86_64 virtual machine configuration. Keep the first emulator test manual
until we have confirmed the exact image format and boot invocation produced
by the current build. Then encode that verified invocation in automation.
