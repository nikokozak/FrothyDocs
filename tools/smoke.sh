#!/usr/bin/env bash
set -euo pipefail

export LC_ALL=C
export LANG=C

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

rm -rf public

hugo --gc --minify

INDEX_FILE="public/index.json"

for needle in \
  'save' \
  'dangerous.wipe' \
  'gpio.write' \
  'tm1629' \
  'matrix' \
  'OldFroth' \
  'game.run' \
  'froth doctor' \
  'froth_project_bindings'
do
  grep -q "$needle" "$INDEX_FILE"
done

for route in \
  public/index.html \
  public/install/index.html \
  public/guide/index.html \
  public/guide/01-what-is-froth/index.html \
  public/guide/10-where-to-go-next/index.html \
  public/tutorials/index.html \
  public/tutorials/blink-an-led/index.html \
  public/tutorials/interactive-workflow/index.html \
  public/tutorials/read-inputs/index.html \
  public/tutorials/build-a-small-game/index.html \
  public/reference/index.html \
  public/reference/words/index.html \
  public/reference/interactive-profile/index.html \
  public/reference/image-and-persistence/index.html \
  public/reference/cli/index.html \
  public/reference/editor/index.html \
  public/reference/project-and-build/index.html \
  public/reference/ffi/index.html \
  public/reference/ffi/how-it-works/index.html \
  public/reference/ffi/project-ffi/index.html \
  public/reference/ffi/project-ffi-example/index.html \
  public/reference/ffi/board-ffi-example/index.html \
  public/reference/hardware/index.html \
  public/reference/hardware/base-image/index.html \
  public/reference/hardware/words/index.html \
  public/reference/hardware/display/index.html \
  public/reference/hardware/input/index.html \
  public/reference/hardware/utilities/index.html \
  public/workshop/index.html \
  public/workshop/broken-beacon/index.html \
  public/workshop/quick-reference/index.html \
  public/what-makes-froth-different/index.html \
  public/oldfroth/index.html
do
  test -f "$route"
done

if rg -n 'Frothy|FROTHY|\bfrothy\b' public \
  --glob '*.html' \
  --glob '*.json' \
  --glob '!public/guide/00-installation/index.html' \
  --glob '!public/reference/hardware/matrix/index.html' \
  --glob '!public/reference/hardware/tm1629/index.html'
then
  echo "error: stale public Frothy identity found in generated pages" >&2
  exit 1
fi
