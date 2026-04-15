---
title: "How Frothy Is Different"
description: "What Frothy keeps from Froth, what it changes, and why the language surface now looks different."
---

Frothy is not "Froth with a cosmetic rename". It keeps major substrate strengths
from Froth and deliberately changes the public language model where the old
surface was no longer serving the product.

## No Stack-Centric Public Model

Froth taught the language through a visible data stack. Frothy does not.

The user-facing center is now:

- stable named slots
- lexical locals
- `Code` as an ordinary value
- explicit places and mutations

That makes the language easier to inspect, easier to persist, and easier to
teach without requiring every concept to be translated through stack effects.

## Stable Slot Identity Is The Real Top Level

At top level, a name refers to a stable slot identity. Rebinding changes the
slot's current value, not the slot itself.

That one shift makes coherent live redefinition much easier to reason about.
Existing callers keep resolving through the same slot. Recovery remains honest
because the base image can still rebuild the same slot set.

## `Code` Is Lexical And Non-Capturing

Frothy `Code` values use lexical name resolution and do not capture outer
locals.

That sounds like a restriction, but it is one of the reasons the image,
persistence, and inspection story stays small and legible.

## Persistence Is Explicit And Recoverable

Froth had persistence. Frothy keeps that strength and makes the public contract
cleaner:

- `save` snapshots the overlay image
- `restore` rebuilds that overlay image
- `dangerous.wipe` clears it and returns to base
- safe boot exists to recover from bad saved state

The image is the state that matters, not a daemon cache or a host-side shadow
runtime.

## Inspection Is Part Of Ordinary Work

Frothy treats `words`, `show`, `see`, `core`, and `info` as part of the normal
prompt surface. Inspection is not a debugging afterthought. It is one of the
reasons a live language can stay trustworthy.

## Device-First, Tool-Thin

Frothy is embedded-device-first. Host and local paths exist to help you move
faster, but they are not the product center.

That also shows up in the control surface:

- raw REPL by default
- explicit exclusive `.control` sessions for tooling
- no daemon required to preserve state
- editor tooling built as a thin client over that device-owned image

## Froth Still Matters, But As Substrate

Frothy still reuses working Froth substrate where it helps:

- slot tables
- heap and object machinery
- snapshot plumbing
- interrupt and boot plumbing
- board/platform infrastructure

What changed is the policy: inherited Froth machinery is allowed to stay as
internal substrate, but Froth's old public language priorities no longer define
the product.
