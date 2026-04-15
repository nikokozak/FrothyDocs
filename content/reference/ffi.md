---
title: "FFI"
weight: 5
description: "The accepted Frothy/C boundary, allowed value classes, and project versus board extension paths."
---

Frothy's FFI is intentionally narrow. It exists to expose hardware and native
services without collapsing the language into raw C.

## Boundary Shape

**`foreign bindings as top-level Code values`** *(FFI)*

Layer: `FFI`  
Behavior: Foreign bindings are exposed as ordinary top-level base-image `Code`
values and are called with normal Frothy syntax.  
Example:

```frothy
gpio.write: LED_BUILTIN, 1
ms: 250
adc.read: A0
```

**`allowed value classes`** *(FFI)*

Layer: `FFI`  
Behavior: The first boundary is defined around `Int`, `Bool`, `Nil`, and
`Text`, with cells handles allowed where the shim stays clear. Raw pointers and
general foreign handles are not user-facing language values.  
Example:

```text
An FFI call may return an integer uptime, a boolean pin state, nil, or a text value. It must not expose a raw pointer as an ordinary Frothy value.
```

## Project and Board Paths

**`project FFI via froth.toml`** *(FFI)*

Layer: `FFI`  
Behavior: Project-local native extensions are declared in `froth.toml` and
compiled into the selected build.  
Example:

```toml
[ffi]
sources = ["src/ffi/bindings.c"]
includes = ["src/ffi"]
```

**`board FFI`** *(FFI)*

Layer: `FFI`  
Behavior: Board directories define the native board surface and the board base
library. Frothy then filters and publishes the subset that becomes part of the
maintained public surface.  
Example:

```text
`boards/<board>/ffi.c`, `ffi.h`, `board.json`, and `lib/base.frothy` together define the board path.
```

## Persistence Boundary

**`native runtime state does not persist`** *(FFI)*

Layer: `FFI`  
Behavior: Frothy persists the overlay image, not the native runtime state
behind FFI calls. This is a hard part of the boundary, not an implementation
accident.  
Example:

```text
Saving the image preserves your top-level overlay, not the internal C state of a device driver.
```
