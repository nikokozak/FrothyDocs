---
title: "08. Hardware and the Protoboard"
description: "Start with the shared base-image surface, then move up to the TM1629 protoboard layers."
weight: 8
---

Frothy's hardware story is layered.

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

## TM1629 And `matrix.*`

The protoboard layers are:

- `tm1629.raw.*` for maintained C-backed framebuffer primitives
- `tm1629.*` for the canonical advanced display API
- `matrix.*` for the small teaching layer with baked-in board pins

## First Protoboard Example

```frothy
matrix.init:
matrix.clear:
matrix.rect: 0, 0, 12, 8, true
matrix.line: 0, 0, 11, 7, false
matrix.show:
```

That code is already in the right shape for the protoboard: initialize the
display, mutate the framebuffer, then flush it.

## What This Site Covers In v1

This first site cut documents:

- the shared base-image board surface
- the TM1629 raw and high-level display surface
- the teaching-layer `matrix.*` display API

It does not try to fully document the broader workshop/game stack yet.

Next: [Extending Frothy with FFI](/guide/09-extending-with-ffi/).
