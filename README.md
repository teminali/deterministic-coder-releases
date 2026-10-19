# Lens Code releases

Installers for **Lens Code** (formerly Deterministic Coder), the desktop app of the Lens coding agent: it edits the real files in your folder and you watch every change. You sign in with your Lens account; a free account gets a daily allowance of credits, and Lens Pro and Lens Max give you more. Website: https://lenscode.web.app. The `lens` terminal command has its own releases: https://github.com/teminali/lens-releases

Current version: **v0.2.2 (beta, unsigned)**.

### What's new in v0.2.2

- **Multi-Model Catalog & Live Reasoning.** 6 models available in the model selector across Google, Anthropic, and DeepSeek. Streaming reasoning blocks render live with timers (`Thought for Xs`).
- **DeepSeek Account Linking.** Settings includes a Models section where you can link your DeepSeek account for free model access, badged as personal.
- **Workspace Performance.** File scanning is capped and skips worktrees, preventing UI freezes on large repositories.
- **Folder Trust Prompts.** Opening a project folder that contains custom Lens settings prompts you to review and trust it.
- **Bundled Lens CLI 0.1.20.** Includes the latest Lens CLI release.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.2.2

## Release status

| Version | State | What was verified | What was not |
| --- | --- | --- | --- |
| v0.2.2 | Published, Latest | Installer checksums, CI launch checks on macOS, Windows and Linux, 25 multi-provider gateway tests, and live website reasoning verification. | A real mobile-money payment, the Windows and Linux installers on real computers. |
| v0.2.1 | Superseded | Installer checksums, the packaged app's UI check on macOS (10 of 10), CI launch checks on macOS, Windows and Linux, 14 live app scenarios on 2026-10-19 (see the notes). | A real mobile-money payment, the Windows and Linux installers on real computers. |
| v0.2.0 | Superseded | Installer checksums, the packaged app's UI check on macOS (10 of 10), CI launch checks, the live app scenarios on 2026-10-18. | A real mobile-money payment, the Windows and Linux installers on real computers. |
| v0.1.1 and earlier | Superseded (Deterministic Coder) | See each release's notes. | |

## Download

Stable links that always point to the latest release:

| Platform | File | Link |
| --- | --- | --- |
| macOS, Apple Silicon (dmg) | `Lens-Code-mac-arm64.dmg` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Lens-Code-mac-arm64.dmg |
| macOS, Apple Silicon (zip) | `Lens-Code-mac-arm64.zip` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Lens-Code-mac-arm64.zip |
| macOS, Intel (dmg) | `Lens-Code-mac-x64.dmg` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Lens-Code-mac-x64.dmg |
| macOS, Intel (zip) | `Lens-Code-mac-x64.zip` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Lens-Code-mac-x64.zip |
| Windows 10/11, x64 | `Lens-Code-win-x64.exe` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Lens-Code-win-x64.exe |
| Linux x64, AppImage | `Lens-Code-linux-x64.AppImage` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Lens-Code-linux-x64.AppImage |
| Linux x64, Debian/Ubuntu | `Lens-Code-linux-x64.deb` | https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Lens-Code-linux-x64.deb |

File names never contain a version number. A platform whose build did not pass the launch check may be missing from a given release.

## Requirements

- macOS 11 or later, Windows 10 or later, or a recent 64-bit Linux desktop (GTK 3).
- A network connection and a Lens account (free; sign in from the Account tab).
- To run a generated app with Run app: Python 3.9 or newer and Node.js with npm. Building and editing need neither.

## First launch (the builds are unsigned)

The builds are not signed with a paid Apple or Microsoft certificate yet, so a file downloaded in a browser gets a warning. A terminal command avoids it: it downloads the same file, checks it against `SHA256SUMS.txt` (and stops on a mismatch), installs it, and replaces an old Deterministic Coder app if there is one.

- macOS / Linux: `curl -fsSL https://raw.githubusercontent.com/teminali/deterministic-coder-releases/main/install.sh | sh`
- Windows (PowerShell): `irm https://raw.githubusercontent.com/teminali/deterministic-coder-releases/main/install.ps1 | iex`

If you download the file instead:

- macOS: open System Settings > Privacy & Security and choose Open Anyway. If it is reported as damaged: `xattr -dr com.apple.quarantine "/Applications/Lens Code.app"`.
- Windows: SmartScreen, More info, Run anyway.
- Linux: `chmod +x` the AppImage, or `sudo dpkg -i` the deb.

## Verify

Every release has `SHA256SUMS.txt`. Check your file against it before running.

## Support

Report problems: https://github.com/teminali/deterministic-coder-releases/issues
