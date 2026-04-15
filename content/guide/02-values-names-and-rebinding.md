---
title: "02. Values, Names, and Rebinding"
description: "How Frothy sees values, places, lookup, and stable top-level identity."
weight: 2
---

Frothy core exposes a small set of value classes:

- `Int`
- `Bool`
- `Nil`
- `Text`
- `Cells`
- `Code`

Everything user-facing is either a value or a place that holds one.

## Stable Top-Level Slots

At top level, a name refers to a stable slot identity. Rebinding changes the
current value stored in that slot, not the slot itself.

```frothy
speed is 75
speed is 120
```

That is not "create a new variable named `speed`". It is "write a new value
into the stable top-level slot named `speed`".

## Lookup Order

Frothy resolves names in this order:

1. current local scope
2. enclosing local scopes
3. top-level slots

That means a local can shadow a top-level slot:

```frothy
speed is 75

to demo [
  here speed is 10;
  speed
]
```

Inside `demo`, `speed` means the local binding, not the top-level slot.

## Rebinding Is A Feature, Not A Smell

Rebinding is central to the live workflow. If you redefine a top-level code
slot, callers that resolve through that slot observe the new behavior.

```frothy
to flash [ led.blink: 1, 75 ]
flash:

to flash [ led.blink: 3, 40 ]
flash:
```

This is one of Frothy's defining properties: the live image can evolve without
pretending every change is a fresh upload cycle.

## Base Image Versus Overlay

The running image has two conceptual layers:

- the base image, rebuilt on every boot
- the overlay image, created by your top-level evaluation

Base-image names such as `gpio.write` or `matrix.init` can be shadowed by an
overlay rebind, but `dangerous.wipe` restores the boot-rebuilt base value.

## Values Frothy Does Not Expose

The language does not make raw pointers, implementation-private control
objects, or general foreign handles into ordinary language values. That boundary
keeps persistence and inspection legible.

Next: [Code, locals, and blocks](/guide/03-code-locals-and-blocks/).
