---
title: "Frothy"
description: "Learn the live lexical language for programmable devices."
---

Frothy is a small live lexical language for programmable devices.

```frothy
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

Frothy keeps the strongest substrate traits from Froth and changes the public
model where it needed to change. The language is built around stable named
slots, lexical scopes, non-capturing `Code`, explicit persistence, and direct
inspection of the live device image.

## Live Image, Not Upload Cycles

The running image is split into a boot-time base image and a live overlay.
Top-level names keep a stable identity while their current values can be
rebound. `save`, `restore`, and `dangerous.wipe` let you checkpoint, recover,
and reset that overlay without pretending the device is disposable.

## Lexical, Inspectable, Device-First

Frothy deliberately does not preserve Froth's old stack-centric user model.
Everything user-facing is either a value or a place that holds one. Blocks are
lexical. `Code` is just another value. Inspection is part of ordinary work:
`words`, `show`, `see`, `core`, and `info` are built into the maintained
interactive surface.

## Built For Real Boards

Frothy is embedded-device-first. Host and local paths exist to make
development faster, but the maintained proof path stays on connected ESP32
hardware. The first public protoboard target on this site is the TM1629-based
`esp32-devkit-v4-game-board`, with the shared base-image board library
documented underneath it.

On this site, that protoboard is introduced as the [Froth Machine](/machine/):
the display, joystick, knobs, and small game-shaped workflow you can learn in a
workshop without reading low-level board reference first.

## Start Here

- [Install Frothy](/install/) for the maintained CLI, VS Code, and board path.
- [Read the guide](/guide/) for the language and workflow from first
  principles.
- [Explore the Machine](/machine/) for the Froth Machine board, its words, its
  controls, and its first games.
- [Use the reference](/reference/) when you need exact behavior or library
  surface details.
- [Read how Frothy differs](/what-makes-frothy-different/) for the breaks from
  Froth and the reasons behind them.

The product is `Frothy`, but the installed CLI command is still `froth` during
the current transition. That naming split is deliberate and documented.
