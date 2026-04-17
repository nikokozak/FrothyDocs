---
title: "05. Workshop"
weight: 5
description: "The guided puzzle, creative missions, and recovery reference for the Frothy workshop."
---

This page is for workshop participants. It assumes you have:

- the Frothy CLI installed (`frothy doctor` passes)
- the Frothy VS Code extension
- a preflashed board plugged in and connected

If you have not connected yet, start with [First steps](/machine/first-steps/).

## The Broken Beacon

The board has a set of words called `puzzle.*` baked into its base image. They
are supposed to work together to display a signal pattern on the LED matrix.

They do not work. Each one is broken in a different way.

Your job: figure out what each piece is supposed to do, fix it, and get the
full signal working. The tools you need are `words`, `show`, `info`, `set`, and
`to`.

### Stage 1: What is here?

Type `words` at the prompt. Scan the output for names you have not seen before.

You should find eight names starting with `puzzle.`:

- `puzzle.x`
- `puzzle.y`
- `puzzle.dot`
- `puzzle.frame`
- `puzzle.top`
- `puzzle.bottom`
- `puzzle.scene`
- `puzzle.reveal`

<details>
<summary>Hint</summary>

Type `words` and press enter. The output is grouped by origin. Look past the
familiar `grid.*` and `matrix.*` families.

</details>

### Stage 2: What does it do?

Pick one of the puzzle words and inspect it before calling it.

```frothy
show @puzzle.dot
```

Read the definition. Predict what will happen. Then call it:

```frothy
puzzle.dot:
```

A pixel should appear at position (5, 3). That is because `puzzle.dot` reads
two values, `puzzle.x` and `puzzle.y`, and lights the pixel at that position.

You can also check metadata:

```frothy
info @puzzle.dot
```

<details>
<summary>Hint</summary>

`show @name` prints the reconstructed definition. `info @name` prints the
value class, arity, and origin of a binding. Try both.

</details>

### Stage 3: Can you move the dot?

The dot appeared at (5, 3) because that is where `puzzle.x` and `puzzle.y`
point. Change them:

```frothy
puzzle.x
set puzzle.x to 10
puzzle.dot:
```

The dot should move to (10, 3).

<details>
<summary>Hint</summary>

Type just `puzzle.x` to see its current value. Then use `set puzzle.x to 10`
to change it. Call `puzzle.dot:` again to see the result.

</details>

### Stage 4: Fix a broken function

Call `puzzle.frame:`. You should see a single pixel at (0, 0). That is not
what it is supposed to do.

Inspect it:

```frothy
show @puzzle.frame
```

The definition only sets one pixel and does not clear the screen first. It is
supposed to draw a border rectangle around the full display.

Fix it by redefining the word:

```frothy
to puzzle.frame [
  grid.clear:;
  grid.rect: 0, 0, grid.width, grid.height, true;
  grid.show:
]
```

Call `puzzle.frame:` again. You should see a 12x8 border rectangle.

<details>
<summary>Hint 1</summary>

`grid.rect:` takes x, y, width, height, and a boolean flag. The full screen
is `grid.width` wide and `grid.height` tall.

</details>

<details>
<summary>Hint 2 (answer)</summary>

Type this:

```frothy
to puzzle.frame [ grid.clear:; grid.rect: 0, 0, grid.width, grid.height, true; grid.show: ]
```

</details>

### Stage 5: Fix a chain of three functions

Call `puzzle.scene:`. Nothing visible happens.

This is the core puzzle. Three things are broken at once, and you need to fix
all three before `puzzle.scene:` works.

Start by inspecting the chain:

```frothy
show @puzzle.scene
show @puzzle.top
show @puzzle.bottom
```

What you will find:

- `puzzle.scene` calls `puzzle.top:` and then `puzzle.bottom:`, but it does not
  clear the screen before drawing or show the result after
- `puzzle.top` fills the entire screen instead of just the top half
- `puzzle.bottom` does nothing at all

The fix is iterative. Start with `puzzle.scene` so you can see something on the
display, then fix the other two:

1. Redefine `puzzle.scene` to clear before and show after:

```frothy
to puzzle.scene [ grid.clear:; puzzle.top:; puzzle.bottom:; grid.show: ]
```

2. Call `puzzle.scene:`. You should see the full screen filled. That is the
   broken `puzzle.top` overshooting. Fix it to fill only the top three rows:

```frothy
to puzzle.top [ matrix.fillRect: 0, 0, grid.width, 3, true ]
```

3. Call `puzzle.scene:` again. A filled band across the top. Now fix
   `puzzle.bottom` to fill the bottom three rows:

```frothy
to puzzle.bottom [ matrix.fillRect: 0, 5, grid.width, 3, true ]
```

4. Call `puzzle.scene:`. Two filled bands with a dark gap in the middle.

<details>
<summary>Hint 1</summary>

Type `show @puzzle.scene`. What does it call? Now inspect those two functions.

</details>

<details>
<summary>Hint 2</summary>

Fix `puzzle.scene` first. It needs `grid.clear:` at the start and `grid.show:`
at the end. That way you can see what the other two functions produce.

</details>

<details>
<summary>Hint 3</summary>

`puzzle.top` should fill the top three rows (y=0 to y=2).
`puzzle.bottom` should fill the bottom three rows (y=5 to y=7).
Both use `matrix.fillRect:`.

</details>

<details>
<summary>Hint 4 (answer)</summary>

Fix all three:

```frothy
to puzzle.scene [ grid.clear:; puzzle.top:; puzzle.bottom:; grid.show: ]
to puzzle.top [ matrix.fillRect: 0, 0, grid.width, 3, true ]
to puzzle.bottom [ matrix.fillRect: 0, 5, grid.width, 3, true ]
```

</details>

**Done early?** Try making `puzzle.top` and `puzzle.bottom` draw different
patterns. An outline with `grid.rect:`, a diagonal with `matrix.line:`, or
something of your own.

### Stage 6: Wire it to a knob

Call `puzzle.reveal:`. You should see a filled bar 3 pixels wide on the left
side of the screen. Twist the left knob and call it again. Same bar.

Inspect it:

```frothy
show @puzzle.reveal
```

The width is hardcoded to 3. Make it respond to the left knob instead.

First, find out what the knob returns:

```frothy
knob.left:
```

Twist the knob and try again. It returns a value between 0 and 100.

Now redefine `puzzle.reveal` so the bar width tracks the knob:

```frothy
to puzzle.reveal [
  grid.clear:;
  grid.rect: 0, 0, (knob.left: * grid.width / 100), grid.height, true;
  grid.show:
]
```

Call `puzzle.reveal:`, twist the knob, call it again. The bar should change
width.

<details>
<summary>Hint 1</summary>

`knob.left:` returns 0 to 100. The grid is 12 pixels wide. Scale the knob
reading: `knob.left: * grid.width / 100`.

</details>

<details>
<summary>Hint 2 (answer)</summary>

```frothy
to puzzle.reveal [ grid.clear:; grid.rect: 0, 0, (knob.left: * grid.width / 100), grid.height, true; grid.show: ]
```

</details>

**Done early?** Make it use both knobs. Left controls width, right controls
height.

### Stage 7: Save your work

Type `save`. Your fixes are now stored on the board.

Type `restore`. Everything should still work. The board reloaded your saved
overlay.

### Stage 8: Break something and recover

Intentionally break one of your fixes:

```frothy
to puzzle.scene [ grid.clear:; grid.show: ]
puzzle.scene:
```

The screen goes blank. Your pattern is gone. Now recover:

```frothy
restore
puzzle.scene:
```

The two bands are back. The board returned to your last saved state.

If you had never saved, or your save is also broken, there is a harder reset:

```frothy
dangerous.wipe
```

That clears your live overlay and your saved snapshot. The board returns to its
base image. Your fixes are gone, but base-image words like `grid.*`, `matrix.*`,
and `puzzle.*` survive. The puzzle words return to their original broken state,
so you can start over.

---

## Creative Missions

Open `starter.frothy` from the
[workshop repo](https://github.com/nikokozak/frothy-workshop). Send it to
your board. Then type:

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

### Mission 1: Etch-a-Sketch

Make the joystick move a cursor that draws. Every pixel it visits stays lit.

**First change** — replace `my.update` and `my.draw`:

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

**Done?** Try these:

- Wrap coordinates so the cursor does not leave the screen. Use `math.wrap:` or
  `math.clamp:`.
- Left knob controls drawing speed. Change the `ms:` value in `my.frame`.
- Joystick click clears the screen. Add `when joy.click?: [ grid.clear: ]` to
  `my.update` and change the exit condition in `my.run`.

### Mission 2: Light Instrument

Both knobs control a visual pattern in real time. The joystick switches modes.

**First change** — replace `my.draw`:

```frothy
to my.draw [
  grid.clear:;
  grid.rect: 0, 0, (knob.left: * grid.width / 100), (knob.right: * grid.height / 100), true;
  grid.show:
]
```

**Done?** Try these:

- Add a second pattern using `matrix.fillRect:` instead of `grid.rect:`. Use a
  mode variable to switch between them.
- Add a counter. Define `my.tick is 0` at top level, increment it in
  `my.update`, and use `math.wrap: my.tick, grid.width` for scrolling effects.
- Add random sparkle with `random.below: grid.width` and
  `random.below: grid.height`.

### Mission 3: Micro-Game

Build a playable thing with something that moves on its own and something the
player controls.

**First change** — replace `my.update`:

```frothy
to my.update [
  when joy.left?:  [ set my.x to my.x - 1 ];
  when joy.right?: [ set my.x to my.x + 1 ];
  set my.y to my.y + 1;
  when my.y >= grid.height [ set my.y to 0 ]
]
```

**Done?** Try these:

- Add a target pixel at a random position. Reset when the player reaches it.
- Add an obstacle that scrolls across the screen. Detect collision.
- Track a score. Increase speed over time.

---

## Quick Reference

```
DISPLAY
  matrix.init:                    Initialize the display
  grid.clear:                     Clear all pixels
  grid.set: x, y, true           Light a pixel (0,0 = top-left)
  grid.rect: x, y, w, h, true    Draw a rectangle outline
  matrix.fillRect: x,y,w,h,true  Draw a filled rectangle
  grid.fill: true                 Fill all pixels
  grid.fill: false                Clear all pixels
  grid.show:                      Push to display
  matrix.brightness!: level       Brightness (0-7)

  grid.width  -> 12              grid.height -> 8

INPUT
  joy.up?:     joy.down?:         Joystick -> true/false
  joy.left?:   joy.right?:
  joy.click?:                     Joystick button
  knob.left:                      Left knob -> 0-100
  knob.right:                     Right knob -> 0-100

INSPECT
  words                           List all names
  show @name                      See a definition
  info @name                      See metadata

DEFINE AND CHANGE
  name is value                   Create a named value
  set name to value               Change a value
  to name [ ... ]                 Define/redefine a function
  to name with a, b [ ... ]       Function with parameters
  here x is 5                     Local variable

CONTROL FLOW
  if expr [ ... ] else [ ... ]    Conditional
  when expr [ ... ]               One-branch conditional
  while expr [ ... ]              Loop
  repeat n [ ... ]                Fixed-count loop
  repeat n as i [ ... ]           With counter

SAVE AND RECOVER
  save                            Snapshot to storage
  restore                         Reload from snapshot
  dangerous.wipe                  Factory reset
  Ctrl-C during boot              Safe boot

EXTRAS
  ms: 100                         Wait 100 milliseconds
  millis:                         Current uptime in ms
  random.below: n                 Random 0 to n-1
  math.clamp: val, lo, hi        Clamp to range
  math.wrap: val, size            Wrap around (modulo)

CALL SYNTAX
  word:                           No arguments
  word: a, b                      With arguments
  (word: a, b)                    Nested (wrap in parens)
```

---

## When Something Breaks

**Board won't connect:** Check the cable. Try `frothy --port /dev/tty.usbserial-XXXX doctor` if multiple ports are visible. Swap the cable if in doubt.

**Matrix stays dark:** Run `matrix.init:` first. Then `grid.fill: true; grid.show:`. If still dark, try `matrix.brightness!: 4`. If still dark, the board may need swapping.

**Board is stuck or unresponsive:** Press Ctrl-C to interrupt. If that does not work, unplug and replug the USB cable. Press Ctrl-C during the safe boot prompt, then run `dangerous.wipe`.

**Puzzle state is broken:** Type `restore` if you saved a working state earlier. If you never saved, type `dangerous.wipe` to reset the puzzle words to their original broken defaults and start over.

**Creative project is broken:** Click the joystick to stop the running loop. If the loop does not check `joy.click?:`, press Ctrl-C. Edit `starter.frothy`, re-send, type `my.run:`. If the board state is poisoned, run `dangerous.wipe` before re-sending.

**VS Code cannot find the CLI:** Set `frothy.cliPath` in VS Code settings to the full path of the `frothy` binary. Or fall back to the terminal: `frothy connect`.
