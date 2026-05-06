---
title: "07. Projects, Build, and Flash"
description: "The maintained CLI path for connecting, building, sending, and flashing."
weight: 7
---

The current public CLI name is `froth`, even though the product is Froth.

## The Small Command Set

The maintained first commands are:

```sh
froth doctor
froth connect
froth send src/main.froth
froth build
froth flash
```

Use them for different jobs:

- `froth doctor` checks the toolchain and board visibility
- `froth connect` opens the prompt directly
- `froth send` evaluates source on the connected target
- `froth build` assembles the selected project target
- `froth flash` writes firmware to the connected board

## Attendee Path Versus Maintainer Path

The attendee path is intentionally narrow:

- installed CLI
- VS Code extension
- preflashed `esp32-devkit-v1`

The maintainer path is broader and lives in the repo:

```sh
make build
make run
make test
make test-all
make test-publishability
```

Those source-build commands are real, but they are not the public front door.

## Whole-File Send And Honesty

The maintained editor story is explicit about control limitations. Selection
send is additive eval. Whole-file send is conceptually `reset + eval`, and the
tooling must not pretend a reset happened if the connected firmware cannot do
it safely.

## Flashing

Use flashing when you need to put sanctioned firmware or a new build on the
board, not as a substitute for ordinary live iteration.

Live redefinition is still the center of the language.

Next: [Hardware and the protoboard](/guide/08-hardware-and-the-protoboard/).
