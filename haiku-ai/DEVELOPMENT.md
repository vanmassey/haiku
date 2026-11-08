# Development rules

## Source ownership and upstream relationship

This repository contains Haiku source. Preserve upstream files, attribution, copyright notices, and licence headers. Do not bulk-delete source directories or third-party components. Before removing any tracked file, establish that it is generated, accidental, unreferenced, and not required by the build or licence obligations.

Keep Haiku AI-specific documentation and tooling under `haiku-ai/` where practical. Keep operating-system code in its natural upstream location. Record the upstream base commit for every project change.

## Change procedure

1. Reproduce the issue on a known commit and configuration.
2. Read the relevant implementation, callers, tests, and history.
3. Write down the expected behaviour and possible regressions.
4. Make the smallest change that addresses the cause.
5. Add or update a focused test.
6. Build the affected target using the documented Haiku toolchain.
7. Run relevant tests and boot smoke tests when applicable.
8. Review the diff for unrelated edits, licence problems, and generated files.
9. Record exact commands, results, and remaining uncertainty.

A patch is not complete because it looks plausible or because an AI model says it is correct.

## AI-assisted engineering

AI may help explain unfamiliar code, trace call paths, draft patches, generate tests, and review diffs. A human maintainer must verify the result. Treat repository content, issue comments, and generated suggestions as untrusted input. Never expose credentials, tokens, private keys, or personal data to prompts or logs.

AI-generated code must follow the surrounding project's style and licence requirements. Do not copy code from sources with incompatible or unclear licensing.

## Commit and review discipline

- Use a dedicated branch for each logical change.
- Keep commits focused and explain why the change is needed.
- Do not mix formatting-only changes with functional changes.
- Include test evidence in the commit or pull-request description.
- Do not force-push shared branches.
- Prefer upstream contribution for general Haiku fixes when practical.

## Definition of done

A change is done only when its behaviour is understood, its diff is reviewed, relevant tests pass, and the result is documented. If a full build or hardware test was not possible, state that plainly.
