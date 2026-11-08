# Testing strategy

Testing must distinguish static checks, component tests, full builds, emulator boots, and physical-hardware tests. Passing one category does not imply passing the others.

## Test levels

| Level | What it proves | What it does not prove |
|---|---|---|
| Documentation checks | Project documentation has basic hygiene | Haiku builds or boots |
| Source/component tests | Tested code paths behave as expected | Whole-system integration |
| Clean build | Selected target compiles from the recorded source state | Runtime correctness |
| Emulator boot | Image starts in the recorded virtual hardware configuration | Physical hardware compatibility |
| Physical hardware | Tested device works on the named machine | Compatibility with all machines |
| Regression suite | Previously tested behaviours still pass | Absence of unknown bugs |

## Initial baseline record

For every baseline run, record:

- Date and time (UTC).
- Repository commit SHA and branch.
- Host OS and version.
- Compiler/toolchain versions.
- Target architecture and build configuration.
- Exact build command and exit status.
- Image filename and checksum.
- Emulator name/version and virtual hardware configuration.
- Boot result and relevant serial/console logs.
- Test names, results, and known failures.

Do not compare performance numbers unless the hardware, configuration, power settings, and measurement method are controlled.

## Initial smoke-test checklist

- [ ] Image is produced by a clean build.
- [ ] Emulator recognises the boot image.
- [ ] System reaches the desktop without a fatal error.
- [ ] Keyboard input works.
- [ ] Pointer input works.
- [ ] Boot volume is mounted.
- [ ] A test file can be created, read, and removed.
- [ ] Network interface is detected when enabled in the emulator.
- [ ] System shuts down or reboots cleanly.
- [ ] Logs are retained and linked to the run.

These are proposed checks, not claims that they currently pass.

## Failure reporting

A useful failure report includes the exact commit, environment, steps to reproduce, expected result, actual result, relevant logs, and whether the failure is repeatable. Avoid vague reports such as "it crashes" without evidence.
