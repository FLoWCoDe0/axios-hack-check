# ============================================================================ 
# FLoWCoDe
# r/flowcode91
# ============================================================================ 
# Axios Supply Chain Attack — Detection Script (Windows)
# فحص ثغرة Axios
# ============================================================================
# Run in PowerShell: .\check.ps1
# ============================================================================
# Best in Windows Terminal / PowerShell 7+
# This simulates your reference by coloring EACH LETTER separately.

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

function Write-Rgb {
    param(
        [string]$Text,
        [int[]]$Rgb
    )

    $esc = [char]27
    [Console]::Write("$esc[38;2;$($Rgb[0]);$($Rgb[1]);$($Rgb[2])m$Text$esc[0m")
}

function Show-FlowCode {
    $gap = ''

    $letters = @(
        @{
            Color = @(1,237,245)   # F
            Rows  = @(
                ' ______ '
                '|  ____|'
                '| |__   '
                '|  __|  '
                '| |     '
                '|_|     '
            )
        }
        @{
            Color = @(1,239,251)   # l
            Rows  = @(
                ' _ '
                '| |'
                '| |'
                '| |'
                '| |'
                '|_|'
            )
        }
        @{
            Color = @(3,199,224)   # o
            Rows  = @(
                '       '
                '       '
                '  ___  '
                ' / _ \ '
                '| (_) |'
                ' \___/ '

            )
        }
        @{
            Color = @(25,104,243)  # w
            Rows  = @(
                '           '
                '           '
                '__      __ '
                '\ \ /\ / / '
                ' \ V  V /  '
                '  \_/\_/   '

            )
        }
        @{
            Color = @(71,86,238)   # C
            Rows  = @(
                '  _____ '
                ' / ____|'
                '| |     '
                '| |     '
                '| |____ '
                ' \_____|'
            )
        }
        @{
            Color = @(108,35,210)  # o
            Rows  = @(
                '       '
                '       '
                '  ___  '
                ' / _ \ '
                '| (_) |'
                ' \___/ '

            )
        }
        @{
            Color = @(184,76,220)  # d
            Rows  = @(
                '     _  '
                '    | | '
                '  __| | '
                ' / _` | '
                '| (_| | '
                ' \__,_| '
            )
        }
        @{
            Color = @(208,101,229) # e
            Rows  = @(
                '       '
                '       '
                '  ___  '
                ' / _ \ '
                '|  __/ '
                ' \___| '

            )
        }
    )

    Write-Host ''

    for ($row = 0; $row -lt 6; $row++) {
        foreach ($letter in $letters) {
            Write-Rgb -Text $letter.Rows[$row] -Rgb $letter.Color
            [Console]::Write($gap)
        }
        [Console]::WriteLine()
    }

    Write-Host ''
}

Show-FlowCode
Write-Host "============================================" -ForegroundColor DarkCyan
Write-Host " Axios - npm ةرغث صحف و فشك" 			  -ForegroundColor DarkYellow
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$found = $false

# --- Check 1: Installed axios version ---
Write-Host "[1/5] ...ةتبثملا axios ةخسن صحف" -ForegroundColor Yellow
$axiosCheck = npm list axios 2>$null | Select-String "1\.14\.1|0\.30\.4"
if ($axiosCheck) {
    Write-Host "  ةركهم كتخسن !!!هبتنا ،كليو اي" -ForegroundColor Red
    Write-Host "  $axiosCheck"
    $found = $true
} else {
    Write-Host " .ةميلس كتخسن ،ةبيط كرومأ" -ForegroundColor Green
}

# --- Check 2: Lockfile ---
Write-Host ""
Write-Host "[2/5] ... lockfile صحف" -ForegroundColor Yellow
if (Test-Path "package-lock.json") {
    $lockHit = Select-String -Path "package-lock.json" -Pattern "1\.14\.1|0\.30\.4|plain-crypto-js"
    if ($lockHit) {
        Write-Host "  lockfile يف ةركهم ةراشإ :ررضتم !!" -ForegroundColor Red
        $found = $true
    } else {
        Write-Host "  فيظن lockfile :مامت" -ForegroundColor Green
    }
} else {
    Write-Host "  دوجوم وم package-lock.json :يطخت"
}

# --- Check 3: Malicious dependency ---
Write-Host ""
Write-Host "[3/5] ... ةثيبخ تاجكب نع ثحبلا" -ForegroundColor Yellow
if (Test-Path "node_modules\plain-crypto-js") {
    Write-Host "  دوجوم node_modules\plain-crypto-js :ررضتم !!" -ForegroundColor Red
    $found = $true
} else {
    Write-Host "  node_modules يف دوجوم ريغ plain-crypto-js :مامت" -ForegroundColor Green
    Write-Host "  100% تملس ينعي وم هبايغ - هسفن فذحي نكمم ثيبخلا جمانربلا :ةظوحلم"
}

# --- Check 4: RAT artifacts ---
Write-Host ""
Write-Host "[4/5] ...RAT وا ناجورت  نع صحفلا" -ForegroundColor Yellow

# Windows RAT: wt.exe in ProgramData
$wtPath = "$env:PROGRAMDATA\wt.exe"
if (Test-Path $wtPath) {
    Write-Host "  $wtPath كدنع Windows RAT هاعم مهافت :ريطخ !!" -ForegroundColor Red
    Get-Item $wtPath | Format-List Name, Length, LastWriteTime
    $found = $true
} else {
    Write-Host "  ProgramData يف دوجوم ريغ wt.exe :مامت" -ForegroundColor Green
}

# Temp files
$vbsPath = "$env:TEMP\6202033.vbs"
$ps1Path = "$env:TEMP\6202033.ps1"
if ((Test-Path $vbsPath) -or (Test-Path $ps1Path)) {
    Write-Host "  ةتقؤم payload تافلم ىلع انرثع :ريذحت !!" -ForegroundColor Red
    $found = $true
} else {
    Write-Host "  ةتقؤم payload تافلم دجوت ال :مامت" -ForegroundColor Green
}

# --- Check 5: C2 connections ---
Write-Host ""
Write-Host "[5/5] ...C2 تالاصتا نع صحفلا" -ForegroundColor Yellow
$c2Check = netstat -an | Select-String "142.11.206.73"
if ($c2Check) {
    Write-Host "  )142.11.206.73( C2 عم طشن لاصتا :ريطخ !!" -ForegroundColor Red
    Write-Host "  $c2Check"
    $found = $true
} else {
    Write-Host "  C2 عم ةطشن تالاصتا دجوت ال :مامت" -ForegroundColor Green
}

# --- Summary ---
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
if ($found) {
	Write-Host "  فسألل بيط وم عضولا !!" -ForegroundColor Red
	Write-Host ""
    Write-Host "  1. ةميلس ةخسن ىلا ريغ يش لوا" -ForegroundColor DarkCyan && Write-Host "     npm install axios@1.14.0 --save-exact" -ForegroundColor DarkGreen
	Write-Host ""
    Write-Host "  2. تبث عجراو node_module فذحا  " -ForegroundColor DarkCyan && Write-Host "     rm -r node_modules; npm ci" -ForegroundColor DarkGreen
	Write-Host ""
    Write-Host "  3. API حيتافمو تادرووسابلا لك ريّغ" -ForegroundColor DarkCyan
	Write-Host ""
    Write-Host "  4. 142.11.206.73 و sfrclak.com رظحا" -ForegroundColor DarkCyan
	Write-Host ""
    Write-Host "  5. ميلسلا يف نوكت ناشع هلك زاهجلل لماك تامروف :RAT تلصح اذإ" -ForegroundColor DarkRed
} else {
    Write-Host "  ميلس عضولا" -ForegroundColor Green
    Write-Host "  ريخ ىلع تدع ،هللدمحلا" -ForegroundColor Green
    Write-Host ""
    Write-Host "  npm install axios@1.14.0 --save-exact :ايئاقو"
    Write-Host "  npm config set min-release-age 3 :طبضا"
}
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan