#!/usr/bin/env bash
set -euo pipefail

export LC_ALL=C
export LANG=C

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

rm -rf public

hugo --gc --minify

INDEX_FILE="public/index.json"

for needle in 'save' 'dangerous.wipe' 'gpio.write' 'tm1629' 'matrix'; do
  grep -q "$needle" "$INDEX_FILE"
done

for route in \
  public/index.html \
  public/install/index.html \
  public/guide/index.html \
  public/guide/01-what-is-frothy/index.html \
  public/guide/10-where-to-go-next/index.html \
  public/reference/index.html \
  public/reference/words/index.html \
  public/reference/interactive-profile/index.html \
  public/reference/image-and-persistence/index.html \
  public/reference/cli/index.html \
  public/reference/ffi/index.html \
  public/reference/hardware/index.html \
  public/reference/hardware/base-image/index.html \
  public/reference/hardware/words/index.html \
  public/reference/hardware/display/index.html \
  public/reference/hardware/input/index.html \
  public/reference/hardware/utilities/index.html \
  public/workshop/index.html \
  public/workshop/broken-beacon/index.html \
  public/workshop/quick-reference/index.html \
  public/what-makes-frothy-different/index.html
do
  test -f "$route"
done
