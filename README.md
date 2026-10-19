# Lens Code releases

Installers for **Lens Code** (formerly Deterministic Coder), the desktop app of the Lens coding agent: it edits the real files in your folder and you watch every change. You sign in with your Lens account; a free account gets a daily allowance of credits, and Lens Pro and Lens Max give you more. Website: https://lenscode.web.app. The \`lens\` terminal command has its own releases: https://github.com/teminali/lens-releases

Current version: **v0.3.0 (beta, unsigned)**.

### What's new in v0.3.0

- **DeepSeek Personal Protections & Consent Gate.** A consent dialog explicitly informs users that the bridge drives their web account via private browser automation, requires explicit agreement before opening login, and notes that Google sign-in is not supported (email/phone required).
- **Bridge Usage Governor & Request Pacing.** Strict single-concurrency mutex, minimum 1-second pacing between requests, 20/min burst rate limiting, and a hard 300 calls/day cap to protect accounts from being flagged.
- **Settings Usage Monitor & Reset.** Live counter displays today's DeepSeek calls (`X of 300 DeepSeek calls today`) with a manual Reset button.
- **Failure Discipline & 429/403 Cooldowns.** Authentication failures and login redirects immediately mark the session expired without retrying; rate limits (HTTP 429/403) trigger an automatic 5-minute cooldown.
- **Tightened File Permissions.** Credentials (`deepseek_session.json`) and usage logs are stored strictly with mode `0600` inside a `0700` app directory.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.3.0

## Release status

| Version | State | What was verified | What was not |
| --- | --- | --- | --- |
| v0.3.0 | Published, Latest | Installer checksums, CI launch checks on macOS, Windows and Linux, release gate validation, governor rate-limiting and pacing logic, consent gate and credential isolation checks. | A real mobile-money payment, the Windows and Linux installers on real computers, automated Google sign-in (use email/phone). |
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
