# Lens Code releases

Installers for **Lens Code** (formerly Deterministic Coder), the desktop app of the Lens coding agent: it edits the real files in your folder and you watch every change. You sign in with your Lens account; a free account gets a daily allowance of credits, and Lens Plus, Lens Pro and Lens Max give you more. Website: https://lenscode.web.app. The `lens` terminal command has its own releases: https://github.com/teminali/lens-releases

Current version: **v0.4.16 (beta, unsigned)**.

### What's new in v0.4.16

- **Voice runs on this computer.** The app bundles whisper.cpp and llama.cpp for macOS, Windows and Linux. Speech is transcribed by Whisper base and tidied by Qwen 2.5 1.5B, with no cloud voice fallback, sign-in or credit charge. The first microphone press offers a one-time download of the two models, about 1.2 GB, with progress, Stop, Continue, Range resume, retry and checksum refusal; the microphone opens only when the models are ready.
- **Each five-hour credit window holds the old full-day allowance.** The weekly cap stays at seven days and resets Monday 00:00 UTC. Cache creation is charged separately from plain input, including Anthropic's one-hour cache rate. An OpenRouter 402 moves to another key instead of reporting the person's balance as too low.
- **Small fixes:** voice threads follow the machine's available CPUs so a small CI Mac meets the rewrite deadline, links to a local address no longer request a remote favicon, the chat transcript reads inline link labels as one sentence, the microphone fill is measured after its click transition settles, and live-writing lights and background-task controls use the shared UI tokens.

**How it was tested:** this release is published under a one-time owner waiver, not a full release-gate pass. 13 of 86 required scenarios are green on these bytes (21 red, 52 stale), and the gate prints NOT RELEASE-READY. Covered claims include local voice (87/87 checks), the one-time model download (26/26), the gateway credit window (194/194), payments (108/108), the app run tools (32/32), the voice engine inside the built Mac app (download, warm, transcribe, rewrite) and the packaged UI check (9/9, zero page errors). No mutation ledger, no packaged scenario sweep and no Lens-versus-Claude-Code benchmark ran; device-pane (22/25) and tool-loading (64/65) are red. Every unrun or failing check is named in the release notes.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.16

### What was new in v0.4.15

- **Cloudflare Worker edge infrastructure & failover.** Lens Code platform requests connect primarily to Cloudflare Workers (lens-edge), with automatic failover to the secondary address on network errors or 502/503/504 responses.
- **Soul memory.** Lens maintains cross-project context and preferences without intrusive cards or manual configuration, with settings to disable, silence, or erase memories.
- **Cursor-style Settings.** The Settings page features a modern layout with square rail navigation, clean section switching, and instant search across preferences.
- **Multi-project sidebar navigation.** Switch cleanly between projects in the sidebar without layout overflow.
- **Credit meters.** Live tracking of both 5-hour rolling usage and weekly allowances with refill timing in the UI.
- **Search active by default.** Fast index-backed search active across views for skills, settings, and project files.
- **Lens CLI 0.1.37 integration.** Prompt caching prefix preserved from the first turn, reducing token consumption.

**How it was tested:** 58 live scenarios pass on the final code with Lens CLI 0.1.37; packaged app UI check passes 9 of 9 with zero page errors; smoke test passes; logic test suites pass.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.15

### What was new in v0.4.11

- **A picture copy never ends worse than its first draft.** Each model round is judged against the best page so far; a round that matches less, hides words or adds problems is undone, and the copy card says which measure decided.
- **No stand-ins.** People in a copy are the picture's own photographs, charts are the picture's own, logos are cut from the picture; the copy's buttons work through one small file Lens writes, with nothing loaded from the network.
- **Better first drafts** of app screens, forms and dashboards, and no more half-hour freeze measuring a large page.
- **The blank editor stays blank, and unsaved typing stays yours.** Since 0.4.8 every change on disk put the whole folder back over the editor and opened `index.html`; now only files that changed on disk are taken.
- **Copies in React build again** (TypeScript refused the copied page since the behaviour file arrived).

**How it was tested:** all 68 required scenarios pass on the final code, and 17 on the built Mac app (Apple silicon); 281 planted defects were run and every one a check can see was caught (5 cannot change behaviour); the built app updated itself from 0.4.10 (26/26 checks); picture copy ran live on DeepSeek, Gemini and Qoder (62/62 each).

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.11

### What was new in v0.4.7

- **A page from a picture, from words, or from another page.** Attach a picture of a page and Lens measures it, draws a first copy of its own (words as real text, laid out in rows and columns, buttons and form fields as real elements) and the model finishes it, scored against the picture. Describe a page in words and Lens writes its design first, then the page. From one page, ask for the other pages of the site in the same design. Every page goes through your project's design system: plain HTML and CSS, React with Vite, Tailwind, Vue, Svelte or Next.js.
- **Coding agents beside Lens.** The terminal panel has an Agents tab with Claude Code, Codex, Gemini CLI, Qwen Code, Qoder CLI, Cline, opencode and Pi, each in a tab of its own. Lens can hand one of them a task: you approve the exact command, the agent works in its tab, and its report comes back to the chat. The terminal opens to full height, has several tabs, and shows colour.
- **Stop stops a copy at once**, even while the app is still drawing its first draft.
- **Fast mode waits for its models**: until every small model it needs is installed, the work runs in normal mode and the status bar shows what is downloading.

**How it was tested:** every claim ran live in the real app. All 68 required scenarios pass on the final code; 281 deliberately planted defects were run and 276 were caught (5 cannot change behaviour); the built Mac app (Apple silicon) was checked after it was built (17 scenarios). **Not proven:** five real-model runs are still red (copying a hard picture, a long Gemini battle, a chart in a Work sheet that runs past its pane, two Lens agent website runs), five open bugs are listed by name (a copied page does not link to the pages written beside it yet), no real coding agent was handed a task in the checks, and Windows and Linux were not run. The release notes say exactly what ran and what did not.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.7

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

**How it was tested:** every claim ran live in the real app. All 44 required scenarios pass on the final code; 281 deliberately planted defects were run and 276 were caught (5 cannot change behaviour); the built Mac app (Apple silicon) was checked after it was built (17 scenarios, the UI check, and the update from 0.4.4). **Not proven:** no real model has used the new tools yet, Windows and Linux were not run, and buying a plan with mobile money or USDC has not been tried with a real payment. The release notes say exactly what ran and what did not.

Release notes: https://github.com/teminali/deterministic-coder-releases/releases/tag/v0.4.5

## Installers

| Platform | Download | Format | Architecture |
|---|---|---|---|
| macOS | [Lens-Code-mac-arm64.dmg](https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Lens-Code-mac-arm64.dmg) | Disk image | Apple silicon (M1, M2, M3, M4) |
| macOS | [Lens-Code-mac-arm64.zip](https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Lens-Code-mac-arm64.zip) | Archive | Apple silicon (M1, M2, M3, M4) |
| Windows | [Lens-Code-win-x64.exe](https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Lens-Code-win-x64.exe) | Installer | 64-bit |
| Linux | [Lens-Code-linux-x64.AppImage](https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Lens-Code-linux-x64.AppImage) | AppImage | 64-bit |
| Linux | [Lens-Code-linux-x64.deb](https://github.com/teminali/deterministic-coder-releases/releases/latest/download/Lens-Code-linux-x64.deb) | Package | 64-bit Debian, Ubuntu |

Intel Mac builds were not produced for v0.4.16: its optional CI job failed. Apple silicon builds are above.

Checksums: [SHA256SUMS.txt](https://github.com/teminali/deterministic-coder-releases/releases/latest/download/SHA256SUMS.txt)

## One-line install

macOS and Linux:

```bash
curl -fsSL https://raw.githubusercontent.com/teminali/deterministic-coder-releases/main/install.sh | bash
```

Windows (PowerShell):

```powershell
irm https://raw.githubusercontent.com/teminali/deterministic-coder-releases/main/install.ps1 | iex
```

## How to build

Source code: https://github.com/teminali/deterministic-coder
