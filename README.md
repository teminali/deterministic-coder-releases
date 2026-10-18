# Lens Code releases

Installers for **Lens Code** (formerly Deterministic Coder), the desktop app of the Lens coding agent: it edits the real files in your folder and you watch every change. You sign in with your Lens account; a free account gets a daily allowance of credits, and Lens Pro and Lens Max give you more. Website: https://lenscode.web.app. The `lens` terminal command has its own releases: https://github.com/teminali/lens-releases

Current version: **v0.2.0 (beta, unsigned)**.

### What's new in v0.2.0

- **The app is Lens Code**, with a new logo.
- **One account, no local models.** The app reaches its models through the Lens platform: there are no local models and no keys of your own to add. The model picker lists only what Lens gives you.
- **Three packages**: Free, Lens Pro and Lens Max, with a usage card in the sidebar that shows the share of today's credits used and when they come back.
- **The Lens CLI looks after itself.** The app installs and updates it from a signed public feed and refuses a release that is not signed.
- **Known limits:** nothing in this release is marked covered by a unit test (every claim is listed under Not covered in the release notes); buying with mobile money was tested on the server side only, not with a real payment; the Windows and Linux installers are built and launch-checked by CI but were not run by us. The first update from Deterministic Coder 0.1.1 closes the app and does not reopen it: open Lens Code yourself, or run the installer below once (it also removes the old app).

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.2.0

## Release status

| Version | State | What was verified | What was not |
| --- | --- | --- | --- |
| v0.2.0 | Published, Latest | Installer checksums, the packaged app's UI check on macOS (10 of 10), CI launch checks on macOS, Windows and Linux, the live app scenarios on 2026-10-18 (see the notes). | A real mobile-money payment, the Windows and Linux installers on real computers, the relaunch after the first update from 0.1.1. |
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
