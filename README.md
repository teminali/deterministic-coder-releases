# Deterministic Coder releases

Installers for Deterministic Coder, a desktop app where you describe an app in plain words, Lens (the hosted engine) designs it, and the app writes the whole project into your folder. This repository only hosts release binaries; the source is not published here.

Current version: **v0.0.6 (beta, unsigned)**. If you run v0.0.5, the update arrives through the version badge at the bottom right of the app (it downloads in the background and offers Restart to update); v0.0.2 and earlier cannot update themselves, so install by hand once. See the release notes for what works and what does not.

### What's new in v0.0.6

- **Lens is the only engine.** The model picker and everything behind it from earlier versions is gone: local models, the Colab GPU option, your own server and your own provider key.
- **Add your Lens key in the Account tab.** Create a key at https://rabbitai.web.app/ (sign in there) and paste it in the app. The app checks it with Lens and keeps it encrypted by your system; it is never shown again. Lens does not work until you add one.
- **Run what Lens built.** For a Lens-built project the Run button starts the backend and the web app on this computer after an approval window; the App view shows the running app, the API view lists the backend's endpoints and sends requests, and Stop ends everything. It needs Python 3.9 or newer and Node.js with npm.
- **Delete from the chat.** "delete old.js", "delete the backend folder", "delete *.md" or "delete all files" is done by the app itself. Broad deletes ask first, go to the recycle bin and Undo brings them back.
- **Usage card.** The Account tab shows your plan, the builds you have left today and the chat messages you have left, read from Lens.

The builds are still unsigned, and macOS may ask for Keychain access once after an update. What is covered and what is not: the release notes at https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.0.6

## Release status

| Version | State | What was verified | What was not |
| --- | --- | --- | --- |
| v0.0.6 | Published, Latest | See the release notes: every claim is either covered by a unit test and a live run, or listed under Not covered. | The installers on Windows and Linux were launch-checked by CI only; first-run install time for Run app, the plan limits on the hosted service and a real Pro payment were not exercised. |
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
- A network connection and a Lens key (create one at https://rabbitai.web.app/).
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
