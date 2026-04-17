---
title: "08. Hardware and the Protoboard"
description: "Start with the Froth Machine front door, then drop into the lower-level board layers when needed."
weight: 8
---

Frothy's hardware story is layered.

As a first-time board user, do not start by memorizing the low-level display
stack. Start with the [Machine](/machine/) section instead.

That section teaches the Froth Machine the way most people actually encounter
it:

- a 12x8 display
- a joystick with click
- two knobs
- a few drawing words
- a small game-shaped workflow

Then come back here when you want to understand how the layers fit together.

Start with the shared base-image words such as `millis`, `gpio.*`, `ms`,
`blink`, `led.*`, and `adc.percent`. Then move up to board-specific layers.

The first public protoboard target on this site is the TM1629-based
`esp32-devkit-v4-game-board`.

## Shared Base-Image Surface

These are the board-agnostic shapes you should expect first:

```frothy
millis:
gpio.output: LED_BUILTIN
gpio.high: LED_BUILTIN
gpio.low: LED_BUILTIN
led.blink: 3, 75
adc.percent: A0
```

Those words are seeded into the base image so they survive `dangerous.wipe`.

## Display Layers

The protoboard layers are:

- `tm1629.raw.*` for maintained C-backed framebuffer primitives
- `tm1629.*` for the canonical advanced display API
- `matrix.*` for the small teaching layer with baked-in board pins
- `grid.*` for the workshop-facing 12x8 game canvas

## First Protoboard Example

```frothy
matrix.init:
grid.clear:
grid.rect: 0, 0, grid.width, grid.height, true
matrix.line: 0, 0, 11, 7, false
grid.show:
```

That code is already in the right shape for the protoboard: initialize the
display, mutate the framebuffer, then flush it.

For friendlier board-first examples such as joystick input, knob control,
Game of Life, and Pong, go straight to [Machine](/machine/).

Next: [Extending Frothy with FFI](/guide/09-extending-with-ffi/).
