# lenslet releases

Installers for **lenslet** (formerly Lens Code and Deterministic Coder), the desktop app of the Lens coding agent: it edits the real files in your folder and you watch every change. You sign in with your Lens account; a free account gets an allowance of credits (a 5-hour window and a weekly window), and Lens Pro, Lens Max and Lens Ultra give you more. Website: https://lenslet.web.app. The `lens` terminal command has its own releases: https://github.com/teminali/lens-releases

Current version: **v0.4.23 (unsigned)**, with Lens CLI 0.1.43.

### What's new in v0.4.23

- **Full-height phone pane with floating controls.** No top bar and no hint line under the phone, so it takes 98% of the pane's height; its buttons (Back, Home, Recents, settings, Stop on Android; Home, settings, Stop on iPhone) float in a column at its right edge.
- **Run picks its target.** A target selector beside **▶ Run** lists Web preview, every Android phone, every iPhone simulator (on a Mac only) and **Manage phones…**. With a phone chosen, Run asks approval for the exact build, builds the Flutter, native Android or native iOS app, starts the phone, installs it and opens it (React Native and Expo say plainly that they need Metro).
- **iPhone simulator (macOS only) and Manage phones.** Create a phone from a model and installed Android or iOS version (missing versions give download steps), switch the device frame on or off, toggle light or dark mode, or delete it. On a Mac, lenslet installs AXe (verified by checksum and Developer ID signature) with one button or automatically when starting a simulator; on Windows and Linux no iOS option appears anywhere.
- **Reliable restarts, asset cropping, and v0.4.22 promoted to Stable.** Android emulators cold-boot and power off cleanly on Stop and quit so installed apps are never lost; Stable/Beta update channels (Settings > Preferences > "Get beta versions") and Lens CLI 0.1.43 (routing hand-driven simulator commands to lenslet's device tools) are included. The voice assistant button is hidden until proven on real speech while the dictation microphone stays.

Released before the mutation families were run on this build (they take about ten hours); the release notes list everything verified, both Bench 5 phone runs, and the reruns.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.23

### What was new in v0.4.21

- **Building a phone app costs about half.** Lens's taps now land where it means them, it reads the screen's controls and fields by name, types into the right field, and opens an app in front of others. On a Flutter app with a backend: 30 steps instead of 58, the same 13 of 13 checks.
- **The Claude models are Sonnet 5.5, Opus 5.5 and Haiku 5.5**, in that order. Claude Fable is no longer offered.
- **The report says only what was checked.** A layout counts as checked only when the page was really measured at phone, tablet and desktop widths; a request to be told something counts only when the last message speaks to it.
- **A 5-hour window holds three days of credits** (live on the platform since 18 November 2026).

Released before the mutation families were run on this build (they take about ten hours); the release notes list what was checked and what needed a second run.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.21

### What was new in v0.4.20

- **A working app is no longer reported as broken.** When lenslet tries the app Lens built, it presses a start control only if it is a button or link named by the start word; a dropdown such as Category (Entertainment) no longer makes a working app read as "cannot be started".
- **One Sign in button** in the app's Account panel. The page it opens offers Google, GitHub, and an email and password for accounts we make (such as a trial account).

### What was new in v0.4.18

- **Auto works again when you are signed in.** In v0.4.17 every request on Auto from a signed-in account failed with "The platform model service is temporarily unavailable". This release fixes only that; everything else is v0.4.17. It was released without the full release gate, on the owner's decision; the release notes list what was checked.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.18

### What was new in v0.4.17

- **Lens Code is now called lenslet.** Your chats, projects and settings are kept. On a Mac the app file and the name in the menu bar stay "Lens Code" for now, so that updates from earlier versions keep working.
- **Copying a design from a picture** cuts photographs out instead of redrawing them, matches the typeface, writes the page for every device and checks it at tablet and phone width.
- **Auto** is a new choice in the model picker: Claude Haiku 5.5 that can ask Claude Sonnet for advice once per chat.
- **Voice runs on one model on your computer** (LFM3-Omni-2B, a one-time download of about 1.6 GB). Voice and photo cut-outs need an Apple silicon Mac in this release.
- **New plans:** Free, Lens Pro ($7), Lens Max ($30) and Lens Ultra ($60), each a 30-day pass.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.17

### What was new in v0.4.16

**Read this first: this release was published under a one-time owner waiver, not a release-gate pass.** On these exact bytes 13 of the 86 required scenarios were green, 21 were red and 52 were stale; the release notes name every check that did not run, failed or went stale.

- **Voice runs on this computer.** The app includes whisper.cpp for speech recognition and llama.cpp for rewriting, with Whisper base and Qwen 2.5 1.5B; there is no cloud voice fallback, no sign-in and no credit charge. The first microphone press offers a one-time model download inside the app (about 1.2 GB) with progress, Stop, Continue and retry.
- **Credits are a 5-hour window and a weekly window.** Each five-hour window holds the old full-day allowance; the weekly allowance is seven daily allowances and resets on Monday at 00:00 UTC. Cache creation is now counted separately from ordinary input.
- **Smaller fixes.** Links to a local address no longer request a remote favicon, and an OpenRouter "payment required" (402) answer is treated as a key failure so another key can be tried, not as the person's balance being too low.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.16

### What was new in v0.4.6

- **Lens can look at what it builds, and use the app.** After Lens builds a page, the app opens it in a hidden browser at phone, tablet and desktop widths and measures it (script errors, a blank page, broken images, sideways scroll, controls that are too small), and Lens fixes what is measurably wrong, once. Lens can also read the app's screen, run its commands, fill in a form and read back what the screen says.
- **A start that cannot read your project folder now says so, and fixes itself where it can.** The update from 0.4.4 to 0.4.5 left one person with an empty project tree and a chat that only said it could not answer; the first start of a new version is now guarded against that.
- **Permissions and effort buttons in the chat box.** Ask me first or Full access, and Default, Low, Medium or High effort, right where you type.
- **Lens can ask you a question**, with two to six options, your own words, or skip, in a panel above the chat box that you can answer from the keyboard.
- **A saved provider key stays with its address**, and dictation is tidied by a small text model first.

**How it was tested:** every claim ran live in the real app. All 44 required scenarios pass on the final code; 281 deliberately planted defects were run and 276 were caught (5 cannot change behaviour); the built Mac app (Apple silicon) was checked after it was built (17 scenarios, the UI check, and the update from 0.4.4). **Not proven:** no real model has used the new tools yet, Windows and Linux were not run, and buying a plan with mobile money or USDC has not been tried with a real payment. The release notes say exactly what ran and what did not.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.6

### What was new in v0.4.5

**Read this first: the DeepSeek and Gemini account links are gone.** If you linked your own DeepSeek or Gemini account, the sign-in the app saved for it is deleted the first time 0.4.5 starts, with one note in Settings > Models, and a model you had chosen from those accounts says it is no longer offered. To use DeepSeek, Gemini or any provider that answers like OpenAI's API, add it yourself: **Settings > Models > Add provider** (a name, the provider's address, your own key, the model names). The key is kept in one file that only your user account can read, not in the macOS Keychain or the Windows credential store (on Windows that rests on the folder's own permissions); it is never shown on the page or written to a log, and it goes only to the address you typed.

- **A Lens block at the top of Settings > Models:** Lens, the built-in provider that signs in with your Lens account, with its default model and a status (In use, Not in use, Signed out, Not available right now). If you chose another model, **Reset to default** goes back.
- **One slot in the chat box:** the microphone until you type something to send, then Send, and Stop while Lens works. It never moves. (While the box has text, or while Lens works, the microphone is not offered.)
- **Run is green and Stop is red** in the toolbar.
- **Reopening a folder shows what is on disk.** A file changed, deleted or added by another program while Lens was closed shows as it is, and saving never writes the old text over the newer file. This fixes a way to lose work.
- **Opening a file never changes it** (byte-order mark, CRLF and other line ends keep their exact bytes), and a folder or archive that cannot be opened says why in a sentence.
- **The project map is honest and fast:** it says when it could not read the whole project, counts routes, tests, models and dependencies once each, and a project built to be slow can no longer hang it.
- **The Lens agent's updater** refuses a bad download cleanly and leaves nothing behind.

**How it was tested:** every claim ran live in the real app. The 37 required scenarios passed twice in a row on the final code, 138 deliberately planted defects were all caught (2 cannot change behaviour), and the built Mac app (Apple silicon) was checked on the installer's own bytes, including the update from 0.4.4. **Not run:** Windows, Linux and the Intel Mac build beyond a start-up check, and everything that needs a real account or a real model (named in the release notes under Not proven). The installers are not code-signed: on macOS, if the app will not open, allow it in System Settings > Privacy & Security (Open Anyway).

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.5

### What was new in v0.4.4

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
| v0.4.23 | Published, Latest | Every required live scenario green on these exact bytes (90/90, 5,801 checks; four reruns explained in the notes), 14/14 scenarios on the shipped macOS arm64 app (898/898) and 3/3 on its test-seam build (210/210), `packaged_ui_check.js` (including `voice_assistant_hidden`), `update_packaged.sh` from v0.4.21 (26/26), all 145 logic tests, lint/build checks, CI smoke on mac-arm64/mac-x64/win-x64/linux-x64, and two real-model Bench 5 phone runs (Android + iPhone simulator). | The mutation families (not run on this build: about ten hours), the automated multi-prompt benchmark ledger (waived by the owner), Windows and Linux on real machines. |
| v0.4.22 | Superseded (beta) | Beta pre-release (CLI 0.1.42); superseded by v0.4.23 Stable. | See v0.4.22 release notes. |
| v0.4.21 | Superseded | Every required live scenario green on these exact bytes (88; two that failed once in the sweep passed alone, explained in the notes), 14 scenarios on the packaged app and 3 on its test-seam build, the update from v0.4.20, the unit and logic tests (one speed check that sits at its budget on the build Mac is disclosed), the build. A first build was not released: its sweep found a fault in the report fix, fixed and rerun in full. | The mutation families (not run on this build: about ten hours), the benchmark step (owner's waiver), Windows and Linux on real machines. |
| v0.4.20 | Superseded | Every required live scenario green on these exact bytes (88; seven that failed once in the sweep passed alone, explained in the notes), 14 scenarios on the packaged app and 3 on its test-seam build, the update from v0.4.19, the unit and logic tests, the build. | The mutation families (not run on this build: about ten hours), the benchmark step (owner's waiver), Windows and Linux on real machines. |
| v0.4.19 | Superseded | Every required live scenario green on these exact bytes (88 scenarios, 5,634 checks; three that failed under load passed alone and are explained in the notes), 14 scenarios on the packaged app and 3 on its test-seam build, the unit and logic tests, the build. | The mutation families (not run on this build: about ten hours), the benchmark step (owner's waiver), the canary scenarios that need real models, paid services or the network (listed under Not proven). |
| v0.4.18 | Superseded | v0.4.17 plus one fix (Auto through the key relay): a check of the gateway against a stand-in relay that failed on v0.4.17 and passes here, the gateway's own tests, the shipped gateway file read out of the built app and checked, the update from v0.4.17 through the public feed. | The full sweep of live scenarios, the mutation families and the packaged checks were not run again (owner's decision: the build differs from v0.4.17 only in the gateway file); the benchmark step. |
| v0.4.17 | Superseded | Every step of the release gate but the benchmark step: all 88 required scenarios green on these exact bytes (5,617 checks), 14 scenarios on the packaged app and 3 on its test-seam build, twelve mutation families (362 planted defects, none surviving), the unit and logic tests and the build. | The benchmark step (owner's waiver: the Sonnet comparison in the notes is the evidence), the canary scenarios that need real models, paid services or the network (listed under Not proven in the notes), and the Windows, Linux and Intel Mac builds on real computers. |
| v0.4.16 | Superseded | What the release notes list under Covered: 14 claims, among them voice on this computer, the 5-hour and weekly credit windows and payments. 13 of the 86 required scenarios were green on these exact bytes. | 21 required scenarios were red and 52 were stale; the full sweep, the mutation family and the packaged checks did not complete, and the release gate prints NOT RELEASE-READY. Published under a one-time owner waiver; the release notes list every claim that is not covered. |
| v0.4.5 to v0.4.15 | Superseded | See each release's notes. | |
| v0.4.4 | Superseded | What the release notes list: 24 live scenarios on the final code (23 first time; app-chrome failed three loading-screen checks while the computer was busy and passed 33 of 33 on a rerun with nothing changed), every new check failed on the 0.4.3 code first, the packaged UI check (10 of 10), fifteen live scenarios on the packaged app (all passed), run-app (47 of 47) and work-tools (55 of 55) on the packaged test-seam build, the packaged self-update from 0.4.3 (23 of 23, against a local stand-in feed serving the published zip), the checksums of every installer, the release gate. | **Your own DeepSeek account on this code (tested on a stand-in only)**, whether the pace stops DeepSeek's throttling, the account label on a real account, the scenarios this release did not touch (payments, voice, site cloner, the gateway, the battle tests), Microsoft Word, Excel and PowerPoint opening the files made here, the Windows and Linux installers and the Intel Mac build on real computers, a real payment, dictation with a real microphone. |
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
