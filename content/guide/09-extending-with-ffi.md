---
title: "09. Extending with FFI"
description: "The narrow Froth/C boundary, project FFI, and board FFI."
weight: 9
---

The FFI is where Froth meets C and board code. It is intentionally narrow.

The public rule is simple: foreign bindings appear as ordinary top-level
`Code` values in the base image.

## Surface Shape

You call FFI words with ordinary Froth syntax:

```froth
gpio.write: LED_BUILTIN, 1
ms: 250
adc.read: A0
```

That natural surface matters more than the temporary internal reuse of older
Froth substrate pieces.

## Allowed Value Classes

The first boundary is defined around small, persistable language values:

- `Int`
- `Bool`
- `Nil`
- `Text`

The implementation may also support cells handles where the shim stays clear.
Raw pointers and general foreign handles are not ordinary language-visible
values.

## Project FFI

Project-local FFI is declared in `froth.toml`:

```toml
[ffi]
sources = ["src/ffi/bindings.c"]
includes = ["src/ffi"]
```

That path is for "this project needs one native thing in addition to the board
baseline".

## Board FFI

Board FFI is the stronger maintained extension path. Board directories define
their own `board.json`, `ffi.h`, `ffi.c`, and base library. Froth then decides
which names become part of the public base-image surface.

## Persistence Boundary

Native runtime state does not persist. The persistent part is the Froth image,
not the C runtime behind it.

Next: [Where to go next](/guide/10-where-to-go-next/).
