# Competitive scorecard

The primary comparison is RenkuOS because it is also Haiku-based. Upstream Haiku is the control group: it helps distinguish improvements made by Haiku AI from improvements inherited from upstream.

Do not declare an overall winner from isolated anecdotes or one benchmark. Compare the same hardware, versions, settings, and test procedures.

## Scorecard

| Area | Measurement | Evidence required | Status |
|---|---|---|---|
| Build reliability | Clean builds / attempted builds | CI logs and build artefacts | Not measured |
| Boot reliability | Successful boots / attempts | Emulator and hardware test logs | Not measured |
| Installation | Successful clean installs and upgrades | Reproducible install tests | Not measured |
| Hardware support | Working devices by category | Named hardware inventory | Not measured |
| Stability | Crashes and hangs per test hour | Reproducible logs | Not measured |
| Performance | Boot time, responsiveness, memory use | Controlled repeated measurements | Not measured |
| Applications | Completion of common user tasks | Fixed application/workflow list | Not measured |
| Updates | Successful update and recovery | Upgrade/rollback test records | Not measured |
| Documentation | Task completion by a new tester | Structured usability test | Not measured |
| Maintenance | Review time, regression rate, release cadence | Repository and CI history | Not measured |

## Comparison rules

1. Record exact versions and commit SHAs.
2. Use identical hardware or clearly label different test environments.
3. Repeat timing and performance tests; report the method and spread, not just the best run.
4. Count a device as supported only after testing it.
5. Distinguish inherited Haiku functionality from Haiku AI changes.
6. Publish failures and limitations as well as successes.
7. Use "better in this measured area" unless evidence supports a broader claim.

## First comparison target

Start with a clean x86_64 emulator build of upstream Haiku and the same test configuration for the Haiku AI branch. Only after that baseline is repeatable should we compare with a specific RenkuOS release.
