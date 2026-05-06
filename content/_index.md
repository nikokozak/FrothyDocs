---
title: "Froth"
description: "Learn the live lexical language for programmable devices."
---

**Froth is a small live lexical language for programmable devices, created by Nikolai Kozak.**

Froth is in pre-pre-pre alpha and in ongoing development. It was designed as a thesis project at the NYU ITP program.

You can get in contact with me at: nkozak [at] nyu [dot] edu.

Most of this site is OSAI generated (buyer beware) from the project repo at:

[Froth](https://github.com/nikokozak/froth) - Stable, ESP32 targeting.

[Frothy Rewrite](https://github.com/nikokozak/frothyrewrite) - Ongoing rewrite, ATMega328p and other small profiles.

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
the device in the center, and everything is live. You can change a name, inspect
the result, save the image when it is worth keeping.

## Live Image, Not Upload Cycles

The running image is split into a boot-time base image and a live overlay.
Top-level names keep a stable identity while their current values can be
rebound. `save`, `restore`, and `dangerous.wipe` let you checkpoint, recover,
and reset that overlay without pretending the device is disposable.

## Lexical, Inspectable, Device-First

Everything user-facing is either a value or a place that holds one.
`Code` is just another value. Inspection is part of ordinary work:
`words`, `show`, `see`, `core`, and `info` are built into the
interactive surface.

## Built For Real Boards

Froth is embedded-device-first. Host and local paths make development faster,
but the core is geared at embedded hardware. The
protoboard target documented here is the TM1629-based
`esp32-devkit-v4-game-board`, with the shared base-image board library
underneath it.

At the moment, Froth is only released for an ESP32 target. It is currently
being updated and rewritten. An experimental rewrite with support for the
ATMega328p, as well as more granular language profiles, can be found at:

[Experimental Rewrite](https://github.com/nikokozak/frothyrewrite)

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
- [Read the migration notes](/what-makes-froth-different/) if you need
  compatibility context.
