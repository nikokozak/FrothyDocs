---
title: "Install"
aliases:
  - /guide/00-installation/
description: "Current Froth availability, release gates, and the command shape public releases will use."
---

Froth is not publicly installable yet. The commands below are the release
shape that will go live after the artifacts and the main-site cutover are
validated.

The installed command is:

```sh
froth
```

## Homebrew

On macOS, the preferred install path will be:

```sh
brew install nikokozak/froth/froth
froth --version
froth doctor
```

## Direct Tarball

Each release will publish CLI archives named:

```text
froth-v<version>-darwin-arm64.tar.gz
froth-v<version>-darwin-amd64.tar.gz
froth-v<version>-linux-amd64.tar.gz
```

Direct install will be:

```sh
curl -LO https://github.com/nikokozak/froth/releases/download/v<version>/froth-v<version>-<os>-<arch>.tar.gz
tar -xzf froth-v<version>-<os>-<arch>.tar.gz
install -m 0755 froth ~/.local/bin/froth
froth --version
froth doctor
```

Use a directory already on `PATH`; on macOS, `/usr/local/bin` or
`/opt/homebrew/bin` may be more appropriate than `~/.local/bin`.

## VS Code

The editor package will publish as `NikolaiKozak.froth`, with a matching
fallback VSIX named:

```text
froth-vscode-v<extension-version>.vsix
```

If VS Code cannot find the command on `PATH`, set `froth.cliPath` to the
absolute path of the installed `froth` binary.

## First Check

After any install path, run:

```sh
froth doctor
```

Until then, Froth is available only to pre-alpha testers and local checkout
maintainers. The staging docs are deliberately not a promise that the public
installer is ready.

If you are interested in testing Froth, contact Nikolai at
`nkozak [at] nyu [dot] edu`.
