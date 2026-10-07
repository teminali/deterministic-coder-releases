# Deterministic Coder releases

Installers for Deterministic Coder, a local-first AI coding IDE with a bounded, approval-gated agent. This repository only hosts release binaries; the source is not published here.

Current version: **v0.0.4 (beta, unsigned)**. If you run v0.0.3, the update arrives through the version badge at the bottom right of the app (it downloads in the background and offers Restart to update); v0.0.2 and earlier cannot update themselves, so install v0.0.4 by hand once. See the release notes for what works and what does not.

### What's new in v0.0.4

- **Local models are checked and downloaded on first run.** Son (14B) and Grandson (7B) are not inside the installer. On first launch the app checks your computer (memory, free disk, graphics), recommends the 14B (or the 7B if the computer cannot run both) and downloads it through Ollama when you agree. If neither fits, the local models are marked unsupported and the app says why. Ollama itself is not installed for you: the app opens its download page.
- **The model picker always lists every option** (Local, Colab GPU, Cloud). A model that is not installed or set up is marked "needs setup" and opens the right setup when clicked; groups can be collapsed. Local and Colab rows carry a "free" badge, Cloud rows a "pro" badge.
- **Run a bigger model on your own Google Colab GPU (experimental).** A public notebook (see below) serves the model on a Colab GPU you choose and joins your own Tailscale network. It has **not yet been verified on a live Colab runtime**.
- **Overall usage.** The Usage card adds up what you used across Local, Colab GPU, your own server, your own OpenRouter key and Cloud, with the model time spent. It is informational, counted on your computer only, never sent to the dashboard, and has a Reset button.
- **Privacy fix.** With a custom server or Colab model selected, inline autocomplete used to send the text around your cursor to the hosted service for signed-in or keyed users. It now sends nothing in that case.
- **Updates:** a release whose file does not match its published checksum is no longer re-downloaded on every check, and the downloaded installer is removed after it is installed.

The memory and disk thresholds for 14B / 7B / unsupported are estimates, not yet measured on real devices of each kind. The builds are still unsigned, and macOS may ask for Keychain access once after an update. Full notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.0.4

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
