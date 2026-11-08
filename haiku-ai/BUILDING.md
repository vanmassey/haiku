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

The upstream compiling guide lists the required host tools and libraries,
including a C/C++ compiler, make, bison, flex and lex, awk, nasm, wget, unzip,
xorriso, mtools, Python 3, zlib, and zstd. A case-sensitive filesystem is
required.

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
filesystem is case-sensitive. It then builds Haiku's Jam from buildtools and
configures the x86_64 cross-toolchain.

The configuration output is saved to
`generated.x86_64/configure.log`. If configuration succeeds, the script
runs the upstream `@nightly-anyboot` target. The expected image is
`generated.x86_64/haiku-nightly-anyboot.iso`, and Jam output is saved as
`generated.x86_64/build.log`. The output directory also receives
`build-metadata.txt`, recording source and buildtools commits, whether either
worktree has uncommitted changes, host details, commands, timestamps, exit
statuses, image size, and the image SHA-256 after a successful build.

The script removes an old image before starting and treats a successful Jam
exit without a new, non-empty image as a failed build. This prevents a stale
image from being mistaken for a fresh result. Configuration failures are
recorded too, with their own log and exit status.

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
  exit status, image checksum, and logs for every baseline build.

## Emulator smoke test

After a successful image build, install QEMU for your Linux distribution and
run:

```sh
bash haiku-ai/scripts/boot-qemu-x86_64.sh
```

The helper starts `qemu-system-x86_64` with the anyboot ISO as a virtual
CD-ROM, two virtual CPUs, and 2 GiB of memory. It does not enable KVM, so it
uses QEMU's portable emulation path. You can override the defaults:

```sh
MEMORY=3072 CPUS=4 bash haiku-ai/scripts/boot-qemu-x86_64.sh
```

Or select another QEMU executable and image:

```sh
QEMU=qemu-system-x86_64 IMAGE=/path/to/haiku-nightly-anyboot.iso bash haiku-ai/scripts/boot-qemu-x86_64.sh
```

This launches the emulator; it does not automatically determine whether Haiku
has reached the desktop. Record whether the boot succeeds, any visible errors,
and the time from starting QEMU to reaching the desktop. Do not report a
successful boot until it has been observed.
