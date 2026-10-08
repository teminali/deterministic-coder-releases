#!/bin/sh
# Deterministic Coder installer for macOS and Linux.
#
#   curl -fsSL https://raw.githubusercontent.com/teminali/deterministic-coder-releases/main/install.sh | sh
#
# What it does: downloads the release file and SHA256SUMS.txt with curl, checks the
# SHA-256 (and stops if it does not match or has no entry), installs the app for you
# (no sudo), and starts it. A file fetched by curl never gets the browser's
# quarantine flag, which is why a downloaded .dmg is blocked and this is not.
#
# What you see: six numbered steps (checking your computer, finding the latest release,
# downloading with a progress bar, verifying the SHA-256, installing, opening), each with
# a status mark and its time, then a final box. On a terminal that supports it (stdout is a
# TTY, NO_COLOR unset, TERM not "dumb", at least 14 rows) the steps are drawn in place with
# colors and box characters; everywhere else (a pipe, a log, CI) it prints one plain line
# per step. Nothing is ever read from the keyboard, so it works inside "curl | sh".
#
# The whole script lives inside main(), which is called on the very last line inside a
# brace group that is only complete in full, so a download that is cut short runs nothing
# (not even a last line that was cut down to the word "main").
#
# Test overrides (all optional):
#   DC_BASE_URL     release download base (default: the public releases repo, "latest")
#   DC_INSTALL_DIR  where to install (macOS: folder for the .app; Linux: the bin folder)
#   DC_NO_LAUNCH=1  do not start the app afterwards
#   DC_OS / DC_ARCH force mac|linux and arm64|x64
#   DC_SYSTEM_APPS_DIR / DC_USER_APPS_DIR  macOS defaults (/Applications, ~/Applications)

set -eu

DC_APP_NAME="Deterministic Coder"
DC_APP_BUNDLE="Deterministic Coder.app"
DC_DEFAULT_BASE="https://github.com/teminali/deterministic-coder-releases/releases/latest/download"
DC_RELEASES_PAGE="https://github.com/teminali/deterministic-coder-releases/releases/latest"
DC_DOWNLOAD_PAGE="https://deterministiccoder.web.app/#download"
DC_SUMS_NAME="SHA256SUMS.txt"
DC_TMP=""
DC_POLL=""
DC_CANCEL=0
DC_CUR=0
DC_NSTEPS=6
DC_BLOCK=12
DC_UI=plain
DC_HIDDEN=0
DC_NOTES=""
DC_ESC=""
DC_C_RST=""
DC_C_BOLD=""
DC_C_DIM=""
DC_C_GRN=""
DC_C_RED=""
DC_C_CYN=""
DC_TW=60
DC_IW=64
DC_BARW=20
DC_TICK=1
DC_TAG=""
DC_GET=""
DC_T_ALL=0
DC_ST1=pending
DC_ST2=pending
DC_ST3=pending
DC_ST4=pending
DC_ST5=pending
DC_ST6=pending
DC_TT1="Checking your computer"
DC_TT2="Finding the latest release"
DC_TT3="Downloading"
DC_TT4="Verifying SHA-256"
DC_TT5="Installing"
DC_TT6="Opening $DC_APP_NAME"
DC_EL1=""
DC_EL2=""
DC_EL3=""
DC_EL4=""
DC_EL5=""
DC_EL6=""
DC_DT1=""
DC_DT2=""
DC_DT3=""
DC_DT4=""
DC_DT5=""
DC_DT6=""

say() { printf '%s\n' "$*"; }

# ---------------------------------------------------------------- terminal UI

# Fancy only for a real terminal that wants color; otherwise plain lines. Decided once.
ui_init() {
  DC_UI=plain
  if [ -t 1 ] && [ -z "${NO_COLOR:-}" ] && [ -n "${TERM:-}" ] && [ "${TERM:-}" != dumb ]; then
    # The size of the terminal itself (stdin is the pipe in "curl | sh", so ask the controlling terminal).
    DC_SIZE_TTY="$(stty size </dev/tty 2>/dev/null || true)"
    DC_ROWS="${DC_SIZE_TTY% *}"
    DC_COLS="${DC_SIZE_TTY#* }"
    case "$DC_ROWS" in '' | *[!0-9]*) DC_ROWS=24 ;; esac
    case "$DC_COLS" in '' | *[!0-9]*) DC_COLS=80 ;; esac
    if [ "$DC_ROWS" -eq 0 ]; then DC_ROWS=24; fi
    if [ "$DC_COLS" -eq 0 ]; then DC_COLS=80; fi
    if [ "$DC_ROWS" -ge $((DC_BLOCK + 2)) ] && [ "$DC_COLS" -ge 50 ]; then DC_UI=fancy; fi
  fi
  if [ "$DC_UI" = fancy ]; then
    DC_ESC="$(printf '\033')"
    DC_C_RST="${DC_ESC}[0m"
    DC_C_BOLD="${DC_ESC}[1m"
    DC_C_DIM="${DC_ESC}[2m"
    DC_C_GRN="${DC_ESC}[32m"
    DC_C_RED="${DC_ESC}[31m"
    DC_C_CYN="${DC_ESC}[36m"
    if [ "$DC_COLS" -lt 72 ]; then
      DC_TW=$((DC_COLS - 8))
      DC_IW=$((DC_TW + 4))
    fi
    if [ "$DC_COLS" -lt 80 ]; then DC_BARW=10; fi
    # Sub-second ticks where sleep supports them (macOS and GNU do), else one second.
    if sleep 0.1 2>/dev/null; then DC_TICK=0.25; else DC_TICK=1; fi
  fi
}

# n horizontal-rule glyphs
ui_rule() {
  DC_RI=0
  DC_RS=""
  while [ "$DC_RI" -lt "$1" ]; do
    DC_RS="${DC_RS}─"
    DC_RI=$((DC_RI + 1))
  done
  printf '%s' "$DC_RS"
}

# ui_box_top COLOR TITLE / ui_box_line COLOR TEXT / ui_box_bottom COLOR. Text inside a box is ASCII only,
# so the padding is exact.
ui_box_top() {
  printf '%s╭─ %s%s%s%s %s╮%s\n' "$1" "$DC_C_BOLD" "$2" "$DC_C_RST" "$1" "$(ui_rule $((DC_IW - 3 - ${#2})))" "$DC_C_RST"
}
ui_box_line() {
  # shellcheck disable=SC2059
  printf "%s│%s  %-${DC_TW}s  %s│%s\n" "$1" "$DC_C_RST" "$2" "$1" "$DC_C_RST"
}
ui_box_bottom() {
  printf '%s╰%s╯%s\n' "$1" "$(ui_rule "$DC_IW")" "$DC_C_RST"
}
# Lines on stdin, already wrapped to DC_TW.
ui_box() {
  ui_box_top "$1" "$2"
  while IFS= read -r DC_BL; do ui_box_line "$1" "$DC_BL"; done
  ui_box_bottom "$1"
}
ui_wrap() { printf '%s\n' "$1" | fold -s -w "$DC_TW"; }

# Draws TEXT on screen line N (1 = top of the block) in one write, then parks the cursor below the block again.
ui_at() {
  DC_UP=$((DC_BLOCK + 1 - $1))
  printf '%s[%sA\r%s[K%s%s[%sB\r' "$DC_ESC" "$DC_UP" "$DC_ESC" "$2" "$DC_ESC" "$DC_UP"
}

ui_step_text() {
  eval "DC_S=\$DC_ST$1; DC_T=\$DC_TT$1; DC_X=\$DC_EL$1; DC_D=\$DC_DT$1"
  DC_TC=""
  case "$DC_S" in
    running)
      DC_M="${DC_C_CYN}▸${DC_C_RST}"
      DC_TC="$DC_C_BOLD"
      ;;
    done) DC_M="${DC_C_GRN}✓${DC_C_RST}" ;;
    failed)
      DC_M="${DC_C_RED}✗${DC_C_RST}"
      DC_TC="$DC_C_RED"
      ;;
    skipped)
      DC_M="${DC_C_DIM}-${DC_C_RST}"
      DC_TC="$DC_C_DIM"
      ;;
    *)
      DC_M="${DC_C_DIM}·${DC_C_RST}"
      DC_TC="$DC_C_DIM"
      ;;
  esac
  if [ -n "$DC_X" ]; then DC_X="${DC_X}s"; fi
  printf '  %s %s/%s  %s%-32s%s %-4s %s%s%s' "$DC_M" "$1" "$DC_NSTEPS" "$DC_TC" "$DC_T" "$DC_C_RST" "$DC_X" "$DC_C_DIM" "$DC_D" "$DC_C_RST"
}

ui_start() {
  DC_T_ALL="$(date +%s)"
  DC_SYSDESC="$DC_PLAT $DC_CPU"
  if [ "$DC_PLAT" = mac ]; then DC_NICE="macOS"; else DC_NICE="Linux"; fi
  if [ "$DC_UI" != fancy ]; then
    say "$DC_APP_NAME installer ($DC_NICE $DC_CPU)"
    say "Source: $DC_BASE (SHA-256 checked, no sudo)"
    return 0
  fi
  {
    ui_box_top "$DC_C_CYN" "$DC_APP_NAME"
    ui_box_line "$DC_C_CYN" "Installer for $DC_NICE ($DC_CPU)"
    ui_box_line "$DC_C_CYN" "Release: finding the latest..."
    ui_box_bottom "$DC_C_CYN"
    printf '\n'
    DC_K=1
    while [ "$DC_K" -le "$DC_NSTEPS" ]; do
      ui_step_text "$DC_K"
      printf '\n'
      DC_K=$((DC_K + 1))
    done
    printf '\n'
    printf '%s[?25l' "$DC_ESC"
  }
  DC_HIDDEN=1
}

ui_version() {
  if [ "$DC_UI" != fancy ]; then return 0; fi
  if [ -n "$DC_TAG" ]; then DC_VT="Release: $DC_TAG"; else DC_VT="Release: latest"; fi
  ui_at 3 "$(ui_box_line "$DC_C_CYN" "$DC_VT")"
}

st_set() { eval "DC_ST$1=\$2"; }

# Shows step N in its current state (fancy: redraw in place; plain: one line, only once it has finished).
st_show() {
  eval "DC_S=\$DC_ST$1"
  if [ "$DC_UI" = fancy ]; then
    ui_at $((5 + $1)) "$(ui_step_text "$1")"
    return 0
  fi
  case "$DC_S" in
    done) DC_W=ok ;;
    failed) DC_W=FAILED ;;
    skipped) DC_W=skipped ;;
    *) return 0 ;;
  esac
  eval "DC_T=\$DC_TT$1; DC_X=\$DC_EL$1; DC_D=\$DC_DT$1"
  DC_LINE="[$1/$DC_NSTEPS] $DC_T ... $DC_W"
  if [ -n "$DC_X" ]; then DC_LINE="$DC_LINE (${DC_X}s)"; fi
  if [ -n "$DC_D" ]; then DC_LINE="$DC_LINE - $DC_D"; fi
  say "$DC_LINE"
}

st_begin() {
  DC_CUR="$1"
  DC_T0="$(date +%s)"
  st_set "$1" running
  eval "DC_EL$1="
  st_show "$1"
}

# st_end N [state] [detail]
st_end() {
  DC_ELAPSED=$(($(date +%s) - DC_T0))
  eval "DC_EL$1=\$DC_ELAPSED"
  st_set "$1" "${2:-done}"
  eval "DC_DT$1=\${3:-}"
  DC_CUR=0
  st_show "$1"
}

# Something to tell the user that is not an error. Plain: printed now; fancy: shown in the final box.
note() {
  if [ "$DC_UI" = fancy ]; then
    DC_NOTES="$DC_NOTES
$*"
  else
    say "  Note: $*"
  fi
}

# fail "what went wrong" ["the exact next step"]. Always exits 1. Every failure ends by saying the installer file can be
# used instead, with the address of the download page.
fail() {
  DC_WHY="$1"
  DC_NEXT="${2:-Run the same command again.} If it stops the same way, use the installer file instead: open $DC_DOWNLOAD_PAGE and download the installer for your system."
  if [ "$DC_CUR" -gt 0 ]; then st_end "$DC_CUR" failed; fi
  if [ "$DC_UI" = fancy ] && [ -t 2 ]; then
    printf '\n' >&2
    {
      ui_wrap "$DC_WHY"
      printf '\n'
      ui_wrap "Next step: $DC_NEXT"
    } | ui_box "$DC_C_RED" "Install stopped" >&2
  else
    printf '\nInstall stopped: %s\n' "$DC_WHY" >&2
    printf 'Next step: %s\n' "$DC_NEXT" >&2
  fi
  exit 1
}

# Called on every exit (including INT/TERM): stop the progress drawer, put the cursor back, remove the temp folder.
cleanup() {
  if [ -n "$DC_POLL" ]; then
    kill "$DC_POLL" 2>/dev/null || true
    wait "$DC_POLL" 2>/dev/null || true
    DC_POLL=""
  fi
  if [ "$DC_HIDDEN" = 1 ]; then
    printf '%s[?25h' "$DC_ESC"
    DC_HIDDEN=0
  fi
  if [ "$DC_CANCEL" = 1 ]; then
    printf '\nInstall cancelled. Run the command again when you are ready.\n' >&2
  fi
  if [ -n "$DC_TMP" ] && [ -d "$DC_TMP" ]; then rm -rf "${DC_TMP:?}"; fi
}

usage() {
  cat <<'USAGE'
Deterministic Coder installer (macOS and Linux)

Usage: install.sh [--uninstall] [--help]

  (no option)   download, verify and install the latest release, then start it
  --uninstall   remove the app (your settings and projects are not touched)
  --help        show this text

Run it again at any time to update. It never uses sudo.
Environment: DC_BASE_URL, DC_INSTALL_DIR, DC_NO_LAUNCH=1, DC_OS, DC_ARCH, NO_COLOR.
USAGE
}

# ---------------------------------------------------------------- detection and checksum

detect_os() {
  if [ -n "${DC_OS:-}" ]; then
    DC_PLAT="$DC_OS"
  else
    case "$(uname -s)" in
      Darwin) DC_PLAT=mac ;;
      Linux) DC_PLAT=linux ;;
      *) fail "this installer supports macOS and Linux. On Windows use install.ps1." "On Windows, open PowerShell and run the irm command from the download page." ;;
    esac
  fi
  case "$DC_PLAT" in mac | linux) ;; *) fail "unsupported system: $DC_PLAT" ;; esac
}

detect_arch() {
  if [ -n "${DC_ARCH:-}" ]; then
    DC_CPU="$DC_ARCH"
  else
    DC_RAW="$(uname -m)"
    case "$DC_RAW" in
      arm64 | aarch64) DC_CPU=arm64 ;;
      x86_64 | amd64) DC_CPU=x64 ;;
      *) fail "unsupported processor: $DC_RAW" ;;
    esac
    # A shell running under Rosetta reports x86_64 on an Apple Silicon Mac.
    if [ "$DC_PLAT" = mac ] && [ "$DC_CPU" = x64 ] && [ "$(sysctl -n sysctl.proc_translated 2>/dev/null || echo 0)" = 1 ]; then
      DC_CPU=arm64
    fi
  fi
  case "$DC_CPU" in arm64 | x64) ;; *) fail "unsupported processor: $DC_CPU" ;; esac
}

sha256_of() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    fail "neither shasum nor sha256sum is available, so the download cannot be checked." "Install shasum or sha256sum, then run the same command again."
  fi
}

# ---------------------------------------------------------------- download

# A download that failed: say whether it looks like the network or the server.
fetch_fail() {
  DC_CE="$(tr '\n' ' ' <"$DC_TMP/curl.err" 2>/dev/null || true)"
  DC_CE="${DC_CE% }"
  case "$2" in
    6 | 7 | 28 | 35 | 52 | 55 | 56)
      fail "could not download $1 (the server could not be reached). $DC_CE" "Check your internet connection, then run the same command again."
      ;;
    *)
      fail "could not download $1 ${DC_CE:+($DC_CE)}" "Run the same command again in a few minutes."
      ;;
  esac
}

# Step 2: fetch SHA256SUMS.txt. On GitHub, ".../releases/latest/download/X" redirects to ".../releases/download/<tag>/X";
# when that first redirect stays on the same site, the release file is then fetched from that tag too, so the checksum list
# and the file always come from the same release. Without a redirect (or one that goes elsewhere) the plain base is used.
find_release() {
  DC_GET="$DC_BASE"
  DC_TAG=""
  DC_ORIGIN="$(printf '%s' "$DC_BASE" | sed -n 's|^\(https\{0,1\}://[^/]*\).*$|\1|p')"
  DC_RC=0
  curl -fsSL --retry 2 --connect-timeout 20 -D "$DC_TMP/sums.hdr" -o "$DC_TMP/$DC_SUMS_NAME" "$DC_BASE/$DC_SUMS_NAME" </dev/null 2>"$DC_TMP/curl.err" || DC_RC=$?
  if [ "$DC_RC" -ne 0 ]; then fetch_fail "$DC_BASE/$DC_SUMS_NAME" "$DC_RC"; fi
  DC_LOC="$(tr -d '\r' <"$DC_TMP/sums.hdr" | awk 'tolower($1) == "location:" { print $2; exit }')"
  if [ -n "$DC_ORIGIN" ] && [ -n "$DC_LOC" ]; then
    case "$DC_LOC" in
      "$DC_ORIGIN"/*download/*/"$DC_SUMS_NAME")
        DC_PIN="${DC_LOC%/"$DC_SUMS_NAME"}"
        case "$DC_PIN" in
          *[!A-Za-z0-9._:/@%+~-]*) ;;
          *)
            DC_GET="$DC_PIN"
            DC_TAG="${DC_PIN##*/}"
            ;;
        esac
        ;;
    esac
  fi
}

# Bytes of the Content-Length of the last response in a curl -D header dump (0 when unknown).
dl_total() {
  awk '/^HTTP\// { v = 0 } tolower($1) == "content-length:" { v = $2 } END { print v + 0 }' "$1" 2>/dev/null || echo 0
}

# "████░░░░  48%  52.3 / 109.4 MB  14.2 MB/s" for SIZE TOTAL TICKS TICK_SECONDS
ui_bar_text() {
  awk -v s="$1" -v t="$2" -v n="$3" -v k="$DC_TICK" -v w="$DC_BARW" -v on="█" -v off="░" '
    function mb(x) { return sprintf("%.1f", x / 1000000) }
    BEGIN {
      e = n * k
      sp = (e > 0.5) ? s / e : 0
      if (t > 0) {
        p = s / t
        if (p > 1) p = 1
        c = int(p * w + 0.5)
        bar = ""
        for (i = 0; i < w; i++) bar = bar (i < c ? on : off)
        printf "%s %3d%%  %s / %s MB", bar, int(p * 100), mb(s), mb(t)
      } else {
        printf "%s MB so far", mb(s)
      }
      if (sp > 0) printf "  %s MB/s", mb(sp)
    }'
}

# Runs as a background process while curl downloads: redraws the progress line a few times a second.
dl_poll() {
  DC_N=0
  while :; do
    DC_SZ=0
    if [ -f "$1" ]; then DC_SZ=$(($(wc -c <"$1" 2>/dev/null || echo 0))); fi
    ui_at 12 "       ${DC_C_CYN}$(ui_bar_text "$DC_SZ" "$(dl_total "$2")" "$DC_N")${DC_C_RST}"
    sleep "$DC_TICK"
    DC_N=$((DC_N + 1))
  done
}

# Step 3: the release file, with a progress bar on a terminal.
fetch_asset() {
  DC_OUT="$DC_TMP/$DC_ASSET"
  DC_RC=0
  if [ "$DC_UI" = fancy ]; then
    dl_poll "$DC_OUT" "$DC_TMP/asset.hdr" &
    DC_POLL=$!
  fi
  curl -fsSL --retry 2 --connect-timeout 20 -D "$DC_TMP/asset.hdr" -w '%{speed_download}' -o "$DC_OUT" "$DC_GET/$DC_ASSET" </dev/null >"$DC_TMP/stat" 2>"$DC_TMP/curl.err" || DC_RC=$?
  if [ -n "$DC_POLL" ]; then
    kill "$DC_POLL" 2>/dev/null || true
    wait "$DC_POLL" 2>/dev/null || true
    DC_POLL=""
  fi
  if [ "$DC_RC" -ne 0 ]; then fetch_fail "$DC_GET/$DC_ASSET" "$DC_RC"; fi
  DC_SIZE=$(($(wc -c <"$DC_OUT")))
  DC_SPEED="$(awk -v s="$(cat "$DC_TMP/stat" 2>/dev/null)" 'BEGIN { printf "%.1f", s / 1000000 }')"
  DC_SIZE_MB="$(awk -v s="$DC_SIZE" 'BEGIN { printf "%.1f", s / 1000000 }')"
  if [ "$DC_UI" = fancy ]; then
    ui_at 12 "       ${DC_C_CYN}$(ui_bar_text "$DC_SIZE" "$DC_SIZE" 0)  ${DC_SPEED} MB/s${DC_C_RST}"
  fi
  DC_DL_DETAIL="$DC_SIZE_MB MB at $DC_SPEED MB/s"
}

# Step 4. Fails closed: no entry, a malformed entry or a different hash deletes the download and stops.
verify_download() {
  DC_WANT="$(awk -v n="$DC_ASSET" '{ f = $2; sub(/^\*/, "", f); if (f == n) { print tolower($1); exit } }' "$DC_TMP/$DC_SUMS_NAME")"
  DC_STOP="Nothing was installed. Wait a few minutes and run the same command again. If a checksum keeps failing, please report it at $DC_RELEASES_PAGE."
  if [ -z "$DC_WANT" ]; then
    rm -f "${DC_TMP:?}/${DC_ASSET:?}"
    fail "$DC_SUMS_NAME has no entry for $DC_ASSET, so it cannot be verified. Nothing was installed." "$DC_STOP"
  fi
  if [ "${#DC_WANT}" -ne 64 ] || [ -n "$(printf '%s' "$DC_WANT" | tr -d '0-9a-f')" ]; then
    rm -f "${DC_TMP:?}/${DC_ASSET:?}"
    fail "$DC_SUMS_NAME has a malformed entry for $DC_ASSET. Nothing was installed." "$DC_STOP"
  fi
  DC_GOT="$(sha256_of "$DC_TMP/$DC_ASSET")"
  if [ "$DC_GOT" != "$DC_WANT" ]; then
    rm -f "${DC_TMP:?}/${DC_ASSET:?}"
    fail "checksum mismatch for $DC_ASSET (expected $DC_WANT, got $DC_GOT). The file was deleted and nothing was installed." "$DC_STOP"
  fi
  if [ "$DC_UI" = fancy ]; then DC_VD="$(printf '%.16s' "$DC_GOT")..."; else DC_VD="$DC_GOT"; fi
}

# ---------------------------------------------------------------- macOS

mac_dest_dir() {
  if [ -n "${DC_INSTALL_DIR:-}" ]; then
    mkdir -p "$DC_INSTALL_DIR" || fail "cannot create $DC_INSTALL_DIR"
    DC_DEST_DIR="$DC_INSTALL_DIR"
    return
  fi
  DC_SYS="${DC_SYSTEM_APPS_DIR:-/Applications}"
  DC_USR="${DC_USER_APPS_DIR:-$HOME/Applications}"
  # Update in place if it is already installed in the per-user folder.
  if [ ! -e "$DC_SYS/$DC_APP_BUNDLE" ] && [ -e "$DC_USR/$DC_APP_BUNDLE" ] && [ -w "$DC_USR" ]; then
    DC_DEST_DIR="$DC_USR"
    return
  fi
  if [ -d "$DC_SYS" ] && [ -w "$DC_SYS" ]; then
    DC_DEST_DIR="$DC_SYS"
    return
  fi
  mkdir -p "$DC_USR" || fail "$DC_SYS is not writable and $DC_USR cannot be created"
  DC_DEST_DIR="$DC_USR"
  note "$DC_SYS is not writable here, so the app goes into $DC_USR (no sudo is used)."
}

# Only a copy running from exactly the given path is asked to quit; never anything else,
# and never by force.
mac_quit_running() {
  if pgrep -f "$1/Contents/MacOS/" >/dev/null 2>&1; then
    note "Asking the running $DC_APP_NAME to quit..."
    osascript -e "tell application \"$1\" to quit" >/dev/null 2>&1 </dev/null || true
    DC_WAIT=0
    while pgrep -f "$1/Contents/MacOS/" >/dev/null 2>&1; do
      DC_WAIT=$((DC_WAIT + 1))
      if [ "$DC_WAIT" -gt 20 ]; then fail "$DC_APP_NAME is still running. Quit it (Cmd-Q) and run this again." "Quit $DC_APP_NAME with Cmd-Q, then run the same command again."; fi
      sleep 1
    done
  fi
}

mac_version() {
  /usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$1/Contents/Info.plist" 2>/dev/null || echo unknown
}

# Use Apple's own tools. A different xattr/ditto earlier on PATH (a Python "xattr" has no -r)
# would make the quarantine step silently do nothing.
mac_system_path() {
  PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
  export PATH
}

# Step 1 on macOS.
mac_prepare() {
  mac_system_path
  command -v ditto >/dev/null 2>&1 || fail "ditto is missing; this does not look like macOS."
  DC_ASSET="Deterministic-Coder-mac-$DC_CPU.zip"
  mac_dest_dir
  DC_DEST="$DC_DEST_DIR/$DC_APP_BUNDLE"
  DC_TT5="Installing into $DC_DEST_DIR"
  DC_MACV="$(sw_vers -productVersion 2>/dev/null || true)"
  DC_SYSDESC="macOS ${DC_MACV:+$DC_MACV, }$DC_CPU"
  DC_TT1="Checking your Mac"
}

# Step 5 on macOS.
mac_install_app() {
  mkdir "$DC_TMP/x"
  ditto -x -k "$DC_TMP/$DC_ASSET" "$DC_TMP/x" </dev/null >/dev/null 2>&1 || fail "the downloaded zip could not be unpacked."
  [ -d "$DC_TMP/x/$DC_APP_BUNDLE" ] || fail "the download does not contain $DC_APP_BUNDLE. Nothing was installed."

  DC_NEW="$DC_DEST_DIR/.dc-new.$$"
  DC_OLD="$DC_DEST_DIR/.dc-old.$$"
  rm -rf "${DC_NEW:?}"
  ditto "$DC_TMP/x/$DC_APP_BUNDLE" "$DC_NEW" >/dev/null 2>&1 || { rm -rf "${DC_NEW:?}"; fail "could not copy the app into $DC_DEST_DIR"; }
  xattr -cr "$DC_NEW" 2>/dev/null || true
  if xattr -rl "$DC_NEW" 2>/dev/null | grep -q 'com\.apple\.quarantine'; then
    rm -rf "${DC_NEW:?}"
    fail "could not clear the quarantine flag from the app. Nothing was installed."
  fi
  if ! codesign --verify --deep --strict "$DC_NEW" 2>/dev/null; then
    rm -rf "${DC_NEW:?}"
    fail "the app's code signature did not verify. Nothing was installed."
  fi
  mac_quit_running "$DC_DEST"
  if [ -e "$DC_DEST" ]; then
    mv "$DC_DEST" "$DC_OLD" || { rm -rf "${DC_NEW:?}"; fail "could not replace the existing $DC_DEST"; }
  fi
  if ! mv "$DC_NEW" "$DC_DEST"; then
    if [ -e "$DC_OLD" ]; then mv "$DC_OLD" "$DC_DEST" || true; fi
    rm -rf "${DC_NEW:?}"
    fail "could not move the new app into place; the previous copy was left as it was."
  fi
  rm -rf "${DC_OLD:?}"
  xattr -cr "$DC_DEST" 2>/dev/null || true
  codesign --verify --deep --strict "$DC_DEST" 2>/dev/null || fail "the installed app's code signature did not verify."

  DC_VER="$(mac_version "$DC_DEST")"
  DC_WHERE="$DC_DEST"
  DC_FIRST="Installed $DC_APP_NAME $DC_VER"
}

# Step 6 on macOS.
mac_launch() {
  if [ "${DC_NO_LAUNCH:-}" = 1 ]; then
    st_end 6 skipped "not started (DC_NO_LAUNCH=1)"
    DC_NEXT_TEXT="Open $DC_APP_NAME from $DC_DEST_DIR."
    return 0
  fi
  if open "$DC_DEST" </dev/null >/dev/null 2>&1; then
    st_end 6 done
    DC_NEXT_TEXT="$DC_APP_NAME is opening now. Next time, open it from $DC_DEST_DIR."
  else
    st_end 6 failed
    note "Could not start it; open it from $DC_DEST_DIR."
    DC_NEXT_TEXT="Open $DC_APP_NAME from $DC_DEST_DIR."
  fi
}

mac_uninstall() {
  mac_system_path
  DC_FOUND=0
  for DC_DIR in "${DC_INSTALL_DIR:-}" "${DC_SYSTEM_APPS_DIR:-/Applications}" "${DC_USER_APPS_DIR:-$HOME/Applications}"; do
    [ -n "$DC_DIR" ] || continue
    if [ -e "$DC_DIR/$DC_APP_BUNDLE" ]; then
      mac_quit_running "$DC_DIR/$DC_APP_BUNDLE"
      rm -rf "${DC_DIR:?}/$DC_APP_BUNDLE" || fail "could not remove $DC_DIR/$DC_APP_BUNDLE"
      say "Removed $DC_DIR/$DC_APP_BUNDLE"
      DC_FOUND=1
    fi
    # With an explicit install folder, that is the only place we touch.
    [ -z "${DC_INSTALL_DIR:-}" ] || break
  done
  if [ "$DC_FOUND" != 1 ]; then say "$DC_APP_NAME is not installed."; fi
  say "Your settings and projects were left in place."
}

# ---------------------------------------------------------------- Linux

linux_paths() {
  DC_BIN_DIR="${DC_INSTALL_DIR:-$HOME/.local/bin}"
  DC_BIN="$DC_BIN_DIR/deterministic-coder"
  if [ -n "${DC_DESKTOP_DIR:-}" ]; then
    DC_DESK_DIR="$DC_DESKTOP_DIR"
  elif [ -n "${DC_INSTALL_DIR:-}" ]; then
    DC_DESK_DIR="$DC_INSTALL_DIR"
  else
    DC_DESK_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
  fi
  DC_DESK="$DC_DESK_DIR/deterministic-coder.desktop"
}

# Step 1 on Linux.
linux_prepare() {
  [ "$DC_CPU" = x64 ] || fail "the Linux build is 64-bit Intel/AMD (x64) only; this machine is $DC_CPU." "Use a 64-bit Intel/AMD Linux machine, or a Mac."
  DC_ASSET="Deterministic-Coder-linux-x64.AppImage"
  linux_paths
  DC_TT5="Installing into $DC_BIN_DIR"
  DC_SYSDESC="Linux $DC_CPU"
}

# Step 5 on Linux.
linux_install_app() {
  mkdir -p "$DC_BIN_DIR" "$DC_DESK_DIR" || fail "cannot create $DC_BIN_DIR or $DC_DESK_DIR"
  DC_NEW="$DC_BIN_DIR/.dc-new.$$"
  cp "$DC_TMP/$DC_ASSET" "$DC_NEW" || { rm -f "${DC_NEW:?}"; fail "could not write into $DC_BIN_DIR"; }
  chmod 755 "$DC_NEW"
  mv -f "$DC_NEW" "$DC_BIN" || { rm -f "${DC_NEW:?}"; fail "could not replace $DC_BIN"; }
  {
    printf '[Desktop Entry]\nType=Application\nName=%s\nComment=Local-first AI coding IDE\n' "$DC_APP_NAME"
    printf 'Exec="%s" %%U\nTerminal=false\nCategories=Development;IDE;\nStartupWMClass=%s\n' "$DC_BIN" "$DC_APP_NAME"
  } >"$DC_DESK" || fail "could not write $DC_DESK"

  # An AppImage cannot report its version without being run, so say what was fetched.
  DC_WHERE="$DC_BIN"
  DC_FIRST="Installed $DC_APP_NAME (latest release)"
  case ":$PATH:" in
    *":$DC_BIN_DIR:"*) ;;
    *) note "$DC_BIN_DIR is not on your PATH; use the menu entry or the full path." ;;
  esac
  if ! { command -v ldconfig >/dev/null 2>&1 && ldconfig -p 2>/dev/null | grep -q 'libfuse\.so\.2'; }; then
    note "an AppImage needs FUSE 2 (libfuse2). If it does not start, install libfuse2 or run: $DC_BIN --appimage-extract-and-run"
  fi
}

# Step 6 on Linux.
linux_launch() {
  DC_NEXT_TEXT="Open $DC_APP_NAME from your applications menu, or run $DC_BIN."
  if [ "${DC_NO_LAUNCH:-}" = 1 ]; then
    st_end 6 skipped "not started (DC_NO_LAUNCH=1)"
  elif [ -n "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ]; then
    nohup "$DC_BIN" >/dev/null 2>&1 </dev/null &
    st_end 6 done
  else
    st_end 6 skipped "no desktop session"
    note "No desktop session detected, so it was not started."
  fi
}

linux_uninstall() {
  linux_paths
  DC_FOUND=0
  for DC_F in "$DC_BIN" "$DC_DESK"; do
    if [ -e "$DC_F" ]; then
      rm -f "${DC_F:?}" || fail "could not remove $DC_F"
      say "Removed $DC_F"
      DC_FOUND=1
    fi
  done
  if [ "$DC_FOUND" != 1 ]; then say "$DC_APP_NAME is not installed."; fi
  say "Your settings and projects were left in place."
}

# ---------------------------------------------------------------- finish

# The last thing printed on success: a box on a terminal, plain lines otherwise.
ui_finish() {
  DC_TOTAL=$(($(date +%s) - DC_T_ALL))
  DC_UPD="Future updates install from inside the app (it shows an update badge)."
  if [ "$DC_UI" != fancy ]; then
    say ""
    say "$DC_FIRST"
    say "  $DC_WHERE"
    say "Next: $DC_NEXT_TEXT"
    say "$DC_UPD"
    say "Finished in ${DC_TOTAL}s."
    return 0
  fi
  printf '\n'
  {
    ui_wrap "$DC_FIRST"
    ui_wrap "$DC_WHERE"
    printf '\n'
    ui_wrap "Next: $DC_NEXT_TEXT"
    ui_wrap "$DC_UPD"
    if [ -n "$DC_NOTES" ]; then
      printf '\n'
      printf '%s\n' "$DC_NOTES" | while IFS= read -r DC_NL; do
        if [ -n "$DC_NL" ]; then ui_wrap "Note: $DC_NL"; fi
      done
    fi
    printf '\n'
    ui_wrap "Finished in ${DC_TOTAL}s."
  } | ui_box "$DC_C_GRN" "Installed"
}

# ---------------------------------------------------------------- main

run_install() {
  st_begin 1
  command -v curl >/dev/null 2>&1 || fail "curl is required but was not found." "Install curl, then run the same command again."
  DC_TMP="$(mktemp -d "${TMPDIR:-/tmp}/dc-install.XXXXXX")" || fail "cannot create a temporary folder"
  chmod 700 "$DC_TMP"
  if [ "$DC_PLAT" = mac ]; then mac_prepare; else linux_prepare; fi
  st_end 1 done "$DC_SYSDESC"
  st_show 5

  st_begin 2
  find_release
  st_end 2 done "${DC_TAG:-latest}"
  ui_version

  st_begin 3
  fetch_asset
  st_end 3 done "$DC_DL_DETAIL"

  st_begin 4
  verify_download
  st_end 4 done "$DC_VD"

  st_begin 5
  if [ "$DC_PLAT" = mac ]; then mac_install_app; else linux_install_app; fi
  st_end 5 done

  st_begin 6
  if [ "$DC_PLAT" = mac ]; then mac_launch; else linux_launch; fi

  ui_finish
}

main() {
  DC_MODE=install
  for DC_ARG in "$@"; do
    case "$DC_ARG" in
      --help | -h)
        usage
        return 0
        ;;
      --uninstall) DC_MODE=uninstall ;;
      *)
        usage >&2
        fail "unknown option: $DC_ARG" "Run install.sh --help to see the options."
        ;;
    esac
  done

  DC_BASE="${DC_BASE_URL:-$DC_DEFAULT_BASE}"
  DC_BASE="${DC_BASE%/}"
  ui_init
  detect_os
  detect_arch

  if [ "$DC_MODE" = uninstall ]; then
    if [ "$DC_PLAT" = mac ]; then mac_uninstall; else linux_uninstall; fi
    return 0
  fi

  trap cleanup EXIT
  trap 'DC_CANCEL=1; exit 130' INT TERM HUP
  ui_start
  run_install
}

{ main "$@"; }
