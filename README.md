# FrothyDocs

Public Hugo site for Frothy documentation.

## Build

```sh
./tools/smoke.sh
```

That script:

- rebuilds the site from scratch
- verifies the expected public routes exist
- checks that the search index includes core Frothy terms

## Deploy

GitHub Pages deployment lives in `.github/workflows/deploy-pages.yml`.
The published custom domain is `frothy.frothlang.org`.

## Source Of Truth

The Frothy repo remains canonical for semantics and accepted decisions. This
site is a public learning and reference layer over that material.

Use `_internal/source-map.md` to trace each site section back to the Frothy
docs it depends on.
