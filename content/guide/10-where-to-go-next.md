---
title: "10. Where to Go Next"
description: "Move from the guide into the reference, the board surface, and the authoritative Frothy docs."
weight: 10
---

After the guide, the next stop depends on what you are trying to do.

## If You Are Writing Frothy

- [Word reference](/reference/words/) for syntax, operators, locals, `Cells`,
  records, and the core inspection/persistence words
- [Interactive profile](/reference/interactive-profile/) for REPL behavior,
  multiline input, interrupts, and inspection
- [Image and persistence](/reference/image-and-persistence/) for `save`,
  `restore`, `dangerous.wipe`, and `boot`

## If You Are Building For Hardware

- [CLI reference](/reference/cli/) for the maintained command surface
- [Hardware overview](/reference/hardware/) for the layered board story
- [Base-image board reference](/reference/hardware/base-image/) for
  `millis`, `gpio.*`, `led.*`, and `adc.percent`
- [TM1629 reference](/reference/hardware/tm1629/) and
  [matrix reference](/reference/hardware/matrix/) for the protoboard display
  surface

## If You Are Extending Frothy

- [FFI reference](/reference/ffi/) for the accepted boundary and the project
  versus board split

## If You Need The Authority Docs

The Frothy repo remains canonical for semantics and accepted decisions. The
main public sources are:

- `docs/spec/Frothy_Language_Spec_v0_1.md`
- Frothy ADRs in `docs/adr/100-*.md`
- `docs/roadmap/Frothy_Development_Roadmap_v0_1.md`

This site is the public learning and reference layer over that material, not a
second competing source of truth.
