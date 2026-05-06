---
title: "Interactive Workflow"
weight: 2
description: "Use the prompt or editor as a live loop against the device-owned image."
---

Froth work is a loop: send a small change, run it on the board, inspect the
image, then revise the same names.

## Keep The Change Small

Start with one helper:

```froth
to dot with x, y [
  grid.clear:;
  grid.set: x, y, true;
  grid.show:
]
```

Run it:

```froth
dot: 2, 2
```

If the display is connected and initialized, one pixel should light.

## Use A Named Entry Point

Give yourself one command to rerun:

```froth
demo.run is fn [
  matrix.init:;
  matrix.brightness!: 1;
  dot: 2, 2
]
```

Now the edit loop has a stable handle:

```froth
demo.run:
```

Change `dot`, then run `demo.run:` again. The entry point resolves the current
value in the `dot` slot, not a stale copy.

## Inspect The Image

Use the same names the editor calls:

```froth
words
show @demo.run
see @dot
info @matrix.init
```

Inspection is part of normal work. It tells you what the image currently holds.

## Interrupt A Bad Loop

If you start a loop that runs too long:

```froth
repeat 1000000 [
  demo.run:;
  ms: 20
]
```

Press `Ctrl-C` at the prompt or use `Froth: Interrupt` in the editor. The
runtime checks for interrupts at safe points and returns to a usable prompt.

## Save The Session

When the current overlay is worth keeping:

```froth
save
```

Reboot, reconnect, and inspect the names again. The base image is rebuilt at
boot, then the saved overlay is restored on top.
