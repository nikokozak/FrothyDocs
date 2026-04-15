---
title: "Hardware"
weight: 6
description: "Shared base-image words plus the TM1629 protoboard display layers."
---

Frothy's maintained hardware surface is layered:

- [Base image](/reference/hardware/base-image/) for timing, GPIO, LED, ADC, and
  seeded pins
- [TM1629](/reference/hardware/tm1629/) for the canonical advanced display API
  on the protoboard target
- [Matrix](/reference/hardware/matrix/) for the small teaching-layer display
  API

This first public cut treats the TM1629-based `esp32-devkit-v4-game-board` as
the protoboard target while still documenting the shared base-image board
surface underneath it.
