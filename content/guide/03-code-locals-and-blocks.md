---
title: "03. Code, Locals, and Blocks"
description: "How `Code`, lexical blocks, locals, and computed calls fit together."
weight: 3
---

`Code` is a first-class value in Frothy. You can bind it to a top-level slot,
pass it around, and call it with ordinary syntax.

## Named Code

Top-level definitions use `to` sugar:

```frothy
to pulse with pin, wait [
  gpio.high: pin;
  ms: wait;
  gpio.low: pin
]
```

This is shorthand for binding a top-level slot to a `Code` value with fixed
arity.

## Anonymous Code

Use `fn` when you want a `Code` value directly:

```frothy
twice is fn with action [
  action:;
  action:
]
```

## Blocks Yield Values

A block introduces a lexical scope and yields the value of its last expression.
If there is no final expression, the block yields `nil`.

```frothy
to add-one with n [
  here next is n + 1;
  next
]
```

## Locals And Mutation

Inside a block:

- `here name is expr` creates a local explicitly
- `name is expr` also creates a local in the current lexical scope
- `set name to expr` mutates an existing local

```frothy
to countdown with n [
  here current is n;
  while current > 0 [
    set current to current - 1
  ]
]
```

If there is no existing place to mutate, `set` is a runtime error.

## Non-Capturing `Code`

In `v0.1`, `Code` does not capture outer locals. A function body may use:

- its parameters
- names it binds inside its own body
- top-level names

This keeps the persistence model simpler and makes lexical resolution explicit.

## Ordinary And Computed Calls

The ordinary call form is:

```frothy
callee: arg1, arg2
```

When the callee is itself an expression, use `call`:

```frothy
call chooseAction: with
```

Applying a non-`Code` value is a runtime error, and arity is exact.

Next: [Control flow, `Cells`, and records](/guide/04-control-flow-cells-and-records/).
