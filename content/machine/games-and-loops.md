---
title: "04. Games and Loops"
weight: 4
description: "The usual shape of a small board game, plus built-in Pong and a Game of Life example."
---

Small Froth Machine games usually settle into the same rhythm:

1. `setup` initializes the display and starting state
2. `update` reads input and advances the model
3. `draw` turns the current state into pixels
4. `frame` does one update-draw-show-sleep cycle
5. `run` repeats frames until you stop

That is the usual board shape because it keeps time, input, and drawing visible.

## A Tiny Game Skeleton

```frothy
player.x is 5
player.y is 3
frame.ms is 60

to game.setup [
  matrix.init:;
  matrix.brightness!: 0;
  set player.x to 5;
  set player.y to 3
]

to game.update [
  when joy.left?:  [ set player.x to player.x - 1 ];
  when joy.right?: [ set player.x to player.x + 1 ];
  when joy.up?:    [ set player.y to player.y - 1 ];
  when joy.down?:  [ set player.y to player.y + 1 ]
]

to game.draw [
  grid.clear:;
  grid.set: player.x, player.y, true;
  grid.show:
]

to game.frame [
  game.update:;
  game.draw:;
  ms: frame.ms
]

to game.run with frames [
  repeat frames [
    game.frame:
  ]
]
```

This is not a finished game yet. It is the shape to copy.

For a real game, the next things you usually add are:

- bounds or collision rules
- scoring or mode state
- an exit condition such as `joy.click?`

## Built-In Pong

The board already ships with a Pong-shaped demo in the base library.

Start it like this:

```frothy
demo.pong.setup:
demo.pong.run: 240
```

What it does:

- the left knob controls the left paddle
- the right knob controls the right paddle
- the ball advances one frame at a time
- `joy.click?` exits the run loop early

If you want to inspect the shape more closely, these are the useful entry
points:

```frothy
show @demo.pong.setup
show @demo.pong.update
show @demo.pong.draw
show @demo.pong.frame
show @demo.pong.run
```

That built-in demo is worth studying because it uses the exact game structure
most people end up writing:

- `setup`
- `update`
- `draw`
- `frame`
- `run`

## What One Pong Frame Looks Like

The Pong demo's `frame` word is conceptually:

```frothy
demo.pong.update:
demo.pong.draw:
grid.show:
ms: demo.pong.frameMs
```

That is a good pattern even when you are not building Pong.

## A Small Game Of Life

The board also has a built-in display helper for Conway's Game of Life:
`tm1629.lifeStep`.

Seed a glider like this:

```frothy
matrix.init:
grid.clear:
grid.set: 2, 1, true
grid.set: 3, 2, true
grid.set: 1, 3, true
grid.set: 2, 3, true
grid.set: 3, 3, true
grid.show:
```

Then step it:

```frothy
repeat 24 [
  tm1629.lifeStep:;
  grid.show:;
  ms: 120
]
```

That example is useful for two reasons:

- it shows that the board can host small simulations, not only direct drawing
- it shows why the more advanced `tm1629.*` layer exists

`grid.*` and `matrix.*` are the front door. `tm1629.lifeStep` is the kind of
higher-level helper you reach for once your sketch becomes a real board toy.

## A Good First Machine Project

If you want one sensible progression, do it in this order:

1. light one pixel with `grid.set`
2. draw a line with `matrix.line`
3. read `joy.click?`
4. map a knob to a moving cursor
5. run `demo.pong`
6. change the Pong frame time or paddle size
7. seed a Life pattern and step it

By that point, the machine will stop feeling like a mysterious board and start
feeling like a small live graphics-and-input playground.
