---
title: "Word Reference"
weight: 1
description: "Core syntax, operators, state, collections, and prompt-facing built-ins."
---

This page covers the core language surface. Board and protoboard APIs live
under [Hardware](/reference/hardware/). CLI and editor behavior live under
[CLI](/reference/cli/) and [Interactive Profile](/reference/interactive-profile/).

## Top-Level Forms

**`name is expr`** *(core)*

Layer: `core`  
Behavior: Creates or rebinds a stable top-level slot. Rebinding changes the
current value stored in that slot without changing the slot's identity.  
Example:

```frothy
counter is 0
counter is counter + 1
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, sections 4.3, 5.1,
7.2

**`to name [ ... ]`, `to name with a, b [ ... ]`** *(core)*

Layer: `core`  
Behavior: Sugar for binding a top-level slot to a zero-arity or fixed-arity
`Code` value.  
Example:

```frothy
to blink with pin, wait [
  gpio.high: pin;
  ms: wait;
  gpio.low: pin
]
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, section 5.1

## Calls and Operators

**`callee: arg1, arg2`** *(core call syntax)*

Layer: `core`  
Behavior: Calls a `Code` value with ordinary Frothy syntax. Calling any
non-`Code` value is a runtime error.  
Example:

```frothy
blink: LED_BUILTIN, 75
gpio.write: LED_BUILTIN, 1
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, sections 5.3, 6.3

**`call expr with ...`** *(core call syntax)*

Layer: `core`  
Behavior: Calls the result of a computed expression rather than a literal name.
Useful when the callee itself is selected at runtime.  
Example:

```frothy
call chooseAction: with
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, section 5.3

**`* / % + - < <= > >= == != and or`** *(core operators)*

Layer: `core`  
Behavior: Left-to-right binary operators with equal precedence. Parentheses are
the only grouping mechanism. Conditions require explicit `Bool` values.  
Example:

```frothy
(adc.percent: A0) > 50 and enabled
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, sections 3.3, 3.4,
5.3, 6.1

## Locals and Mutation

**`here name is expr`, `name is expr` inside a block** *(core)*

Layer: `core`  
Behavior: Creates a lexical local binding in the current block scope. Locals
shadow outer locals and top-level names.  
Example:

```frothy
to twice with n [
  here next is n + n;
  next
]
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, sections 4.2, 4.3,
5.2

**`set place to expr`** *(core)*

Layer: `core`  
Behavior: Mutates an existing place. A place is either a name or an indexed
cells element. Missing places are an error.  
Example:

```frothy
set counter to counter + 1
set frame[0] to 99
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, sections 4.4, 5.1,
5.2

## Control Flow

**`if`, `when`, `unless`** *(core)*

Layer: `core`  
Behavior: Conditional expressions that require `Bool` conditions. `if` without
`else` yields `nil` when the condition is false.  
Example:

```frothy
when adc.percent: A0 > 50 [ led.on: ]
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, sections 3.4, 5.3,
6.4

**`while`, `repeat`, `repeat ... as name`** *(core)*

Layer: `core`  
Behavior: Loops over a condition or a count. `while` yields `nil`, and
`repeat ... as name` exposes the loop index as a local.  
Example:

```frothy
repeat 4 as i [ led.blink: i + 1, 30 ]
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, sections 5.3, 6.5

## Structured Data

**`cells(n)`, `expr[index]`** *(core)*

Layer: `core`  
Behavior: `Cells` is the narrow fixed-size mutable indexed store. In the
accepted `v0.1` spec, `cells(n)` is only valid in a top-level rebinding form.  
Example:

```frothy
buffer is cells(8)
set buffer[0] to 42
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, sections 3.8, 4.4,
7.4

**`record Name [ field, ... ]`, `Name: ...`** *(current landed runtime surface)*

Layer: `core`  
Behavior: Declares a fixed-layout record definition and uses the generated
constructor slot to create shaped values. This surface is implemented and
accepted via ADR-117, even though the older accepted `v0.1` spec has not yet
been folded forward to enumerate records.  
Example:

```frothy
record Point [ x, y ]
origin is Point: 0, 0
```

Source of truth: `docs/adr/117-record-value-representation-and-persistence.md`,
`docs/guide/Frothy_From_The_Ground_Up.md`

## Inspection and Persistence Built-Ins

**`words`, `show @name`, `see @name`, `core @name`, `info @name`** *(interactive base image)*

Layer: `core`  
Behavior: Inspect the live image: visible names, normalized binding view, core
debug view, and binding metadata.  
Example:

```frothy
words
info @blink
see @blink
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, section 8.4

**`save`, `restore`, `dangerous.wipe`** *(interactive base image)*

Layer: `core`  
Behavior: Persist, rebuild, or clear the overlay image. `dangerous.wipe`
returns the runtime to the base image.  
Example:

```frothy
save
restore
dangerous.wipe
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, sections 7.5, 7.6,
7.7, 8.1
