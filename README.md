# Deterministic Coder releases

Installers for Deterministic Coder, a desktop app where you describe an app in plain words, Lens (the hosted engine) designs it, and the app writes the whole project into your folder. This repository only hosts release binaries; the source is not published here.

Current version: **v0.0.7 (beta, unsigned)**. If you run v0.0.6, the update arrives through the version badge at the bottom right of the app (it downloads in the background and offers Restart to update); v0.0.2 and earlier cannot update themselves, so install by hand once. See the release notes for what works and what does not.

### What's new in v0.0.7

- **Sign in, no key to paste.** Lens works through your Deterministic Coder account: open the Account tab and continue with Google or GitHub. The Free plan starts at once (5 designs and 50 chat messages a day); Pro is a 30-day pass (30 designs and 300 chats a day). The limits are counted by Deterministic Coder, not by the Lens service.
- **Lens sees the whole app.** Every message carries a condensed map of the app: its spec (entities, types, links, choices), which files are generated, edited or missing, whether it is running and the last actions. Ask what is in the app or what you just did, also after files were deleted; "restore the missing files" rewrites only what is gone, from the spec.
- **Add sign up in one sentence.** The spec has an optional sign-up switch; Lens turns it on and the engine writes the route, the form and the tests.
- **A blank App view explains itself.** If the running page draws nothing, the App view says so and offers Reload and Open in browser.

The builds are still unsigned, and macOS may ask for Keychain access once after an update. What is covered and what is not: the release notes at https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.0.7

## Release status

| Version | State | What was verified | What was not |
| --- | --- | --- | --- |
| v0.0.7 | Published, Latest | See the release notes: every claim is either covered by a unit test and a live run, or listed under Not covered. | The installers on Windows and Linux were launch-checked by CI only; first-run install time for Run app and a real Pro payment were not exercised. |
| v0.0.6 | Superseded | See the release notes: every claim is either covered by a unit test and a live run, or listed under Not covered. | The installers on Windows and Linux were launch-checked by CI only; first-run install time for Run app, the plan limits on the hosted service and a real Pro payment were not exercised. |
| v0.0.5 | Superseded | First release with the release gate. | |

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
- A network connection and a Deterministic Coder account (free; sign in from the Account tab).
- To run a generated app with Run app: Python 3.9 or newer and Node.js with npm. Building and editing need neither.

## First launch (the builds are unsigned)

The builds are not signed with a paid Apple or Microsoft certificate yet, so a file downloaded in a browser gets a warning. A terminal command avoids it: it downloads the same file, checks it against `SHA256SUMS.txt` (and stops on a mismatch), and installs it.

- macOS / Linux: `curl -fsSL https://raw.githubusercontent.com/teminali/deterministic-coder-releases/main/install.sh | sh`
- Windows (PowerShell): `irm https://raw.githubusercontent.com/teminali/deterministic-coder-releases/main/install.ps1 | iex`

If you download the file instead:

- macOS: open System Settings > Privacy & Security and choose Open Anyway. If it is reported as damaged: `xattr -dr com.apple.quarantine "/Applications/Deterministic Coder.app"`.
- Windows: SmartScreen, More info, Run anyway.
- Linux: `chmod +x` the AppImage, or `sudo dpkg -i` the deb.

## Verify

Every release has `SHA256SUMS.txt`. Check your file against it before running.

## Support

Report problems: https://github.com/teminali/deterministic-coder-releases/issues
