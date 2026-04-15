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

## The Usual Loop

A normal Frothy loop looks like this:

1. define or rebind a top-level slot
2. run it immediately
3. inspect what you just changed
4. redefine it if needed
5. save only when the overlay is in a state worth keeping

That loop is not a shortcut. It is the intended product surface.

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

## Inspection Is About The Image

Frothy's inspection tools are there to tell you about the current binding and
image state, not about a separate source-of-truth file on the host. That is
why rebinding, persistence, and inspection fit together cleanly.

Next: [Persistence, boot, and recovery](/guide/06-persistence-boot-and-recovery/).
