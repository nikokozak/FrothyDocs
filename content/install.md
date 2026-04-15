---
title: "Install"
description: "Install the maintained Frothy attendee path and verify the first board connection."
---

Frothy's public install story is intentionally narrower than the full repo
surface. The maintained attendee path is:

- released `froth` CLI assets
- matching `frothy-vscode-v<extension-version>.vsix`
- a preflashed `esp32-devkit-v1`

You do not need a repo checkout, `esp-idf`, or a source build before arriving
on that path.

## Naming Split

The product, docs, release assets, and editor surface are `Frothy`, but the
installed CLI command is still `froth`.

That means the commands below are correct even though the project name is
Frothy:

```sh
froth doctor
froth connect
froth build
froth flash
```

## Support Matrix

| Surface | Supported path |
| --- | --- |
| CLI | macOS via Homebrew; Linux x86_64 via release tarball |
| VS Code | matching `frothy-vscode-v<extension-version>.vsix` on a machine that can already run `froth` |
| Hardware | preflashed `esp32-devkit-v1` |

Not promised in this first public cut:

- Windows
- extra boards
- source builds or repo-local workshop recovery workflows
- pre-class `esp-idf` installs

## Install The CLI

macOS:

```sh
brew tap nikokozak/frothy
brew install frothy
froth doctor
```

Linux x86_64:

```sh
tar -xzf frothy-v<version>-linux-amd64.tar.gz
mkdir -p "$HOME/.local/bin"
install -m 0755 froth "$HOME/.local/bin/froth"
froth doctor
```

If multiple serial devices are visible, rerun the check with an explicit port:

```sh
froth --port <path> doctor
```

## Install The VS Code Extension

```sh
code --install-extension /path/to/frothy-vscode-v<extension-version>.vsix
```

If VS Code cannot find the CLI on `PATH`, set `frothy.cliPath` to the absolute
path of the installed `froth` binary.

## First Connect

1. Plug in the preflashed `esp32-devkit-v1`.
2. Run `froth doctor`.
3. Open a `.froth` or `.frothy` file in VS Code.
4. Run `Frothy: Connect Device`.
5. Send `1 + 1` with `Frothy: Send Selection / Line`.
6. If the extension path is blocked, fall back to `froth --port <path> connect`.

Once you have a prompt, check the maintained workshop base image:

```frothy
words
info @millis
info @blink
info @adc.percent
```

## Preflight

Before class or a workshop rehearsal, confirm:

- `froth doctor` completes without CLI-path or serial surprises
- the VSIX installs successfully
- your laptop can see the board over USB

If that path fails, stop there. Do not widen the tooling surface ad hoc by
installing extra toolchains.

## Maintainer Notes

The promised clean-machine surface is frozen by the checked-in validation path
in `docs/guide/Frothy_Workshop_Clean_Machine_Validation.md` in the Frothy repo.
That is the authority for what can honestly be promised on attendee machines.
