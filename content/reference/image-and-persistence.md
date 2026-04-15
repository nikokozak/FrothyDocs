---
title: "Image and Persistence"
weight: 3
description: "Base versus overlay, rebinding, `save`, `restore`, `dangerous.wipe`, and `boot`."
---

Frothy persists the overlay image and rebuilds the base image at boot.

## Image Shape

**`base image and overlay image`** *(image model)*

Layer: `core`  
Behavior: The base image contains built-ins, foreign bindings, standard
library, and board library. The overlay contains user-created top-level state
after boot.  
Example:

```text
`gpio.write` is a base-image slot; `myProgram` is usually an overlay slot.
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, section 7.1

**`rebinding and base-name shadowing`** *(image model)*

Layer: `core`  
Behavior: Rebinding updates the current value stored in a stable slot. Base
names may be shadowed by overlay writes, but `dangerous.wipe` restores the
boot-rebuilt base value.  
Example:

```frothy
to blink [ 99 ]
dangerous.wipe
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, sections 7.2, 7.3

## Persistence Operations

**`save`** *(interactive base image)*

Layer: `core`  
Behavior: Snapshots the overlay image only. The saved walk includes overlay
top-level bindings plus persistable objects they own.  
Example:

```frothy
save
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, section 7.5

**`restore`** *(interactive base image)*

Layer: `core`  
Behavior: Replaces the live overlay with the persisted overlay. If restore
fails, the runtime must remain in a usable base state.  
Example:

```frothy
restore
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, section 7.6

**`dangerous.wipe`** *(interactive base image)*

Layer: `core`  
Behavior: Clears both the live overlay and the stored overlay and returns the
running image to base-only state.  
Example:

```frothy
dangerous.wipe
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, section 7.7

## Boot and Recovery

**`boot`** *(top-level slot)*

Layer: `core`  
Behavior: If `boot` holds `Code` after restore, the runtime executes it before
entering the prompt.  
Example:

```frothy
to boot [ led.on: ]
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, section 7.8

**`safe boot`** *(recovery surface)*

Layer: `core`  
Behavior: Lets you interrupt startup before restore and `boot` finish, so bad
saved state does not trap the device in a broken loop.  
Example:

```text
Press Ctrl-C during the safe-boot window, then inspect `boot` or wipe the overlay.
```

Source of truth: `docs/spec/Frothy_Language_Spec_v0_1.md`, sections 7.8, 8.3
