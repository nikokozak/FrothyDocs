---
title: "Hardware"
weight: 6
description: "Machine board words for display, input, utilities, and the shared base-image surface."
---

Frothy's maintained hardware surface is layered:

- [Board words](/reference/hardware/words/) for the one-page lookup table
- [Display](/reference/hardware/display/) for `grid.*`, `matrix.*`,
  `tm1629.*`, and `tm1629.raw.*`
- [Input](/reference/hardware/input/) for `joy.*?`, `knob.*`, and the raw
  button pattern
- [Utilities](/reference/hardware/utilities/) for timing, random, and math
  helpers used by Machine sketches
- [Base image](/reference/hardware/base-image/) for GPIO, LED, ADC, and seeded
  pins

This first public cut treats the TM1629-based `esp32-devkit-v4-game-board` as
the protoboard target while still documenting the shared base-image board
surface underneath it.

If you want the applied board docs first, use [Machine](/machine/). That
section teaches the Froth Machine as a board you can draw on and play with,
while this section stays focused on exact surface details.
