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

Here is the same control style in a shape you can reuse:

```frothy
to classify with percent [
  cond [
    when percent < 20 [ "low" ];
    when percent < 80 [ "ok" ];
    else [ "high" ]
  ]
]

classify: 12
classify: 50
classify: 95
```

What happens here is plain:

- the first true branch wins
- the chosen block returns an ordinary value
- that value becomes the result of the whole `cond`

## Loops

Use `while` for stateful repetition and `repeat` for counted repetition.

```frothy
repeat 3 as i [
  led.blink: i + 1, 40
]
```

`while` discards the body value and yields `nil` when it finishes.

The useful pattern is "keep state in visible places, then return a value after
the loop":

```frothy
to sumTo with limit [
  here total is 0;
  here i is 0;
  while i < limit [
    set total to total + i;
    set i to i + 1
  ];
  total
]

sumTo: 5
sumTo: 10
```

This stays readable because nothing is hidden:

- the condition reads ordinary names
- the body mutates ordinary places
- the final expression returns the useful result

## `Cells`

`Cells` is the fixed-size mutable indexed store in Frothy. In the accepted
`v0.1` spec it is the only collection value, and `cells(n)` is only valid in a
top-level rebinding form.

```frothy
frame is cells(8)
set frame[0] to 12
set frame[1] to true
```

Elements begin as `nil`. The safe mental model is still "small fixed indexed
storage", but the current landed runtime also allows record values in cells.

For plain counted storage, keep it simple:

```frothy
histogram is cells(4)

set histogram[0] to 0
set histogram[1] to 0
set histogram[2] to 0
set histogram[3] to 0

to bucket with sample [
  if sample < 25 [
    0
  ] else [
    if sample < 50 [
      1
    ] else [
      if sample < 75 [ 2 ] else [ 3 ]
    ]
  ]
]

to countSample with sample [
  here slot is bucket: sample;
  set histogram[slot] to histogram[slot] + 1
]

countSample: 10
countSample: 62
countSample: 91
countSample: 62
```

That is an effective `Cells` example because index position is the whole point.
If you keep forgetting what index `2` means, you probably want records.

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

The first useful record example is just "one coherent piece of state with
names":

```frothy
record Sprite [ x, y, visible ]

player is Sprite: 3, 4, true

player->x
player->visible
```

That reads better than `state[0]` and `state[2]` because the shape is carried
in the value.

Field mutation is ordinary Frothy mutation:

```frothy
set player->x to player->x + 1
set player->visible to false

player->x
player->visible
```

This is the normal pattern:

- keep the long-lived thing in a top-level slot
- read the fields directly
- mutate only the place that changed

You can also write small helpers against that shaped value:

```frothy
to moveRight with sprite, step [
  set sprite->x to sprite->x + step
]

moveRight: player, 2
player->x
```

That is often the right level of abstraction in Frothy. You do not need a
class system or an object bag just to move one thing across the board.

## Records Inside `Cells`

Once you want several shaped values in a fixed indexed store, combine the two
surfaces:

```frothy
record Pixel [ x, y, on ]

pixels is cells(2)
set pixels[0] to Pixel: 1, 2, true
set pixels[1] to Pixel: 5, 6, false

pixels[0]->x
pixels[1]->on
```

You can mutate through the indexed place too:

```frothy
set pixels[1]->on to true
pixels[1]->on
```

This is a good fit for "array of state records" work such as actors, points, or
simple display updates.

## Nested Records

Record fields may themselves hold records. That is enough for small hierarchies
without turning the language into a dynamic object system.

```frothy
record Point [ x, y ]
record Actor [ pos, glyph ]

ghost is Actor: Point: 7, 2, "@"

ghost->pos->x
ghost->glyph
```

The access path stays literal. `ghost->pos->x` only works because `pos` is a
record field and that nested record has an `x` field.

## Records And Persistence

Records are useful partly because they persist cleanly when their fields are
persistable:

```frothy
record Counter [ value ]
counter is Counter: 0

set counter->value to counter->value + 1
save
set counter->value to 9
restore
counter->value
```

After `restore`, the value is back to `1`.

That makes records a strong fit for saved board state, counters, cursor
position, display mode, or other overlay-owned data.

## Choosing The Shape

Use `Cells` when:

- order and index position matter most
- the storage is fixed-size
- the lanes are simple enough that numbers like `0` and `1` stay meaningful

Use records when:

- the thing has named parts
- field names make the code easier to read
- you want one coherent shaped value

Use both when:

- you want a fixed indexed container full of shaped values

Treat records on this site as the current landed runtime surface, with the ADR
and guide as the source of truth until the accepted core spec is folded
forward.

Next: [Inspection and the live workflow](/guide/05-inspection-and-live-workflow/).
