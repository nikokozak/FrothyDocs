---
title: "Matrix"
weight: 3
description: "The small teaching-layer display API built on top of the TM1629 board surface."
---

`matrix.*` is the small teaching layer for the TM1629-based protoboard. It is
the right place to start if you want to draw on the display without carrying
the full raw TM1629 surface in your head.

## Setup and Frame Control

**`matrix.init`, `matrix.brightness!`, `matrix.show`, `matrix.clear`, `matrix.fill`** *(board library)*

Layer: `board library`  
Behavior: Initialize the display with the baked-in board wiring, adjust
brightness, and manage the visible framebuffer.  
Example:

```frothy
matrix.init:
matrix.clear:
matrix.show:
```

## Drawing Surface

**`matrix.width`, `matrix.height`, `matrix.pixel@`, `matrix.pixel!`, `matrix.line`, `matrix.rect`, `matrix.fillRect`** *(board library)*

Layer: `board library`  
Behavior: The teaching-layer geometry and drawing API. These words are thin,
stable wrappers over the TM1629 display runtime.  
Example:

```frothy
matrix.rect: 0, 0, 12, 8, true
matrix.line: 0, 0, 11, 7, false
matrix.show:
```

## Scope Boundary

**`matrix.*` only** *(board library)*

Layer: `board library`  
Behavior: This first public site documents the display teaching layer only. It
intentionally does not document `game.*`, `button.*`, `pot.*`, or `joy.*` in
v1, even though those surfaces may exist elsewhere in the board stack.  
Example:

```text
Reach for `matrix.*` first when teaching or learning the protoboard display.
```
