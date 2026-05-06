---
title: "06. Persistence, Boot, and Recovery"
description: "How `save`, `restore`, `dangerous.wipe`, `boot`, and safe boot fit together."
weight: 6
---

Froth persists the overlay image, not the current execution.

That means local scopes, in-flight evaluation, and native runtime pointers do
not survive persistence. Top-level overlay state does.

## The Three Persistence Operations

```froth
save
restore
dangerous.wipe
```

- `save` snapshots the current overlay image
- `restore` replaces the current live overlay with the saved overlay
- `dangerous.wipe` clears both the live overlay and the stored overlay and
  returns the runtime to the base image

## `boot`

If the top-level slot `boot` holds `Code` after restore, the runtime executes
it under top-level recovery before entering the prompt.

```froth
boot is fn [
  led.on:
]
```

That makes `boot` the right place for small, explicit startup behavior.

## Safe Boot

Safe boot is the recovery valve when saved state is broken. On the maintained
interactive path, press `Ctrl-C` during the safe-boot window to skip restore
and `boot`, return to the prompt, inspect the current state, and repair or
wipe it.

## Base Image Recovery

Base-image names are the recovery anchor. If you shadow a base name in
the overlay and later call `dangerous.wipe`, the boot-rebuilt base value wins.

That rule is what lets Froth keep rebinding flexible without making recovery
fragile.

## A Good Habit

Do not save every experiment. Save when the overlay represents a coherent
working state that you would actually want to reconnect to.

Next: [Projects, build, and flash](/guide/07-projects-build-and-flash/).
