# FrothyDocs

Staging Hugo source for the public Froth documentation site.

## Build

```sh
./tools/smoke.sh
```

That script:

- rebuilds the site from scratch
- verifies the expected public routes exist
- checks that the search index includes core Froth terms

## Deploy

GitHub Pages deployment lives in `.github/workflows/deploy-pages.yml`.
The current staging custom domain is `frothy.frothlang.org`.
The target public cutover domain is `frothlang.org`, but that should not move
until `_internal/content-parity.md` is green or explicitly waived.

## Source Of Truth

The Frothy runtime repo remains canonical for semantics and accepted decisions.
This site is a public learning and reference layer over that material.

Use `_internal/source-map.md` to trace each site section back to the runtime
docs it depends on. Use `_internal/content-parity.md` to track the
`frothlang.org` cutover gate against the old Froth site shape.
