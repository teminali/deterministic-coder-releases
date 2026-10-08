# Deterministic Coder installer for Windows (PowerShell 5.1 or newer).
#
#   irm https://raw.githubusercontent.com/teminali/deterministic-coder-releases/main/install.ps1 | iex
#
# Downloads the installer and SHA256SUMS.txt, checks the SHA-256 (stops if it does not
# match or has no entry), clears any Mark-of-the-Web flag, installs for the current user
# (no administrator rights) and starts the app. Invoke-WebRequest writes no
# Zone.Identifier stream, which is why this avoids the SmartScreen block that a browser
# download gets.
#
# UNVERIFIED: written without access to a Windows machine. Not yet run on real Windows.
#
# Test overrides (all optional, environment variables):
#   DC_BASE_URL     release download base (default: the public releases repo, "latest")
#   DC_NO_LAUNCH=1  do not start the app afterwards
#   DC_NO_INSTALL=1 download and verify only; do not run the installer
#
# Everything is inside a function that is called on the last line, so a download that is
# cut short runs nothing.

function Install-DeterministicCoder {
    $ErrorActionPreference = 'Stop'
    Set-StrictMode -Version 2.0

    $appName   = 'Deterministic Coder'
    $assetName = 'Deterministic-Coder-win-x64.exe'
    $sumsName  = 'SHA256SUMS.txt'
    $base = $env:DC_BASE_URL
    if ([string]::IsNullOrEmpty($base)) {
        $base = 'https://github.com/teminali/deterministic-coder-releases/releases/latest/download'
    }
    $base = $base.TrimEnd('/')

    # Windows PowerShell 5.1 may default to old TLS versions.
    try { [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 } catch { }
    # The progress bar makes Invoke-WebRequest very slow on 5.1.
    $ProgressPreference = 'SilentlyContinue'

    if (-not [Environment]::Is64BitOperatingSystem) {
        throw "The Windows build is 64-bit only; this is a 32-bit system."
    }

    Write-Host "$appName installer (Windows, x64)"
    Write-Host 'This will:'
    Write-Host "  1. download $assetName and $sumsName from $base"
    Write-Host '  2. check the SHA-256 and stop if it does not match'
    Write-Host '  3. install for your user account (no administrator rights)'
    if ($env:DC_NO_LAUNCH -ne '1') { Write-Host "  4. start $appName" }

    $tmp = Join-Path ([IO.Path]::GetTempPath()) ('dc-install-' + [Guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $tmp | Out-Null
    try {
        Write-Host "`n==> Downloading $assetName"
        $sumsPath  = Join-Path $tmp $sumsName
        $assetPath = Join-Path $tmp $assetName
        Invoke-WebRequest -UseBasicParsing -Uri "$base/$sumsName" -OutFile $sumsPath
        Invoke-WebRequest -UseBasicParsing -Uri "$base/$assetName" -OutFile $assetPath

        Write-Host "`n==> Checking the SHA-256"
        $want = $null
        foreach ($line in (Get-Content -LiteralPath $sumsPath)) {
            $parts = $line.Trim() -split '\s+', 2
            if ($parts.Count -eq 2) {
                $file = $parts[1].TrimStart('*')
                if ($file -eq $assetName) { $want = $parts[0].ToLowerInvariant(); break }
            }
        }
        if (-not $want) {
            Remove-Item -LiteralPath $assetPath -Force -ErrorAction SilentlyContinue
            throw "$sumsName has no entry for $assetName, so it cannot be verified. Nothing was installed."
        }
        if ($want -notmatch '^[0-9a-f]{64}$') {
            Remove-Item -LiteralPath $assetPath -Force -ErrorAction SilentlyContinue
            throw "$sumsName has a malformed entry for $assetName. Nothing was installed."
        }
        $got = (Get-FileHash -LiteralPath $assetPath -Algorithm SHA256).Hash.ToLowerInvariant()
        if ($got -ne $want) {
            Remove-Item -LiteralPath $assetPath -Force -ErrorAction SilentlyContinue
            throw "Checksum mismatch for $assetName (expected $want, got $got). The file was deleted and nothing was installed."
        }
        Write-Host "OK  $got"

        # Belt and braces: a file written by Invoke-WebRequest has no Zone.Identifier already.
        Unblock-File -LiteralPath $assetPath

        if ($env:DC_NO_INSTALL -eq '1') {
            Write-Host "Verified only (DC_NO_INSTALL=1); nothing was installed."
            return
        }

        # Ask a running copy to close; never force it.
        $running = Get-Process -Name $appName -ErrorAction SilentlyContinue
        if ($running) {
            Write-Host "Asking the running $appName to close..."
            foreach ($p in $running) { [void]$p.CloseMainWindow() }
            $deadline = (Get-Date).AddSeconds(20)
            while ((Get-Process -Name $appName -ErrorAction SilentlyContinue) -and (Get-Date) -lt $deadline) { Start-Sleep -Seconds 1 }
            if (Get-Process -Name $appName -ErrorAction SilentlyContinue) {
                throw "$appName is still running. Close it and run this again."
            }
        }

        Write-Host "`n==> Installing"
        $proc = Start-Process -FilePath $assetPath -ArgumentList '/S' -Wait -PassThru
        if ($proc.ExitCode -ne 0) { throw "The installer exited with code $($proc.ExitCode)." }

        # electron-builder NSIS, per-user: %LOCALAPPDATA%\Programs\<productName>\<productName>.exe
        $exe = Join-Path $env:LOCALAPPDATA "Programs\$appName\$appName.exe"
        if (-not (Test-Path -LiteralPath $exe)) {
            throw "The installer finished but $exe was not found."
        }
        $version = (Get-Item -LiteralPath $exe).VersionInfo.ProductVersion
        if (-not $version) { $version = 'unknown' }
        Write-Host ''
        Write-Host "Installed $appName $version"
        Write-Host "  $exe"
        if ($env:DC_NO_LAUNCH -ne '1') { Start-Process -FilePath $exe }
        Write-Host 'Future updates install from inside the app (it shows an update badge).'
    }
    finally {
        Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
    }
}

try {
    Install-DeterministicCoder
}
catch {
    Write-Host ''
    Write-Host "Install stopped: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host 'Next step: run the same command again. If it stops the same way, use the installer file instead: open https://deterministiccoder.web.app/#download and download the installer for Windows.' -ForegroundColor Red
    # Do not close the user's PowerShell window when run through "irm | iex".
    if ($MyInvocation.ScriptName) { exit 1 }
}
