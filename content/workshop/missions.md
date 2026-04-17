---
title: "Missions"
weight: 2
description: "Creative follow-on projects for the Frothy Machine workshop."
---

Open `starter.frothy` from the
[workshop repo](https://github.com/nikokozak/frothy-workshop). Send it to your
board. Then type:

```frothy
my.run:
```

You should see a single dot. Click the joystick to stop. Edit the file,
re-send, run again.

The scaffold has five parts:

- `my.setup` initializes the display
- `my.update` is where you read inputs and change state
- `my.draw` is where you turn state into pixels
- `my.frame` does one update-draw-show-sleep cycle
- `my.run` repeats frames until you click the joystick

Pick a mission. Make it yours.

## Mission 1: Etch-A-Sketch

Make the joystick move a cursor that draws. Every pixel it visits stays lit.

Replace `my.update` and `my.draw`:

```frothy
to my.update [
  when joy.up?:    [ set my.y to my.y - 1 ];
  when joy.down?:  [ set my.y to my.y + 1 ];
  when joy.left?:  [ set my.x to my.x - 1 ];
  when joy.right?: [ set my.x to my.x + 1 ]
]

to my.draw [
  grid.set: my.x, my.y, true;
  grid.show:
]
```

Removing `grid.clear:` from `my.draw` is what makes pixels persist.

Try these next:

- Wrap coordinates so the cursor does not leave the screen. Use `math.wrap:`
  or `math.clamp:`.
- Left knob controls drawing speed. Change the `ms:` value in `my.frame`.
- Joystick click clears the screen. Add `when joy.click?: [ grid.clear: ]` to
  `my.update` and change the exit condition in `my.run`.

## Mission 2: Light Instrument

Both knobs control a visual pattern in real time. The joystick switches modes.

Replace `my.draw`:

```frothy
to my.draw [
  grid.clear:;
  grid.rect: 0, 0, (knob.left: * grid.width / 100), (knob.right: * grid.height / 100), true;
  grid.show:
]
```

Try these next:

- Add a second pattern using `matrix.fillRect:` instead of `grid.rect:`.
- Use a mode variable to switch between patterns.
- Add a counter. Define `my.tick is 0` at top level, increment it in
  `my.update`, and use `math.wrap: my.tick, grid.width` for scrolling effects.
- Add random sparkle with `random.below: grid.width` and
  `random.below: grid.height`.

## Mission 3: Micro-Game

Build a playable thing with something that moves on its own and something the
player controls.

Replace `my.update`:

```frothy
to my.update [
  when joy.left?:  [ set my.x to my.x - 1 ];
  when joy.right?: [ set my.x to my.x + 1 ];
  set my.y to my.y + 1;
  when my.y >= grid.height [ set my.y to 0 ]
]
```

Try these next:

- Add a target pixel at a random position. Reset when the player reaches it.
- Add an obstacle that scrolls across the screen. Detect collision.
- Track a score. Increase speed over time.

For reusable game shapes, see [Machine Patterns](/machine/patterns/).

