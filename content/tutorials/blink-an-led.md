---
title: "Blink an LED"
weight: 1
description: "Connect to a board, define a blink word, change it live, and save the image."
---

This tutorial uses the smallest useful hardware proof: make a pin change on a
real board, redefine the behavior, then save the live image.

## Check The Board

Run the environment check first:

```sh
froth doctor
```

If more than one serial device is visible, pass the port explicitly:

```sh
froth --port /dev/tty.usbserial-XXXX doctor
```

Then connect:

```sh
froth --port /dev/tty.usbserial-XXXX connect
```

## Define A Pulse

At the prompt, define one small word:

```froth
to pulse with pin, wait [
  gpio.high: pin;
  ms: wait;
  gpio.low: pin;
  ms: wait
]
```

Call it once:

```froth
pulse: LED_BUILTIN, 120
```

You should see the LED turn on briefly, then turn off.

## Build A Blink Word

Now define a repeated blink:

```froth
to blink with pin [
  repeat 3 [
    pulse: pin, 120
  ]
]
```

Run it:

```froth
blink: LED_BUILTIN
```

The important part is not the blink. The important part is that `blink` lives
in the current device image. You can inspect it and change it without reflashing
the board.

## Redefine It Live

Change the timing:

```froth
to blink with pin [
  repeat 5 [
    pulse: pin, 50
  ]
]
```

Call the same name again:

```froth
blink: LED_BUILTIN
```

The top-level slot named `blink` stayed stable. Its current value changed. Any
later call resolves through that same slot and sees the new behavior.

## Save Or Reset

When you want the overlay image to survive a reboot:

```froth
save
```

If you want to return to the base image:

```froth
dangerous.wipe
```

Use `dangerous.wipe` intentionally. It clears the saved overlay and the live
overlay state.
