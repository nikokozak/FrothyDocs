---
title: "04. Control Flow, `Cells`, and Records"
description: "Conditionals, loops, the narrow array type, and the current shaped-data surface."
weight: 4
---

Frothy grows by composing a small set of control forms rather than by adding
many special cases.

## Conditionals

Use `if`, `when`, and `unless` with explicit booleans. Frothy does not use
general truthiness.

```frothy
if adc.percent: A0 > 50 [
  led.on:
] else [
  led.off:
]
```

If an `if` has no `else` and the condition is false, the expression yields
`nil`.

## Loops

Use `while` for stateful repetition and `repeat` for counted repetition.

```frothy
repeat 3 as i [
  led.blink: i + 1, 40
]
```

`while` discards the body value and yields `nil` when it finishes.

## `Cells`

`Cells` is the fixed-size mutable indexed store in Frothy. In the accepted
`v0.1` spec it is the only collection value, and `cells(n)` is only valid in a
top-level rebinding form.

```frothy
frame is cells(8)
set frame[0] to 12
set frame[1] to true
```

Elements begin as `nil` and may hold `Int`, `Bool`, `Nil`, or `Text`.

## Records

The accepted `docs/spec/Frothy_Language_Spec_v0_1.md` still describes `Cells`
as the only collection value, but the current landed Frothy runtime and guide
also include records through `docs/adr/117-record-value-representation-and-persistence.md`.

That means the current public surface supports:

```frothy
record Point [ x, y ]
origin is Point: 0, 0
```

Records are fixed-layout shaped data. They are a better fit than `Cells` when
the thing you care about is named fields rather than indexed storage.

Treat records on this site as the current landed runtime surface, with the ADR
and guide as the source of truth until the accepted core spec is folded
forward.

Next: [Inspection and the live workflow](/guide/05-inspection-and-live-workflow/).
