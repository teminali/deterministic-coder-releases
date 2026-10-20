# Lens Code releases

Installers for **Lens Code** (formerly Deterministic Coder), the desktop app of the Lens coding agent: it edits the real files in your folder and you watch every change. You sign in with your Lens account; a free account gets a daily allowance of credits, and Lens Plus, Lens Pro and Lens Max give you more. Website: https://lenscode.web.app. The `lens` terminal command has its own releases: https://github.com/teminali/lens-releases

Current version: **v0.3.4 (beta, unsigned)**.

### What's new in v0.3.4

- **Chat that shows its work.** The pill above the chat box reads "Step n / m" and opens the task list; the status bar shows the tokens sent and written and how full the model's context is. Commands you allow fold into one "Allowed N commands" row, and New chat really starts a new conversation.
- **Appearance, search and Work mode.** Theme (System, Dark, Light) and Accent (White, Green) in Settings > General; one table of shortcuts and a search over files, lines, commands, settings, chats and models; documents, sheets and research briefs from the blank editor.
- **A personal DeepSeek account in two modes.** V4.1 Flash (plain chat, the default) and V4.1 Flash (DeepThink). Lens no longer ends your DeepSeek login by a rule of its own after 5 hours; it stays until DeepSeek refuses it. DeepSeek's own "Messages too frequent" limit is shown in its words and Lens pauses it for 5 minutes. A run DeepSeek cuts short reads "Task ended early because: ...". Calls are paced (one at a time, 20 a minute) with a daily cap of 200 on Free and 300 on Lens Plus, Lens Pro and Lens Max.
- **Four packages.** Free, Lens Plus ($7), Lens Pro ($16) and Lens Max ($49), 30-day passes paid by mobile money; the app and the Lens CLI show the exact package.
- **Smoother long thoughts and plain errors.** A long thought no longer freezes the window; a failed turn shows the provider's message without its wrapper.
- **Lens 0.1.21 or later.** Lens Code installs the newer Lens it needs by itself.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.3.4

## Release status

| Version | State | What was verified | What was not |
| --- | --- | --- | --- |
| v0.3.4 | Published, Latest | What the release notes list under Covered (live runs of the real app, the DeepSeek unit tests, the release gate). | A real mobile-money payment, the Windows and Linux installers on real computers. |
| v0.3.1 to v0.3.3 | Superseded | See each release's notes. | |
| v0.3.0 | Superseded | Unit tests for DeepSeek tool relay, DSML/tool_call parser, markerHold, usage governor, permissions, pacing, cooldowns, and full suite tests. | A real mobile-money payment, the Windows and Linux installers on real computers. |
| v0.2.2 | Superseded | Installer checksums, CI launch checks on macOS, Windows and Linux, 25 multi-provider gateway tests, and live website reasoning verification. | A real mobile-money payment, the Windows and Linux installers on real computers. |
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

- macOS 12 or later, Windows 10 or later, or a recent 64-bit Linux desktop (GTK 3).
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
