# Haiku AI

Haiku AI is an independently developed Haiku-based operating-system project. AI is used as an engineering assistant for research, implementation, review, testing, documentation, and maintenance. It is not an AI chatbot operating system.

## Principles

- Preserve Haiku's BeOS-inspired design, native APIs, and coherent desktop experience.
- Keep upstream Haiku history, copyright notices, and licence terms intact.
- Make project changes small, reviewable, tested, and documented.
- Prefer fixes that can be contributed upstream when they benefit Haiku generally.
- Never claim a feature works until it has been built and tested.
- Treat hardware compatibility and real-user reliability as first-class requirements.

## Repository layout

The upstream Haiku source remains in its existing locations. Project-specific planning and engineering policy live here in `haiku-ai/`. This separation avoids mixing project notes with upstream source files.

## First objective

Establish a repeatable baseline: identify the supported build host and target architecture, build a bootable image using Haiku's documented Jam-based build process, boot it in an emulator, and preserve logs and exact build instructions.

See [the roadmap](ROADMAP.md), [development rules](DEVELOPMENT.md), [testing strategy](TESTING.md), and [competitive scorecard](COMPETITIVE_SCORECARD.md).
