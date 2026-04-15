---
title: "05. Inspection and the Live Workflow"
description: "Use the prompt to inspect the current image, not just to type code into the void."
weight: 5
---

Frothy is meant to be inspected while it is live. The prompt-facing surface is
not only for evaluation; it is also for asking the running image what it
contains.

## The Core Prompt Tools

Use these first:

```frothy
words
show @blink
see @blink
core @blink
info @blink
```

What they are for:

- `words` lists the currently live names
- `show @name` and `see @name` expose the normalized binding view
- `core @name` shows debug-oriented core rendering
- `info @name` reports binding metadata such as owner, kind, and persistability

Here is a more realistic pass:

```frothy
record Counter [ value ]
counter is Counter: 2
to counter.bump [ set counter->value to counter->value + 1 ]

words
show @counter
show @counter.bump
info @counter
info @counter.bump
```

What you are looking for:

- `words` should show both `counter` and `counter.bump`
- `show @counter` should render the current record value
- `show @counter.bump` should render the normalized code body
- `info` should tell you which binding is an overlay value, what kind it is,
  and whether it is persistable

## The Usual Loop

A normal Frothy loop looks like this:

1. define or rebind a top-level slot
2. run it immediately
3. inspect what you just changed
4. redefine it if needed
5. save only when the overlay is in a state worth keeping

That loop is not a shortcut. It is the intended product surface.

For example:

```frothy
record Cursor [ x, y ]
cursor is Cursor: 0, 0
to moveRight [ set cursor->x to cursor->x + 1 ]

moveRight:
show @cursor
moveRight:
show @cursor
save
```

This is normal Frothy work:

- define a small piece of state
- define a small operation
- run it immediately
- inspect the actual live result
- save only once the state is worth keeping

## Prompt Health

The maintained REPL:

- accumulates incomplete multiline input
- evaluates complete top-level forms
- keeps the prompt alive after recoverable errors
- lets `Ctrl-C` interrupt pending evaluation or pending multiline input

If the prompt state feels unclear, start with:

```frothy
words
info @boot
show @boot
```

If you think the wrong definition is live, add:

```frothy
show @yourName
see @yourName
info @yourName
```

That usually tells you whether the problem is:

- the slot you rebound is not the slot you thought you changed
- the current value is different from the source in your head
- the binding is base-owned when you thought it was overlay-owned

## Inspection Is About The Image

Frothy's inspection tools are there to tell you about the current binding and
image state, not about a separate source-of-truth file on the host. That is
why rebinding, persistence, and inspection fit together cleanly.

Next: [Persistence, boot, and recovery](/guide/06-persistence-boot-and-recovery/).
