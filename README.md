# Deterministic Coder releases

Installers for Deterministic Coder, a local-first AI coding IDE with a bounded, approval-gated agent. This repository only hosts release binaries; the source is not published here.

Current version: **v0.0.3 (beta, unsigned)**. v0.0.3 adds automatic updates (a version badge at the bottom right of the app); v0.0.2 and earlier cannot update themselves, so install v0.0.3 by hand once. See the release notes for what works and what does not.

## Download

Stable links that always point to the latest release:

| Platform | File | Link |
| --- | --- | --- |
| macOS, Apple Silicon (dmg) | `Deterministic-Coder-mac-arm64.dmg` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Deterministic-Coder-mac-arm64.dmg |
| macOS, Apple Silicon (zip) | `Deterministic-Coder-mac-arm64.zip` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Deterministic-Coder-mac-arm64.zip |
| macOS, Intel (dmg) | `Deterministic-Coder-mac-x64.dmg` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Deterministic-Coder-mac-x64.dmg |
| macOS, Intel (zip) | `Deterministic-Coder-mac-x64.zip` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Deterministic-Coder-mac-x64.zip |
| Windows 10/11, x64 | `Deterministic-Coder-win-x64.exe` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Deterministic-Coder-win-x64.exe |
| Linux x64, AppImage | `Deterministic-Coder-linux-x64.AppImage` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Deterministic-Coder-linux-x64.AppImage |
| Linux x64, Debian/Ubuntu | `Deterministic-Coder-linux-x64.deb` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Deterministic-Coder-linux-x64.deb |

Pattern: `https://github.com/teminali/deterministic-coder-releases/releases/latest/download/<file name>`. File names never contain a version number. A platform whose build did not pass the launch check may be missing from a given release.

## Requirements

- macOS 11 or later, Windows 10 or later, or a recent 64-bit Linux desktop (GTK 3).
- For local models: [Ollama](https://ollama.com) installed and running. Hosted models need a sign-in and a plan.

## First launch (the builds are unsigned)

- macOS: right-click the app, choose Open. If it is reported as damaged: `xattr -dr com.apple.quarantine "/Applications/Deterministic Coder.app"`.
- Windows: SmartScreen, More info, Run anyway.
- Linux: `chmod +x` the AppImage, or `sudo dpkg -i` the deb.

## Run a bigger model on your own Google Colab (experimental)

[Open the notebook in Colab](https://colab.research.google.com/github/teminali/deterministic-coder-releases/blob/main/colab/deterministic_coder_server.ipynb). It serves a model on a Colab GPU you choose and joins your own Tailscale network, and Deterministic Coder connects to it from Settings. It has **not yet been verified on a live Colab runtime**. Details, limits and the terms note: [colab/README.md](colab/README.md).

## Verify

Every release has `SHA256SUMS.txt`. Check your file against it before running.

## Support

Report problems: https://github.com/teminali/deterministic-coder-releases/issues
