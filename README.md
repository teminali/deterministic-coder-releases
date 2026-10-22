# Lens Code releases

Installers for **Lens Code** (formerly Deterministic Coder), the desktop app of the Lens coding agent: it edits the real files in your folder and you watch every change. You sign in with your Lens account; a free account gets a daily allowance of credits, and Lens Plus, Lens Pro and Lens Max give you more. Website: https://lenscode.web.app. The `lens` terminal command has its own releases: https://github.com/teminali/lens-releases

Current version: **v0.4.4 (beta, unsigned)**.

### What's new in v0.4.4

**The DeepSeek change in this version was tested against a scripted copy of chat.deepseek.com, not the real DeepSeek.** One real run of 0.4.3 on a real account built a landing page in 4 minutes 15 seconds with no cut-off and no refusal; it is where the problem fixed here was found. This fix has not been run on a real account.

- **DeepSeek thinks once per task.** The plan from the thinking mode is kept and shown to every later step (0.4.3 forgot it at the next step and asked again); at most two thoughts for a task, and then the model is no longer offered the request.
- **Full screen stays in the window.** The Preview and the running app fill the whole app below the title bar, over the sidebar and the chat, and never switch the computer to its own full screen. Esc or the button leaves.
- **One size button** (Desktop, Tablet, Mobile) instead of three, with new drawn icons.
- **The running app has the Preview's controls** and an **address bar**: it shows where the page is and follows its links, takes a path (/about), refuses another site with a sentence, and Reload stays on the page you are on. The editor's file row is gone above it.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.4

### What was new in v0.4.3

**Your own DeepSeek account was not tested on this version.** The lane was rebuilt (one model, a new way to ask DeepSeek to think); it was run against a scripted copy of chat.deepseek.com on the same computer, not the real DeepSeek, whose account we test with was muted after repeated test runs, until 24 October. If you use it and something looks wrong, tell us what you saw.

- **One DeepSeek model: V4.1 Flash.** The ordinary chat answers every step, so a file is written in seconds; when a task is hard (building from nothing, a plan over several files, an error that comes back) it asks DeepSeek's thinking mode a single question and carries on with the answer. A DeepThink choice you saved moves to V4.1 Flash.
- **A reply cut off in the middle of a file is asked for again** and, if it still cannot be read, said in words, instead of "Nothing was changed" and half a stylesheet in the chat. The same repair works on the personal Gemini lane.
- **A muted account is said once**, with the account (masked) and the day it ends, instead of failing after seven tries.
- **A gentler pace on DeepSeek:** at least 4 seconds between steps, at most 10 a minute, a 20-minute rest after "Messages too frequent". Our guess at a safe pace, not a proven one.
- **Settings names the linked DeepSeek account**, masked (for example o***@example.com), so two accounts can be told apart.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.3

### What was new in v0.4.2

- **Work mode is an office suite.** Documents, sheets and presentations are real Word, Excel and PowerPoint files, edited inside the app: a word processor (styles, lists, tables, pictures, links), a spreadsheet (formulas, formats, frozen rows, merged cells, filters, sort) and a slide editor (slide rail, boxes you type in, shapes, tables, pictures, notes, Present full screen). Each saves a real `.docx`, `.xlsx` or `.pptx` by itself, and files made by other programs open with their formatting; what cannot be kept is listed at the top of the file.
- **Charts.** Choose Chart over selected cells for a column, bar, line or pie chart that follows the cells; a slide chart has its own editable data. They are saved as native Excel and PowerPoint charts.
- **Lens works on these files with real tools.** It learns a file's outline, reads only the part it needs and edits one part, while you watch; a six-slide deck from a report takes one call. A chat that begins in Work mode costs less (Lens 0.1.26, installed by the app itself): about 7.3k tokens per model call instead of 13.7k.
- **One look everywhere, every question asked the same way.** One button, field and popup style across the app and the same safe-answer-first dialogs; deleting a file or a chat, unlinking an account and removing all permissions now ask first.
- **Third-party notices** in Settings > General list the open-source packages the app is built on with their licences. The file icons show in the installed app (they were a broken picture in 0.4.1).

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.2

### What was new in v0.4.1

- **Run works for the projects you already have.** Open a folder that holds a Vite web app and the play button above the editor starts it with the project's own dev script, shows it in Preview and becomes Stop. Say "run the app" in the chat and Lens does the same. One Run button now; the App tab is gone.
- **A new blank editor.** A status pill, a headline and three cards of ways to start in each mode: Games, Apps and Web in Code; Slides, Sheets and Docs in Work. A start only puts words in the chat box.
- **`/game` takes a sentence** of up to 600 characters. Its first clause names the folder and the title; the whole idea is kept for Lens. Games are marked Beta.
- **VS Code's file and folder icons** in the file tree and the editor tabs, with light variants (CC BY-SA 4.0, credited in the app).
- **Lens for more computers.** The Lens agent (0.1.25) is published for Intel Macs, Linux and Windows as well as Apple silicon, and Lens Code installs the one that fits. Lens Code's own Mac build for Intel Macs is in the download table.
- **Clean-up.** Unused code and styles were removed and the guide, README and specs now say what the app does today.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.1

### What was new in v0.4.0

- **A game starter.** `/game space dodger` writes a ready-to-run 3D game project into a new folder, with no model and no network: a playable starter game (physics and glow), the three.js and Rapier files exactly as released, and a guide for the chat's model. Open preview plays it with nothing to install. Ask the chat to change it and it does: in the live check the model added an enemy that chases the ball, and touched nothing else.
- **Your own Gemini account.** Link it in Settings > Models (you sign in to Google once in a Chrome window the app opens) and chat with its models, next to the DeepSeek account lane. It drives your own Gemini web account, so Google's terms may not allow it and each message is a chat in your Gemini history; the consent window says so. If a personal model you chose cannot answer, Lens Code says so instead of answering with another model.
- **The page check reads a page's references from its own folder,** so it no longer calls a game's own files missing.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.0

### What was new in v0.3.6

- **Voice that works.** Press the microphone button in the chat box and say what you want: your words appear in the box while you talk, and when you stop they are cleaned up into the message a senior engineer would have typed, using the names of your own files and functions to fix words the computer heard wrong. It never sends anything for you, the microphone is off the moment you stop, and if anything fails your own words are kept. The first time, your computer asks whether Lens Code may use the microphone. What you say is sent through the Lens service to Google's Gemini to be turned into text (see the Privacy Policy); Lens Code keeps no copy.
- **Clear chat is in the chat header,** between History and Close.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.3.6

### What was new in v0.3.5

- **Skills from plain words.** Write "clone https://example.com/ as plain html" (or copy, mirror, duplicate) and the Site cloner runs, without typing /clone and without the model. Sentences that only look similar, such as "clone the repo", still go to the model.
- **Copies that work.** Lens opens each copied site like a visitor would and fetches the files its pages ask for while they run (script chunks, data files, images that load as you scroll), so a copy of a modern site no longer comes out blank.
- **Fixing a copy repairs it.** The model is told the folder is an exact copy and where the original is, and downloads a missing file instead of writing a new one; the page check that rewrites pages after a build does not run on a copy.
- **The Mac you need, in words.** Lens Code needs a Mac with Apple silicon (M1 or newer) and macOS 13 or later. The install script and the app say so; there is no Intel download.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.3.5

### What was new in v0.3.4

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
| v0.4.4 | Published, Latest | What the release notes list: 24 live scenarios on the final code (23 first time; app-chrome failed three loading-screen checks while the computer was busy and passed 33 of 33 on a rerun with nothing changed), every new check failed on the 0.4.3 code first, the packaged UI check (10 of 10), fifteen live scenarios on the packaged app (all passed), run-app (47 of 47) and work-tools (55 of 55) on the packaged test-seam build, the packaged self-update from 0.4.3 (23 of 23, against a local stand-in feed serving the published zip), the checksums of every installer, the release gate. | **Your own DeepSeek account on this code (tested on a stand-in only)**, whether the pace stops DeepSeek's throttling, the account label on a real account, the scenarios this release did not touch (payments, voice, site cloner, the gateway, the battle tests), Microsoft Word, Excel and PowerPoint opening the files made here, the Windows and Linux installers and the Intel Mac build on real computers, a real payment, dictation with a real microphone. |
| v0.4.3 | Superseded | What the release notes list: the new `deepseek-standin` scenario (34 of 34, a scripted copy of chat.deepseek.com, no login) and the 14 other scenarios the release touched (all passed on 2026-10-22; llm-pro-flow once timed out waiting for the Lens agent install and passed 57 of 57 on an unchanged rerun), the packaged UI check (10 of 10), fifteen live scenarios run against the packaged app (all passed), the packaged self-update from 0.4.2 (23 of 23, against a local stand-in feed serving the published zip), the checksums of every installer, the release gate. | **Your own DeepSeek account on this code (muted until 24 October), whether the new pace stops its throttling, the account label on a real account**, the scenarios this release did not touch (the Work tools, voice, payments, the site cloner, the gateway and the battle tests) were not run again, Microsoft Word, Excel and PowerPoint opening the files made here, the Windows and Linux installers and the Intel Mac build on real computers, a real payment, dictation with a real microphone. |
| v0.4.2 | Superseded | What the release notes list: the live scenarios that need no personal account (39 passed on 2026-10-21, two after a rerun; app-chrome also failed four extra runs while the Mac was busy with another program and passed again once it was quiet), the Work test with a real model (52 of 52), the packaged UI check (10 of 10), twelve live scenarios run against the packaged app (all passed), the packaged self-update from 0.4.1 (23 of 23, against a local stand-in feed serving the published zip), the checksums of every installer, the release gate. | Microsoft Word, Excel and PowerPoint opening the files made here, the Windows and Linux installers and the Intel Mac build on real computers, a real mobile-money or USDC payment, dictation with a real microphone. |
| v0.4.1 | Superseded | What the release notes list: the live scenarios that need no personal account (33 passed on 2026-10-21, two after a rerun), the Run, blank editor and file icon scenarios, the packaged UI check (10 of 10), the packaged self-update from 0.4.0 (23 of 23, against a local stand-in feed), the checksums of every installer, the release gate. | The Windows and Linux installers and the Intel Mac build on real computers, a real mobile-money or USDC payment, a real npm install and Vite start on a project a model built, dictation with a real microphone. |
| v0.4.0 | Superseded | What the release notes list: the live scenarios that need no personal account (29 of 29 passed on 2026-10-21, two after a rerun with a real model), the game starter with a real model (47 of 47), the Gemini account lane on a stand-in page (63 of 63), the packaged UI check (10 of 10), the packaged self-update from 0.3.6 (23 of 23), the release gate. | The Gemini account lane with a paid account and the real page's thinking menus, the DeepSeek lane with a real login (its shared relay changed), a real microphone on a real Mac, the Windows and Linux installers on real computers, a real mobile-money or USDC payment. |
| v0.3.6 | Superseded | What the release notes list: the new `voice` live scenario (89 of 89 with real Gemini, 74 of 74 on a clean export of the release files), the other live scenarios that need no personal account (26 passed on 2026-10-20), the packaged UI check (10 of 10), the packaged self-update from 0.3.5 (23 of 23), the release gate. | A real microphone on a real Mac and the installed app's capture path, Swahili and other languages spoken, noisy rooms, a real mobile-money or USDC payment, the Windows and Linux installers on real computers. |
| v0.3.5 | Superseded | What the release notes list: the live app scenarios (25 passed on 2026-10-20, two after a rerun), the packaged UI check (10 of 10), the packaged self-update from 0.3.4 (23 of 23), the release gate. | A real mobile-money or USDC payment, the Windows and Linux installers on real computers, a real Intel Mac or macOS 12, real sites other than the one tried. |
| v0.3.4 | Superseded | What the release notes list under Covered (live runs of the real app, the DeepSeek unit tests, the release gate). | A real mobile-money payment, the Windows and Linux installers on real computers. |
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

- macOS 13 (Ventura) or later on Apple silicon or on an Intel Mac that can run macOS 13, Windows 10 or later, or a recent 64-bit Linux desktop (GTK 3). The app does not open on macOS 12 or older.
- A network connection and a Lens account (free; sign in from the Account tab).
- To run a generated app with Run: Python 3.9 or newer for a Python backend, Node.js with npm for a web app. Building and editing need neither.

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
