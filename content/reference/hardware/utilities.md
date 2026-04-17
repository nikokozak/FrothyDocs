---
title: "Utilities"
weight: 4
description: "Timing, random, and math helpers commonly used by Machine sketches."
---

These words are not display or input words, but they are part of the practical
Machine sketch surface.

## Timing

**`millis:`** *(timing)* `() -> Int`

Behavior: Return current uptime in milliseconds.

```frothy
millis:
```

**`ms:`** *(timing)* `(durationMs) -> nil`

Behavior: Sleep for the given number of milliseconds.

```frothy
ms: 75
```

## Random

**`random.below:`** *(utility)* `(n) -> Int`

Behavior: Return a random integer from `0` to `n - 1`.

```frothy
random.below: grid.width
```

## Math

**`math.clamp:`** *(utility)* `(value, lo, hi) -> Int`

Behavior: Clamp a value to the inclusive range `lo..hi`.

```frothy
math.clamp: player.x, 0, (grid.width - 1)
```

**`math.wrap:`** *(utility)* `(value, size) -> Int`

Behavior: Wrap a value into the range `0..size - 1`.

```frothy
math.wrap: player.x, grid.width
```
