---
title: "Troubleshooting"
weight: 4
description: "Recovery notes for workshop connection, display, loop, and saved-state problems."
---

## Board Won't Connect

Check the cable. Try `frothy --port /dev/tty.usbserial-XXXX doctor` if
multiple ports are visible. Swap the cable if in doubt.

## Matrix Stays Dark

Run:

```frothy
matrix.init:
grid.fill: true
grid.show:
```

If it is still dark, try:

```frothy
matrix.brightness!: 4
```

If it remains dark after that, the board may need swapping.

## Board Is Stuck Or Unresponsive

Press Ctrl-C to interrupt. If that does not work, unplug and replug the USB
cable. Press Ctrl-C during the safe boot prompt, then run:

```frothy
dangerous.wipe
```

## Puzzle State Is Broken

Type `restore` if you saved a working state earlier. If you never saved, type
`dangerous.wipe` to reset the puzzle words to their original broken defaults
and start over.

## Creative Project Is Broken

Click the joystick to stop the running loop. If the loop does not check
`joy.click?:`, press Ctrl-C. Edit `starter.frothy`, re-send, type `my.run:`.
If the board state is poisoned, run `dangerous.wipe` before re-sending.

## VS Code Cannot Find The CLI

Set `frothy.cliPath` in VS Code settings to the full path of the `frothy`
binary. Or fall back to the terminal:

```sh
frothy connect
```
