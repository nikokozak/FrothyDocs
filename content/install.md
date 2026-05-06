---
title: "Install"
aliases:
  - /guide/00-installation/
description: "Install Froth with Homebrew, direct release archives, or the VS Code extension."
---

Froth currently ships as public prerelease tooling. The maintained CLI command
is:

```text
froth
```

## Homebrew

On macOS, use the Froth Homebrew tap:

```sh
brew install nikokozak/froth/froth
froth --version
froth doctor
```

## Direct Tarball

The current CLI release is `v0.1.0`. Download the archive for your platform:

```text
froth-v0.1.0-darwin-arm64.tar.gz
froth-v0.1.0-darwin-amd64.tar.gz
froth-v0.1.0-linux-amd64.tar.gz
```

Use `darwin-arm64` for Apple Silicon macOS, `darwin-amd64` for Intel macOS,
or `linux-amd64` for x86_64 Linux:

```sh
VERSION=0.1.0
PLATFORM=darwin-arm64
curl -LO https://github.com/nikokozak/froth/releases/download/v${VERSION}/froth-v${VERSION}-${PLATFORM}.tar.gz
tar -xzf froth-v${VERSION}-${PLATFORM}.tar.gz
mkdir -p ~/.local/bin
install -m 0755 froth ~/.local/bin/froth
froth --version
froth doctor
```

Use a directory already on `PATH`; on macOS, `/usr/local/bin` or
`/opt/homebrew/bin` may be more appropriate than `~/.local/bin`.

## VS Code

Install the public VS Code extension as `NikolaiKozak.froth` from the
Marketplace.

The `v0.1.0` Froth release also carries a fallback VSIX:

```text
froth-vscode-v0.1.1.vsix
```

Install it from a shell where the VS Code `code` command is available:

```sh
curl -LO https://github.com/nikokozak/froth/releases/download/v0.1.0/froth-vscode-v0.1.1.vsix
code --install-extension froth-vscode-v0.1.1.vsix
```

If VS Code cannot find the command on `PATH`, set `froth.cliPath` to the
absolute path of the installed `froth` binary.

## First Check

After installing the CLI, run:

```sh
froth doctor
```

For release files and checksums, use the
[Froth v0.1.0 release](https://github.com/nikokozak/froth/releases/tag/v0.1.0).
