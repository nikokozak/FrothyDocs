---
title: "Froth"
description: "Learn the live lexical language for programmable devices."
---

Froth is a small live lexical language for programmable devices.

```froth
to pulse with pin, wait [
  gpio.high: pin;
  ms: wait;
  gpio.low: pin
]

to blink with pin [
  repeat 3 [
    pulse: pin, 75;
    ms: 75
  ]
]

blink: LED_BUILTIN
save
```

Froth is built around stable named slots, lexical scopes, non-capturing `Code`,
explicit persistence, and direct inspection of the live device image. It keeps
the device in the center: change a name, inspect the result, save the image
when it is worth keeping.

## Live Image, Not Upload Cycles

The running image is split into a boot-time base image and a live overlay.
Top-level names keep a stable identity while their current values can be
rebound. `save`, `restore`, and `dangerous.wipe` let you checkpoint, recover,
and reset that overlay without pretending the device is disposable.

## Lexical, Inspectable, Device-First

Froth does not put a data stack at the user-facing center. Everything
user-facing is either a value or a place that holds one. Blocks are lexical.
`Code` is just another value. Inspection is part of ordinary work:
`words`, `show`, `see`, `core`, and `info` are built into the maintained
interactive surface.

## Built For Real Boards

Froth is embedded-device-first. Host and local paths make development faster,
but the maintained proof path stays on connected ESP32 hardware. The
protoboard target documented here is the TM1629-based
`esp32-devkit-v4-game-board`, with the shared base-image board library
underneath it.

On this site, that protoboard is introduced as the [Froth Machine](/machine/):
the display, joystick, knobs, and small game-shaped workflow you can learn in a
workshop without reading low-level board reference first.

## Start Here

- [Install Froth](/install/) for the CLI, release archives, and editor
  extension.
- [Read the guide](/guide/) for the language and workflow from first
  principles.
- [Follow a tutorial](/tutorials/) when you want a task-shaped path.
- [Explore the Machine](/machine/) for the Froth Machine board, its words, its
  controls, and its first games.
- [Use the Workshop](/workshop/) for the live puzzle activity, missions, quick
  reference, and troubleshooting.
- [Use the reference](/reference/) when you need exact behavior or library
  surface details.
- [Read the migration notes](/what-makes-froth-different/) if you are coming
  from OldFroth.