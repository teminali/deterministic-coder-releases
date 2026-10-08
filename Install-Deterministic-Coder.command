#!/bin/bash
# Deterministic Coder installer for macOS, as a file you double-click.
#
# It holds no install logic of its own. It downloads install.sh from the address below with curl, checks that
# what it got is a non-empty shell script, runs it in this Terminal window (so you see the same steps and
# progress bar as the one-line command), and waits for a key before the window closes. Every check of the
# release (SHA-256, signature) is done by install.sh. See install/README.md.
#
# DC_TEST_INSTALL_SH_URL exists only so the automated tests can point this file at a local fake server.

DC_INSTALL_SH_URL="${DC_TEST_INSTALL_SH_URL:-https://raw.githubusercontent.com/teminali/deterministic-coder-releases/main/install.sh}"

set -u

TMP_DIR=""
cleanup() {
  if [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ]; then rm -rf "${TMP_DIR:?}"; fi
}
trap cleanup EXIT
trap 'exit 130' INT TERM HUP

# Wait for a key so the window does not vanish before the result can be read (only when a person is there).
finish() {
  if [ -t 0 ]; then
    printf '\nPress any key to close this window. '
    read -r -n 1 -s _ || true
    printf '\n'
  fi
  exit "$1"
}

if [ -t 1 ]; then printf '\033]0;Deterministic Coder installer\007'; fi
printf 'Deterministic Coder installer\n\n'
printf 'This window downloads the installer script from GitHub and runs it.\n'
printf 'Source: %s\n\n' "$DC_INSTALL_SH_URL"

if ! command -v curl >/dev/null 2>&1; then
  printf 'Install stopped: curl was not found on this Mac.\n'
  printf 'Next step: update macOS, or download the app from https://github.com/teminali/deterministic-coder-releases/releases/latest\n'
  finish 1
fi

TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/dc-command.XXXXXX")" || { printf 'Install stopped: cannot create a temporary folder.\n'; finish 1; }
SCRIPT="$TMP_DIR/install.sh"

RC=0
curl -fsSL --retry 2 --connect-timeout 20 -o "$SCRIPT" "$DC_INSTALL_SH_URL" </dev/null 2>"$TMP_DIR/curl.err" || RC=$?
if [ "$RC" -ne 0 ]; then
  case "$RC" in
    6 | 7 | 28 | 35 | 52 | 55 | 56)
      printf 'Install stopped: this Mac looks offline, or GitHub cannot be reached right now.\n'
      printf 'Next step: connect to the internet, then double-click this file again.\n'
      ;;
    *)
      printf 'Install stopped: the installer script could not be downloaded (%s).\n' "$(tr '\n' ' ' <"$TMP_DIR/curl.err")"
      printf 'Next step: try again in a few minutes. If it keeps failing, download the app from https://github.com/teminali/deterministic-coder-releases/releases/latest\n'
      ;;
  esac
  finish 1
fi

# Only a non-empty shell script is ever run. An error page, an empty file or another kind of script is refused.
if [ ! -s "$SCRIPT" ] || ! head -n 1 "$SCRIPT" | grep -Eq '^#!(/usr/bin/env )?(/bin/|/usr/bin/)?(ba|da)?sh( |$)'; then
  printf 'Install stopped: what was downloaded is not the installer script (it is empty or does not start with a shell line).\n'
  printf 'Nothing was run. Next step: try again in a few minutes. If it keeps happening, download the app from https://github.com/teminali/deterministic-coder-releases/releases/latest\n'
  finish 1
fi

RC=0
sh "$SCRIPT" || RC=$?
if [ "$RC" -ne 0 ] && [ "$RC" -ne 130 ]; then
  printf '\nThe installer stopped (exit code %s). The message above says why and what to do next.\n' "$RC"
fi
finish "$RC"
