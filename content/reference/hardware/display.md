---
title: "Display"
weight: 2
description: "The Frothy Machine display words across grid, matrix, and TM1629 layers."
aliases:
  - /reference/hardware/matrix/
  - /reference/hardware/tm1629/
---

The Frothy Machine display surface has three levels over the same 12x8 board:

- `grid.*` is the game-canvas vocabulary: cells, pixels, toggles, and simple
  workshop drawing.
- `matrix.*` is the display facade: initialization, brightness, flush, and
  geometric drawing.
- `tm1629.*` is the advanced display runtime: rows, staged frames, shifting,
  procedural fill, blits, and simulation helpers.

`grid.*` and `matrix.*` operate on the same framebuffer. It is normal to call
`grid.set:`, then `matrix.line:`, then `grid.show:` in one frame.

## Grid Canvas

**`grid.width`** *(grid)* `arity 0 -> Int`

Behavior: Logical display width. On the Frothy Machine this is `12`.

```frothy
grid.width
```

**`grid.height`** *(grid)* `arity 0 -> Int`

Behavior: Logical display height. On the Frothy Machine this is `8`.

```frothy
grid.height
```

**`grid.clear:`** *(grid)* `arity 0 -> nil`

Behavior: Clear the current framebuffer.

```frothy
grid.clear:
```

**`grid.set:`** *(grid)* `arity 3 -> nil`

Behavior: Set one pixel by `x`, `y`, and boolean value.

```frothy
grid.set: 1, 1, true
```

**`grid.get:`** *(grid)* `arity 2 -> Bool`

Behavior: Read one pixel by `x` and `y`.

```frothy
grid.get: 1, 1
```

**`grid.toggle:`** *(grid)* `arity 2 -> nil`

Behavior: Toggle one pixel by `x` and `y`.

```frothy
grid.toggle: 1, 1
```

**`grid.rect:`** *(grid)* `arity 5 -> nil`

Behavior: Draw an outline rectangle as `x`, `y`, `width`, `height`, and
boolean value.

```frothy
grid.rect: 0, 0, grid.width, grid.height, true
```

**`grid.fill:`** *(grid)* `arity 1 -> nil`

Behavior: Fill the whole framebuffer with a boolean value.

```frothy
grid.fill: true
```

**`grid.show:`** *(grid/display)* `arity 0 -> nil`

Behavior: Flush the framebuffer to the physical display.

```frothy
grid.show:
```

## Matrix Drawing

**`matrix.init:`** *(matrix)* `arity 0 -> nil`

Behavior: Initialize the display using the board's baked-in wiring.

```frothy
matrix.init:
```

**`matrix.brightness!:`** *(matrix)* `arity 1 -> nil`

Behavior: Set display brightness. The workshop-facing range is `0..7`.

```frothy
matrix.brightness!: 3
```

**`matrix.show:`** *(matrix)* `arity 0 -> nil`

Behavior: Flush the framebuffer to the physical display.

```frothy
matrix.show:
```

**`matrix.clear:`** *(matrix)* `arity 0 -> nil`

Behavior: Clear the current framebuffer.

```frothy
matrix.clear:
```

**`matrix.fill:`** *(matrix)* `arity 1 -> nil`

Behavior: Fill the whole framebuffer with a boolean value.

```frothy
matrix.fill: false
```

**`matrix.width`** *(matrix)* `arity 0 -> Int`

Behavior: Display width. On the Frothy Machine this is `12`.

```frothy
matrix.width
```

**`matrix.height`** *(matrix)* `arity 0 -> Int`

Behavior: Display height. On the Frothy Machine this is `8`.

```frothy
matrix.height
```

**`matrix.pixel@:`** *(matrix)* `arity 2 -> Bool`

Behavior: Read one framebuffer pixel by `x` and `y`.

```frothy
matrix.pixel@: 2, 3
```

**`matrix.pixel!:`** *(matrix)* `arity 3 -> nil`

Behavior: Set one framebuffer pixel by `x`, `y`, and boolean value.

```frothy
matrix.pixel!: 2, 3, true
```

**`matrix.line:`** *(matrix)* `arity 5 -> nil`

Behavior: Draw a line as `x0`, `y0`, `x1`, `y1`, and boolean value.

```frothy
matrix.line: 0, 0, 11, 7, true
```

**`matrix.rect:`** *(matrix)* `arity 5 -> nil`

Behavior: Draw an outline rectangle as `x`, `y`, `width`, `height`, and
boolean value.

```frothy
matrix.rect: 0, 0, 12, 8, true
```

**`matrix.fillRect:`** *(matrix)* `arity 5 -> nil`

Behavior: Draw a filled rectangle as `x`, `y`, `width`, `height`, and boolean
value.

```frothy
matrix.fillRect: 2, 2, 3, 2, true
```

## TM1629 Advanced Display

**`tm1629.width`** *(tm1629)* `arity 0 -> Int`

Behavior: TM1629 display width. On the Frothy Machine this is `12`.

```frothy
tm1629.width
```

**`tm1629.height`** *(tm1629)* `arity 0 -> Int`

Behavior: TM1629 display height. On the Frothy Machine this is `8`.

```frothy
tm1629.height
```

**`tm1629.rowMask`** *(tm1629)* `arity 0 -> Int`

Behavior: Bit mask for one 12-bit display row.

```frothy
tm1629.rowMask
```

**`tm1629.init:`** *(tm1629)* `arity 3 -> nil`

Behavior: Initialize the TM1629 transport with explicit `stb`, `clk`, and
`dio` pins.

```frothy
tm1629.init: TM1629_STB, TM1629_CLK, TM1629_DIO
```

**`tm1629.brightness!:`** *(tm1629)* `arity 1 -> nil`

Behavior: Set TM1629 brightness.

```frothy
tm1629.brightness!: 3
```

**`tm1629.show:`** *(tm1629)* `arity 0 -> nil`

Behavior: Flush the current framebuffer.

```frothy
tm1629.show:
```

**`tm1629.clear:`** *(tm1629)* `arity 0 -> nil`

Behavior: Clear the current framebuffer.

```frothy
tm1629.clear:
```

**`tm1629.fill:`** *(tm1629)* `arity 0 -> nil`

Behavior: Fill the current framebuffer.

```frothy
tm1629.fill:
```

**`tm1629.invert:`** *(tm1629)* `arity 0 -> nil`

Behavior: Invert the current framebuffer.

```frothy
tm1629.invert:
```

**`tm1629.shiftLeft:`** *(tm1629)* `arity 0 -> nil`

Behavior: Shift the current framebuffer one column left.

```frothy
tm1629.shiftLeft:
```

**`tm1629.shiftRight:`** *(tm1629)* `arity 0 -> nil`

Behavior: Shift the current framebuffer one column right.

```frothy
tm1629.shiftRight:
```

**`tm1629.shiftUp:`** *(tm1629)* `arity 0 -> nil`

Behavior: Shift the current framebuffer one row up.

```frothy
tm1629.shiftUp:
```

**`tm1629.shiftDown:`** *(tm1629)* `arity 0 -> nil`

Behavior: Shift the current framebuffer one row down.

```frothy
tm1629.shiftDown:
```

**`tm1629.row@:`** *(tm1629)* `arity 1 -> Int`

Behavior: Read one row mask by row index.

```frothy
tm1629.row@: 2
```

**`tm1629.row!:`** *(tm1629)* `arity 2 -> nil`

Behavior: Write one row mask by row index and mask.

```frothy
tm1629.row!: 2, 0b000000111100
```

**`tm1629.pixel@:`** *(tm1629)* `arity 2 -> Bool`

Behavior: Read one pixel by `x` and `y`.

```frothy
tm1629.pixel@: 5, 2
```

**`tm1629.pixel!:`** *(tm1629)* `arity 3 -> nil`

Behavior: Set one pixel by `x`, `y`, and boolean value.

```frothy
tm1629.pixel!: 5, 2, true
```

**`tm1629.plot@:`** *(tm1629)* `arity 2 -> Bool`

Behavior: Alias-shaped pixel read by `x` and `y`.

```frothy
tm1629.plot@: 5, 2
```

**`tm1629.plot!:`** *(tm1629)* `arity 3 -> nil`

Behavior: Alias-shaped pixel write by `x`, `y`, and boolean value.

```frothy
tm1629.plot!: 5, 2, true
```

**`tm1629.toggle!:`** *(tm1629)* `arity 2 -> nil`

Behavior: Toggle one pixel by `x` and `y`.

```frothy
tm1629.toggle!: 5, 2
```

**`tm1629.nextClear:`** *(tm1629)* `arity 0 -> nil`

Behavior: Clear the staged next-frame buffer.

```frothy
tm1629.nextClear:
```

**`tm1629.nextPixel!:`** *(tm1629)* `arity 3 -> nil`

Behavior: Set one staged next-frame pixel by `x`, `y`, and boolean value.

```frothy
tm1629.nextPixel!: 2, 3, true
```

**`tm1629.commitNext:`** *(tm1629)* `arity 0 -> nil`

Behavior: Copy the staged next-frame buffer into the current framebuffer.

```frothy
tm1629.commitNext:
```

**`tm1629.hLine:`** *(tm1629)* `arity 4 -> nil`

Behavior: Draw a horizontal line as `x`, `y`, length, and boolean value.

```frothy
tm1629.hLine: 2, 1, 5, true
```

**`tm1629.vLine:`** *(tm1629)* `arity 4 -> nil`

Behavior: Draw a vertical line as `x`, `y`, length, and boolean value.

```frothy
tm1629.vLine: 2, 1, 5, true
```

**`tm1629.rect:`** *(tm1629)* `arity 5 -> nil`

Behavior: Draw an outline rectangle as `x`, `y`, `width`, `height`, and
boolean value.

```frothy
tm1629.rect: 0, 0, 12, 8, true
```

**`tm1629.fillRect:`** *(tm1629)* `arity 5 -> nil`

Behavior: Draw a filled rectangle as `x`, `y`, `width`, `height`, and boolean
value.

```frothy
tm1629.fillRect: 1, 1, 3, 2, true
```

**`tm1629.eachXY:`** *(tm1629)* `arity 1 -> nil`

Behavior: Visit each display coordinate with a callback.

```frothy
tm1629.eachXY: fn with x, y [ grid.toggle: x, y ]
```

**`tm1629.populate:`** *(tm1629)* `arity 1 -> nil`

Behavior: Fill the framebuffer by calling a function with `x` and `y`; the
function returns the boolean pixel value.

```frothy
tm1629.populate: fn with x, y [ ((x + y) % 2) == 1 ]
```

**`tm1629.blit:`** *(tm1629)* `arity varies -> nil`

Behavior: Copy a sprite-like row pattern into the framebuffer.

```text
Use `info @tm1629.blit` on the board to inspect the exact live arity.
```

**`tm1629.lifeStep:`** *(tm1629)* `arity 0 -> nil`

Behavior: Advance the current framebuffer by one Conway's Game of Life step.

```frothy
tm1629.lifeStep:
grid.show:
```

## Raw TM1629 FFI

The `tm1629.raw.*` words expose the C-backed primitives below the Frothy
wrappers. Prefer the non-raw words unless you are debugging the driver layer or
matching low-level board code.

**`tm1629.raw.init:`** *(tm1629 raw)* `arity 3 -> nil`

Behavior: Initialize the raw TM1629 transport with explicit pins.

```frothy
tm1629.raw.init: TM1629_STB, TM1629_CLK, TM1629_DIO
```

**`tm1629.raw.show:`** *(tm1629 raw)* `arity 0 -> nil`

Behavior: Flush the raw framebuffer.

```frothy
tm1629.raw.show:
```

**`tm1629.raw.clear:`** *(tm1629 raw)* `arity 0 -> nil`

Behavior: Clear the raw framebuffer.

```frothy
tm1629.raw.clear:
```

**`tm1629.raw.row@:`** *(tm1629 raw)* `arity 1 -> Int`

Behavior: Read one raw row mask.

```frothy
tm1629.raw.row@: 2
```

**`tm1629.raw.row!:`** *(tm1629 raw)* `arity 2 -> nil`

Behavior: Write one raw row mask.

```frothy
tm1629.raw.row!: 2, 0b000000111100
```

**`tm1629.raw.next@:`** *(tm1629 raw)* `arity 1 -> Int`

Behavior: Read one staged raw next-frame row.

```frothy
tm1629.raw.next@: 2
```

**`tm1629.raw.next!:`** *(tm1629 raw)* `arity 2 -> nil`

Behavior: Write one staged raw next-frame row.

```frothy
tm1629.raw.next!: 2, 0b000000111100
```

**`tm1629.raw.nextClear:`** *(tm1629 raw)* `arity 0 -> nil`

Behavior: Clear the staged raw next-frame buffer.

```frothy
tm1629.raw.nextClear:
```

**`tm1629.raw.nextPixel!:`** *(tm1629 raw)* `arity 3 -> nil`

Behavior: Set one staged raw next-frame pixel.

```frothy
tm1629.raw.nextPixel!: 2, 3, true
```

**`tm1629.raw.commitNext:`** *(tm1629 raw)* `arity 0 -> nil`

Behavior: Commit the staged raw next-frame buffer.

```frothy
tm1629.raw.commitNext:
```

**`tm1629.raw.line:`** *(tm1629 raw)* `arity 5 -> nil`

Behavior: Draw a raw line.

```frothy
tm1629.raw.line: 0, 0, 11, 7, true
```

**`tm1629.raw.rect:`** *(tm1629 raw)* `arity 5 -> nil`

Behavior: Draw a raw outline rectangle.

```frothy
tm1629.raw.rect: 0, 0, 12, 8, true
```

**`tm1629.raw.fillRect:`** *(tm1629 raw)* `arity 5 -> nil`

Behavior: Draw a raw filled rectangle.

```frothy
tm1629.raw.fillRect: 1, 1, 3, 2, true
```
