# Haiku AI roadmap

This roadmap is evidence-driven. Dates are not promises. A milestone is complete only when its acceptance criteria are met and the evidence is recorded.

## Phase 0: establish a trustworthy baseline

- [ ] Record the exact upstream commit and local branch used for each build.
- [ ] Choose and document the first target architecture (initially x86_64).
- [ ] Document the supported build host and required packages from upstream instructions.
- [ ] Produce a clean build using the official Haiku build system.
- [ ] Produce a bootable image and boot it in an emulator.
- [ ] Save build logs, emulator configuration, and test results as release artefacts.
- [ ] Record baseline boot success, boot time, idle memory use, and known limitations.

**Exit criteria:** another developer can reproduce the build and emulator boot by following the written instructions.

## Phase 1: quality and regression infrastructure

- [ ] Define a small set of repeatable smoke tests for boot, storage, input, networking, and shutdown.
- [ ] Identify existing upstream tests and use them rather than duplicating them.
- [ ] Add automated checks that do not pretend to replace a full Haiku build.
- [ ] Establish a bug triage process with reproduction steps and logs.
- [ ] Track regressions against the baseline commit.

**Exit criteria:** every accepted change has an appropriate test or a documented reason why testing is manual.

## Phase 2: user-facing reliability

- [ ] Build a hardware compatibility inventory from actual test machines.
- [ ] Prioritise input devices, graphics, storage, USB, wired networking, and Wi-Fi by user impact.
- [ ] Fix reproducible bugs in small, isolated patches.
- [ ] Test installation, first boot, updates, recovery, and shutdown.
- [ ] Improve documentation for known hardware limitations.

**Exit criteria:** improvements are demonstrated on named hardware or in a reproducible emulator test.

## Phase 3: desktop and application experience

- [ ] Audit core desktop workflows from a new user's perspective.
- [ ] Identify missing or inconsistent native applications and settings.
- [ ] Improve accessibility, discoverability, localisation, and error messages.
- [ ] Preserve Haiku's native design rather than importing unrelated desktop conventions.
- [ ] Measure application availability and workflow completion against a defined comparison set.

**Exit criteria:** documented improvements solve real user tasks without introducing regressions.

## Phase 4: competitive evaluation

- [ ] Compare against RenkuOS on the same hardware and test conditions.
- [ ] Compare against upstream Haiku to show what Haiku AI itself contributes.
- [ ] Publish methods, versions, raw results, and known limitations.
- [ ] Fix the largest measured gaps before adding speculative features.

**Exit criteria:** repeatable evidence shows where Haiku AI is better, equal, or behind. Do not describe the whole OS as superior based on one benchmark.

## Non-goals

- Rewriting the kernel merely to make the project look original.
- Removing upstream components without dependency and build analysis.
- Replacing Haiku's build system before proving a concrete need.
- Adding AI features to the desktop when the project goal is AI-assisted OS engineering.
- Claiming compatibility based on code inspection alone.
