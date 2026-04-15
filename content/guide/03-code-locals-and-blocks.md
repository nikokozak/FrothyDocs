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

If you call `pulse`, Frothy looks up the top-level slot named `pulse`, finds a
`Code` value there, and runs it. That is the same lookup story you saw in the
last chapter. The only difference is that the value happens to be callable.

## Anonymous Code

Use `fn` when you want a `Code` value directly:

```frothy
twice is fn with action [
  action:;
  action:
]
```

That definition binds `twice` to a `Code` value which expects one argument, and
that argument is itself another `Code` value.

For example:

```frothy
beep is fn [ led.blink: 1, 30 ]
twice: beep
```

`twice` does not care what top-level slot the action came from. It only cares
that the value it received is callable.

## Blocks Yield Values

A block introduces a lexical scope and yields the value of its last expression.
If there is no final expression, the block yields `nil`.

```frothy
to add-one with n [
  here next is n + 1;
  next
]
```

Read that block line by line:

1. create a lexical scope for the block
2. bind `next`
3. evaluate the last expression, which is also `next`
4. return that value

If the last line were missing, the block would yield `nil`.

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

One small but important distinction:

```frothy
to demo with n [
  here total is n;
  set total to total + 1;
  total
]
```

`here total is n` creates the local. `set total to ...` updates the existing
local. If you try to `set` a name that does not already exist in a reachable
scope, Frothy signals an error instead of creating it silently.

## Non-Capturing `Code`

In `v0.1`, `Code` does not capture outer locals. A function body may use:

- its parameters
- names it binds inside its own body
- top-level names

This keeps the persistence model simpler and makes lexical resolution explicit.

The easiest way to understand the rule is to compare one working example and
one rejected example.

This works:

```frothy
unit is 75

to make-blink [
  fn with pin [
    gpio.high: pin;
    ms: unit;
    gpio.low: pin
  ]
]
```

Why it works:

- `pin` is a parameter of the inner `fn`
- `unit` is a top-level name
- the inner `fn` is not trying to reach into an outer local scope

Now compare that to this:

```frothy
to make-blink with wait [
  fn with pin [
    gpio.high: pin;
    ms: wait;
    gpio.low: pin
  ]
]
```

This is the shape Frothy rejects. `wait` is a local or parameter of the outer
function, and the inner `fn` is trying to capture it.

The rule is not "nested `fn` is forbidden". The rule is "nested `fn` may not
close over outer locals".

## How To Rewrite A Capturing Shape

Usually there are two clean rewrites.

First: move the shared value to top level if it is truly shared configuration.

```frothy
wait is 75

to make-blink [
  fn with pin [
    gpio.high: pin;
    ms: wait;
    gpio.low: pin
  ]
]
```

Second: pass the value explicitly at call time instead of trying to hide it in
the closure.

```frothy
to blink-once with pin, wait [
  gpio.high: pin;
  ms: wait;
  gpio.low: pin
]
```

That second form is usually the better Frothy answer. It keeps the data flow
visible.

## Scope Example: Inner `fn` With Its Own Locals

An inner `fn` may still create and use locals *inside itself*:

```frothy
to counter-stepper [
  fn with n [
    here next is n + 1;
    next
  ]
]
```

This is fine because `next` belongs to the inner function's own body.

## Scope Example: Choosing Between Top-Level And Local

One more example makes the non-capturing rule clearer.

```frothy
scale is 10

to build [
  here scale is 3;
  fn with n [
    n * scale
  ]
]
```

The question is: which `scale` should the inner `fn` mean?

If Frothy allowed capture, the answer would be "the local `scale` from `build`".
Frothy does not allow that. The inner function may only use its own locals,
its parameters, and top-level names. So this shape is rejected instead of
quietly creating a hidden closure.

That is the design tradeoff: a smaller, more explicit persistence and recovery
story instead of implicit captured environments.

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
