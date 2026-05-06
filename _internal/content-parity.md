# Froth Public Site Cutover And Content Parity

Status: active release-control ledger
Date: 2026-05-06
Authority:
Frothy ADR-128,
`docs/spec/Frothy_Language_Spec_v0_1.md`,
Frothy ADR-100,
Frothy ADR-120,
Frothy ADR-122,
Frothy ADR-124,
and the roadmap current-state block

## Purpose

This ledger keeps the public rename and website cutover out of a quagmire.

The goal is not a repo-wide internal rename. The goal is to launch the new
language as **Froth**, rename the original product to **OldFroth**, and move the
new site to `frothlang.org` only after it matches the old site in content
coverage, navigational shape, and presentation quality.

## Source Repos

- New public site basis: `/Users/niko/Developer/FrothyDocs`
- Old site and parity reference: `/Users/niko/Developer/FrothDocs`
- Current runtime/control source: `/Users/niko/Developer/Frothy`
- Original product source to archive as OldFroth: `/Users/niko/Developer/Froth`

## Cutover Rules

- Do not move DNS or GitHub Pages custom-domain ownership until the parity
  ledger is green or explicitly waived.
- Do not keep two living public sites for the same current product.
- Preserve old-site shape first: home, install, guide, tutorials, reference,
  and how-it-is-different.
- Add `machine` and `workshop` as new Froth strengths, but do not count them as
  substitutes for missing tutorials or reference pages.
- Keep `Frothy` out of public user-facing surfaces unless the page is historical
  or explicitly describing internal implementation history.
- Use `OldFroth` for the original language and old site after the rename.
- Keep internal `frothy_*` source names, CMake labels, script paths, and
  historical ADR filenames out of scope unless they leak into user-facing docs,
  CLI output, package metadata, or release assets.

## Definition Of Done

- [x] New identity ADR accepted and referenced from the live queue.
- [ ] New site title, nav, footer, metadata, CNAME, and base URL say `Froth`.
- [x] New site source has a content-parity page or ledger checked in beside the
  site source.
- [x] Every old public route maps to a new Froth route, an OldFroth archive
  route, or an explicit cutover exception.
- [x] New site has at least the old site's top-level shape:
  `/`, `/install/`, `/guide/`, `/tutorials/`, `/reference/`,
  `/what-makes-froth-different/`.
- [x] New site includes the new additive sections:
  `/machine/` and `/workshop/`.
- [x] Tutorials exist as first-class pages, not only workshop material.
- [x] Reference depth covers CLI, editor, project/build, interactive profile,
  image/persistence, FFI, words, and hardware.
- [ ] Public examples use current Froth syntax and current maintained commands.
- [~] Public install content is honest about availability; the complete
  install path still waits on release artifacts.
- [x] Site search indexes the guide, tutorials, machine, workshop, and reference
  surfaces.
- [x] Smoke checks fail on missing routes, broken internal links, placeholder
  pages, stale public `Frothy` branding, and stale current-product `frothy`
  commands.
- [~] Old Froth site and repo are archived under `OldFroth`; the new site now
  has an `/oldfroth/` marker route, but the old site and repo still need the
  actual archive move.
- [ ] Final cutover is validated locally with the site smoke script and by
  fetching the published Pages URL after deployment.

## Proposed Public Shape

```text
/
/install/
/guide/
  /guide/00-installation/
  /guide/01-what-is-froth/
  /guide/02-getting-started/
  /guide/03-values-and-names/
  /guide/04-definitions/
  /guide/05-code-locals-and-blocks/
  /guide/06-control-flow/
  /guide/07-errors-and-recovery/
  /guide/08-text-and-io/
  /guide/09-hardware/
  /guide/10-persistence/
  /guide/11-where-to-go-next/
/tutorials/
  /tutorials/blink-an-led/
  /tutorials/interactive-workflow/
  /tutorials/read-inputs/
  /tutorials/build-a-small-game/
/machine/
/workshop/
/reference/
  /reference/words/
  /reference/cli/
  /reference/editor/
  /reference/project-and-build/
  /reference/interactive-profile/
  /reference/image-and-persistence/
  /reference/ffi/
  /reference/hardware/
/what-makes-froth-different/
/oldfroth/ or https://oldfroth.frothlang.org/
```

## Parity Ledger

Status keys:

- `[x]` covered enough for cutover
- `[~]` exists, but needs rename, depth, route, or polish before cutover
- `[ ]` missing or too thin
- `[-]` should move to OldFroth archive or be replaced by current Froth concept

| Old Froth route | New Froth route | Status | Required action |
| --- | --- | --- | --- |
| `/` | `/` | `[~]` | Rename Frothy to Froth, add a strong first-viewport product signal, add visual assets, and make the first code example current. |
| `/install/` | `/install/` | `[~]` | Replace pre-alpha-only copy with the real launch availability path when release opens; ensure commands say `froth`. |
| `/guide/` | `/guide/` | `[x]` | Chaptered guide shape restored with current Froth semantics. |
| `/guide/00-installation/` | `/install/` alias | `[x]` | Install remains canonical; the old guide chapter route resolves to it. |
| `/guide/01-what-is-froth/` | `/guide/01-what-is-froth/` | `[x]` | Current live-image/lexical framing exists. |
| `/guide/02-getting-started/` | `/guide/02-getting-started/` | `[x]` | Hardware-first first-session page added. |
| `/guide/03-the-stack/` | `/guide/03-the-stack/` | `[x]` | Current analogue explains values/expressions and explicitly bridges away from the OldFroth stack model. |
| `/guide/04-words-and-definitions/` | `/guide/04-words-and-definitions/` | `[x]` | Current Code/definition chapter added. |
| `/guide/05-perm-and-named/` | `/guide/05-perm-and-named/` | `[x]` | Current analogue covers locals, names, mutation, and Cells while marking `perm` as OldFroth-specific. |
| `/guide/06-quotations-and-control/` | `/guide/06-quotations-and-control/` | `[x]` | Current blocks/control-flow chapter added. |
| `/guide/07-error-handling/` | `/guide/07-error-handling/` | `[x]` | Runtime error, interrupt, inspection, safe boot, restore, and wipe guidance added. |
| `/guide/08-strings-and-io/` | `/guide/08-strings-and-io/` | `[x]` | Current Text and board-I/O split documented. |
| `/guide/09-talking-to-hardware/` | `/guide/09-talking-to-hardware/` | `[x]` | Hardware guide route restored and split clearly from Machine. |
| `/guide/10-snapshots-and-persistence/` | `/guide/10-snapshots-and-persistence/` | `[x]` | Narrative persistence chapter added. |
| `/guide/11-where-to-go-next/` | `/guide/11-where-to-go-next/` | `[x]` | Route aligned. |
| `/guide/12-ffi-and-c/` | `/guide/12-ffi-and-c/`, `/reference/ffi/` | `[x]` | Current FFI guide route added and kept advanced. |
| `/tutorials/` | `/tutorials/` | `[x]` | Top-level tutorials section exists in the new site nav and smoke checks. |
| `/tutorials/blink-an-led/` | `/tutorials/blink-an-led/` | `[x]` | Rewritten around current `froth` CLI, `to ... with ...`, `LED_BUILTIN`, save, and wipe. |
| `/tutorials/interactive-workflow/` | `/tutorials/interactive-workflow/` | `[x]` | Rewritten around current CLI/editor control session, live image inspection, interrupt, and save workflow. |
| `/tutorials/read-a-sensor/` | `/tutorials/read-inputs/` | `[x]` | Rewritten for joystick and knob helpers on the Froth Machine. |
| `/tutorials/read-a-button/` | `/tutorials/read-inputs/` | `[x]` | Folded into the current input tutorial and Machine controls path. |
| `/tutorials/fade-an-led/` | `/tutorials/fade-an-led/` | `[x]` | Current LEDC/PWM analogue added and marked board-specific/advanced. |
| `/tutorials/drive-a-servo/` | `/tutorials/drive-a-servo/` | `[x]` | Current LEDC servo analogue added and marked board-specific/advanced. |
| `/tutorials/build-a-calculator/` | `/tutorials/build-a-calculator/` | `[x]` | Rewritten as a current lexical/stateful calculator rather than a stack-language calculator. |
| `/tutorials/advent-of-code-grid-scan/` | `/tutorials/advent-of-code-grid-scan/` | `[x]` | Current Cells-based grid-scan tutorial added. |
| `/tutorials/advent-of-code-safe-dial/` | `/tutorials/advent-of-code-safe-dial/` | `[x]` | Current Cells/named-state safe-dial tutorial added. |
| `/reference/` | `/reference/` | `[~]` | New reference index exists, but needs old-shape route coverage. |
| `/reference/words/` | `/reference/words/` | `[~]` | Current words reference exists; verify complete against maintained base image. |
| `/reference/cli/` | `/reference/cli/` | `[~]` | Update command name to `froth` and include release/install/project distinctions. |
| `/reference/vscode/` | `/reference/editor/` | `[x]` | Public editor reference now covers visible commands, settings, and recovery flow. |
| `/reference/build-options/` | `/reference/project-and-build/` alias | `[x]` | Target/board/project build reference now includes build option material and old route alias. |
| `/reference/profiles/` | `/reference/interactive-profile/` alias | `[x]` | Current profile/capability page exists with old route alias. |
| `/reference/snapshot-format/` | `/reference/image-and-persistence/` alias | `[x]` | Public snapshot model documented; binary format kept out of the stable public contract. |
| `/reference/ffi/` | `/reference/ffi/` | `[x]` | Structured FFI section now exists and uses public `froth_*` / `FROTH_*` C aliases. |
| `/reference/ffi/project-ffi/` | `/reference/ffi/project-ffi/` | `[x]` | Project FFI route now documents manifest, validation, build path, and ownership rules. |
| `/reference/ffi/project-ffi-example/` | `/reference/ffi/project-ffi-example/` | `[x]` | Current example now uses `froth_ffi.h`, `froth_project_bindings`, and current Froth call syntax. |
| `/reference/ffi/board-ffi-example/` | `/reference/ffi/board-ffi-example/` | `[x]` | Current maintained-board example route now exists. |
| `/reference/ffi/how-it-works/` | `/reference/ffi/how-it-works/` | `[x]` | Runtime model and public C surface route now exists. |
| `/reference/hardware/` | `/reference/hardware/` | `[~]` | New hardware reference exists and is Machine-oriented; add generic maintained-board map. |
| `/reference/hardware/gpio/` | `/reference/hardware/gpio/` | `[x]` | Dedicated current GPIO route added. |
| `/reference/hardware/timing/` | `/reference/hardware/timing/` | `[x]` | Dedicated current timing route added. |
| `/reference/hardware/i2c/` | `/reference/hardware/i2c/` | `[x]` | Current source-board I2C route added and marked outside beginner Machine path. |
| `/reference/hardware/uart/` | `/reference/hardware/uart/` | `[x]` | Current source-board UART route added and marked outside beginner Machine path. |
| `/what-makes-froth-different/` | `/what-makes-froth-different/` | `[x]` | Renamed from Frothy and framed against OldFroth. |
| Search index | Search index | `[x]` | Smoke checks now cover tutorials, core terms, and stale generated public identity. |
| Visual assets | Visual assets | `[x]` | Homepage now has a checked-in `home-hero.png` asset. |
| Old product archive | `/oldfroth/` or `oldfroth.frothlang.org` | `[~]` | New site has `/oldfroth/` marker route; old site/repo still need archive move, banner, and redirect policy. |

## Immediate Work Order

1. Land Frothy ADR-128 and this ledger in the runtime/control repo.
2. In `FrothyDocs`, add a matching `_internal/content-parity.md` copied from
   this ledger or generated from it.
3. Rename visible site identity from Frothy to Froth while leaving internal
   file names alone.
4. Restore old-site top-level shape by adding `/tutorials/` and missing
   reference/editor/project pages.
5. Add visual assets and verify the site no longer looks thinner than the old
   Froth site.
6. Build public identity smoke checks:
   route existence, internal link check, search-index terms, placeholder ban,
   and stale public `Frothy`/`frothy` command scan.
7. Only after those checks pass, move Pages/DNS and archive OldFroth.

## Focused Proofs

For this control-ledger step:

```sh
rg -n "Frothy ADR-128|Froth_Public_Site_Cutover" docs/adr docs/roadmap README.md PROGRESS.md TIMELINE.md
sh tools/frothy/proof_control_surface_docs.sh
```

For the later website step in `/Users/niko/Developer/FrothyDocs`:

```sh
./tools/smoke.sh
rg -n "\bFrothy\b|\bfrothy\b" content layouts static hugo.toml README.md
```

The second grep will need an allowlist for internal script filenames and
historical archive pages. It should fail closed for public current-product
copy.
