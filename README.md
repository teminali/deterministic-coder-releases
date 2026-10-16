# Deterministic Coder releases

Installers for Deterministic Coder, a desktop app where you describe an app in plain words, Lens (the hosted engine) designs it, and the app writes the whole project into your folder. This repository only hosts release binaries; the source is not published here.

Current version: **v0.1.1 (beta, unsigned)**. If you run v0.1.0, the update arrives through the version badge at the bottom right of the app (it downloads in the background and offers Restart to update); v0.0.2 and earlier cannot update themselves, so install by hand once. See the release notes for what works and what does not.

### What's new in v0.1.1

- **Understand any folder.** Open a folder Lens did not build and the app maps it with evidence. `/map` shows the map, `/check readme` checks the README, `/gaps` tells what stops it and what to build next, and the chat answers from the map. The project spec map shows the folder's conventions, its level on the Deterministic Coder standard and what is met, missing or a choice. Only names leave the machine.
- **Edits survive regeneration.** After you edit a generated file, a change through Lens merges instead of overwriting, a conflict is shown with Resolve, and Undo puts the earlier state back.
- **An everyday chat that remembers.** The chat answers everyday questions in words and remembers the conversation, also after a restart; on the Local model the answer streams in as it is written.
- **Local model opt in.** The Local model card runs Lens on your own model through a sidecar on this computer, nothing leaves it.
- **The hosted Lens gained a style key and edits by small patch.**

The builds are still unsigned, and macOS may ask for Keychain access once after an update. What is covered and what is not: the release notes at https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.1.1

### What's new in v0.1.0

- **Small games and tools.** Through the hosted Lens, "make a snake game", "tic-tac-toe for two players" or "a counter with a save button" adds one page of rules to the app. "Make the snake faster" is a one-line change to the SPEC.
- **Publish.** Say "publish the app" or type `/publish`: after an approval window the app builds the web app and copies everything needed to run it into a `publish` folder of your project. Nothing is uploaded.
- **The plan names every part.** The plan card of a new app also names a game, pages, roles and sign up, not only the data.
- **Lens sees more.** The map Lens reads carries the page of rules of a game.

See the release notes at https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.1.0

## Release status

| Version | State | What was verified | What was not |
| --- | --- | --- | --- |
| v0.1.1 | Published, Latest | See the release notes: every claim is either covered by a unit test and a live run, or listed under Not covered. | The installers on Windows and Linux were launch-checked by CI only; first-run install time for Run app, running the tests and publishing on Windows, the Docker route of a published folder, a real Pro payment, running or changing a foreign project, and the exact accuracy of the spec map on foreign projects were not exercised. |
| v0.1.0 | Superseded | See the release notes: every claim is either covered by a unit test and a live run, or listed under Not covered. | The installers on Windows and Linux were launch-checked by CI only; first-run install time for Run app, running the tests and publishing on Windows, the Docker route of a published folder and a real Pro payment were not exercised. |
| v0.0.8 | Superseded | See the release notes: every claim is either covered by a unit test and a live run, or listed under Not covered. | The installers on Windows and Linux were launch-checked by CI only; first-run install time for Run app, running the tests on Windows and a real Pro payment were not exercised. |
| v0.0.7 | Superseded | See the release notes: every claim is either covered by a unit test and a live run, or listed under Not covered. | The installers on Windows and Linux were launch-checked by CI only; first-run install time for Run app and a real Pro payment were not exercised. |
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
