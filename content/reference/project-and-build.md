---
title: "Project and Build"
weight: 6
description: "Project file names, target versus board selection, build directories, and flashing policy."
---

Froth keeps project selection explicit. A target names the platform. A board
names the concrete board profile under `boards/`.

## Project Shape

**`froth.toml`** *(project manifest)*

Layer: `tooling`  
Behavior: Declares the project inputs the CLI needs to resolve source,
optional project FFI, and target-specific build state.  
Example:

```toml
[project]
name = "blink"
source = "src/main.froth"
```

**`src/main.froth`** *(project source)*

Layer: `tooling`  
Behavior: Conventional project entry source file. The editor can send any
current file, but project build/send commands use the manifest shape.

**`.froth-build/`** *(derived build directory)*

Layer: `tooling`  
Behavior: Derived project state. It is not source, and it should not be edited
or committed as a project artifact.

## Target Versus Board

**`--target`** *(CLI flag)*

Layer: `tooling`  
Behavior: Selects the platform layer, such as `posix` or `esp-idf`.  
Example:

```sh
froth --target esp-idf build
```

**`--board`** *(CLI flag)*

Layer: `tooling`  
Behavior: Selects the concrete board profile under `boards/`.  
Example:

```sh
froth --target esp-idf --board esp32-devkit-v1 build
```

Keep those two ideas separate. `esp-idf` is the target platform.
`esp32-devkit-v1` is a board profile.

## Build And Flash

**`froth build`** *(CLI command)*

Layer: `tooling`  
Behavior: Builds the selected project or repo checkout for the selected target
and board. Use `--clean` when target, board, or FFI inputs changed and stale
cache state would make the result ambiguous.

**`froth flash`** *(CLI command)*

Layer: `tooling`  
Behavior: Flashes the selected firmware to the connected device. For ordinary
live work, prefer `connect` and `send`; flashing is for firmware installation,
board recovery, and maintainer workflows.

## Board Files

A maintained board profile is a small set of files:

- `board.json` for capacities and board metadata
- `ffi.c` and `ffi.h` for native board bindings
- `lib/base.froth` or the generated base library surface for startup words

The public language does not expose raw C pointers or native handles as
ordinary persisted values. Board code publishes Froth values and words at the
base-image boundary.
