---
title: "02. Values, Names, and Rebinding"
description: "How Froth sees values, places, lookup, and stable top-level identity."
weight: 2
---

Froth core exposes a small set of value classes:

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

```froth
speed is 75
speed is 120
```

That is not "create a new variable named `speed`". It is "write a new value
into the stable top-level slot named `speed`".

If you ask for `speed`, you get whatever value that slot holds *now*.

```froth
speed is 75
speed
```

Now rebind it:

```froth
speed is 120
speed
```

The name stayed the same. The slot stayed the same. The current value changed.
That distinction matters because Froth expects you to redefine code and data
while the image is live.

## Lookup Order

Froth resolves names in this order:

1. current local scope
2. enclosing local scopes
3. top-level slots

That means a local can shadow a top-level slot:

```froth
speed is 75

demo is fn [
  here speed is 10;
  speed
]
```

Inside `demo`, `speed` means the local binding, not the top-level slot.

It helps to see the lookup step by step:

```froth
speed is 75

demo is fn [
  here speed is 10;
  speed
]

demo:
```

When `demo` runs:

1. the block creates a lexical scope
2. `here speed is 10` creates a local called `speed`
3. the final `speed` expression looks for a local first
4. it finds the local `speed`, so lookup stops there

The result is `10`, not `75`.

Now remove the local:

```froth
speed is 75

demo is fn [
  speed
]

demo:
```

This time there is no local `speed`, so lookup falls through to the top-level
slot and the result is `75`.

## Nested Scope

The same rule applies to nested blocks.

```froth
speed is 75

probe is fn [
  here speed is 10;
  if true [
    here speed is 3;
    speed
  ] else [
    0
  ]
]
```

When the inner block asks for `speed`, it finds the innermost local first. The
result is `3`.

If that inner block uses a different local name instead:

```froth
speed is 75

probe is fn [
  here speed is 10;
  if true [
    here brightness is 3;
    speed
  ] else [
    0
  ]
]
```

then `speed` resolves to the outer local and the result is `10`.

That is the whole lookup story:

- nearest local wins
- then enclosing locals
- then top level

## Rebinding Is A Feature, Not A Smell

Rebinding is central to the live workflow. If you redefine a top-level code
slot, callers that resolve through that slot observe the new behavior.

```froth
flash is fn [ led.blink: 1, 75 ]
flash:

flash is fn [ led.blink: 3, 40 ]
flash:
```

This is one of Froth's defining properties: the live image can evolve without
pretending every change is a fresh upload cycle.

The same thing holds when one word calls another:

```froth
blink-fast is fn [ led.blink: 1, 40 ]
signal is fn [ blink-fast: ]

signal:

blink-fast is fn [ led.blink: 3, 90 ]
signal:
```

`signal` was not rewritten. It still resolves `blink-fast` through that stable
top-level slot, so it immediately sees the new behavior.

## Base Image Versus Overlay

The running image has two conceptual layers:

- the base image, rebuilt on every boot
- the overlay image, created by your top-level evaluation

Base-image names such as `gpio.write` or `matrix.init` can be shadowed by an
overlay rebind, but `dangerous.wipe` restores the boot-rebuilt base value.

That means you are free to experiment:

```froth
blink is fn [ 99 ]
blink:
dangerous.wipe
```

After `dangerous.wipe`, the base image is authoritative again.

## Values Froth Does Not Expose

The language does not make raw pointers, implementation-private control
objects, or general foreign handles into ordinary language values. That boundary
keeps persistence and inspection legible.

Next: [Code, locals, and blocks](/guide/03-code-locals-and-blocks/).
