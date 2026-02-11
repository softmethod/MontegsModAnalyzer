[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Clear-Host

$primary = "Cyan"
$secondary = "DarkCyan"
$success = "Green"
$warning = "Yellow"
$danger = "Red"
$muted = "Gray"
$light = "White"
$accent = "Magenta"

$Banner = @"

╔══════════════════════════════════════════════════════════════════════╗
║                                                                      ║
║  ███╗   ███╗ ██████╗ ███╗   ██╗████████╗███████╗ ██████╗ ███████╗    ║
║  ████╗ ████║██╔═══██╗████╗  ██║╚══██╔══╝██╔════╝██╔════╝ ██╔════╝    ║
║  ██╔████╔██║██║   ██║██╔██╗ ██║   ██║   █████╗  ██║  ███╗███████╗    ║
║  ██║╚██╔╝██║██║   ██║██║╚██╗██║   ██║   ██╔══╝  ██║   ██║╚════██║    ║
║  ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║   ██║   ███████╗╚██████╔╝███████║    ║
║  ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚══════╝ ╚═════╝ ╚══════╝    ║
║                                                                      ║
║   █████╗ ███╗   ██╗ █████╗ ██╗   ██╗   ██╗███████╗███████╗██████╗    ║
║  ██╔══██╗████╗  ██║██╔══██╗██║   ╚██╗ ██╔╝╚══███╔╝██╔════╝██╔══██╗   ║
║  ███████║██╔██╗ ██║███████║██║    ╚████╔╝   ███╔╝ █████╗  ██████╔╝   ║
║  ██╔══██║██║╚██╗██║██╔══██║██║     ╚██╔╝   ███╔╝  ██╔══╝  ██╔══██╗   ║
║  ██║  ██║██║ ╚████║██║  ██║███████╗ ██║   ███████╗███████╗██║  ██║   ║
║  ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝ ╚═╝   ╚══════╝╚══════╝╚═╝  ╚═╝   ║
║                                                                      ║
╚══════════════════════════════════════════════════════════════════════╝

"@

Write-Host $Banner -ForegroundColor $primary
Write-Host ""

Write-Host "  ┌─────────────────────────────────────────────────────────────┐" -ForegroundColor $primary
Write-Host "  │                   Путь к папке с модами                     │" -ForegroundColor $light
Write-Host "  └─────────────────────────────────────────────────────────────┘" -ForegroundColor $primary
Write-Host ""

$modsPath = Read-Host "   Введите путь"

if ([string]::IsNullOrWhiteSpace($modsPath)) {
    $modsPath = "$env:USERPROFILE\AppData\Roaming\.minecraft\mods"

    Write-Host "   Путь по умолчанию: " -ForegroundColor $muted -NoNewline
    Write-Host $modsPath -ForegroundColor $light
}

Write-Host ""

if (-not (Test-Path $modsPath -PathType Container)) {
    Write-Host "  ┌─────────────────────────────────────────────────────────────┐" -ForegroundColor $danger
    Write-Host "  │                       Ошибка доступа                        │" -ForegroundColor $danger
    Write-Host "  └─────────────────────────────────────────────────────────────┘" -ForegroundColor $danger
    Write-Host "   Путь недоступен: " -ForegroundColor $light -NoNewline
    Write-Host $modsPath -ForegroundColor $muted
    Write-Host ""
    Write-Host "  Нажмите любую клавишу для выхода..." -ForegroundColor $muted
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host "  ┌─────────────────────────────────────────────────────────────┐" -ForegroundColor $primary
Write-Host "  │                        Сканирование                         │" -ForegroundColor $light
Write-Host "  └─────────────────────────────────────────────────────────────┘" -ForegroundColor $primary
Write-Host "   Путь: " -ForegroundColor $muted -NoNewline
Write-Host $modsPath -ForegroundColor $primary
Write-Host ""

$suspiciousPatterns = @(
    "AimAssist","AnchorTweaks","AutoAnchor","AutoCrystal","AutoDoubleHand",
    "AutoHitCrystal","AutoPot","AutoTotem","AutoArmor","InventoryTotem",
    "Hitboxes","HitBox","JumpReset","LegitTotem","PingSpoof","SelfDestruct",
    "ShieldBreaker","TriggerBot","Velocity","AxeSpam","WebMacro",
    "FastPlace","WalskyOptimizer","WalksyOptimizer","walsky.optimizer",
    "WalksyCrystalOptimizerMod","Donut","Replace Mod","ShieldDisabler",
    "SilentAim","Totem Hit","Wtap","FakeLag","Friends","NoDelay",
    "BlockESP","Krypton","krypton","dev.krypton","Virgin","AntiMissClick",
    "LagReach","PopSwitch","SprintReset","ChestSteal","AntiBot","ElytraSwap",
    "FastXP","FastExp","Refill","NoJumpDelay","AirAnchor","jnativehook",
    "FakeInv","HoverTotem","AutoClicker","AutoFirework","Freecam",
    "PackSpoof","AntiKB","Impulsion","CameraExploit","FreeCam",
    "AuthBypass","Asteria","Prestige","AutoEat","AutoMine","FastSwap",
    "FastBow","AutoTPA","BaseFinder","AxisAlignedBB","mod_d","Grim",
    "grim","modules.impl.World","modules.impl.Other","modules.impl.Render",
    "modules.impl.Visual","modules.impl.Movement","modules.impl.Combat",
    "modules.impl","imgui","imgui.gl3","imgui.glfw","BowAim","Criticals",
    "Flight","Fakenick","FakeItem","invsee","ItemExploit","Hellion",
    "hellion","KeyboardMixin","ClientPlayerInteractionManagerMixin",
    "LicenseCheckMixin","ClientPlayerInteractionManagerAccessor",
    "ClientPlayerEntityMixim","obfuscatedAuth","phantom-refmap.json",
    "xyz.greaj","Chams","mcmod.info",
    "じ.class","ふ.class","ぶ.class","ぷ.class","た.class","ね.class",
    "そ.class","な.class","ど.class","ぐ.class","ず.class","で.class",
    "つ.class","べ.class","せ.class","と.class","み.class","び.class",
    "す.class","の.class", "GlowESP", "GlowEsp", "TriggerBot"
)

function Get-FileSHA1 { param([string]$Path) return (Get-FileHash -Path $Path -Algorithm SHA1).Hash }

function Get-DownloadSource {
    param([string]$Path)
    try {
        $zoneData = Get-Content $Path -Stream Zone.Identifier -ErrorAction SilentlyContinue
        if ($zoneData -match "HostUrl=(.+)") {
            $url = $matches[1].Trim()
            if ($url -match "mediafire\.com") { return "MediaFire" }
            elseif ($url -match "discord\.com|discordapp\.com|cdn\.discordapp\.com") { return "Discord" }
            elseif ($url -match "dropbox\.com") { return "Dropbox" }
            elseif ($url -match "drive\.google\.com") { return "Google Drive" }
            elseif ($url -match "yadi\.sk") { return "Yandex Disk" }
            elseif ($url -match "mega\.nz|mega\.co\.nz") { return "MEGA" }
            elseif ($url -match "github\.com") { return "GitHub" }
            elseif ($url -match "modrinth\.com") { return "Modrinth" }
            elseif ($url -match "celka\.su") { return "Celestial" }
            elseif ($url -match "nursultan\.fun") { return "Nursultan" }
            elseif ($url -match "curseforge\.com") { return "CurseForge" }
            elseif ($url -match "anydesk\.com") { return "AnyDesk" }
            elseif ($url -match "doomsdayclient\.com") { return "DoomsdayClient" }
            else { if ($url -match "https?://(?:www\.)?([^/]+)") { return $matches[1] }; return $url }
        }
    } catch {}
    return $null
}

function Query-Modrinth {
    param([string]$Hash)
    try {
        $versionInfo = Invoke-RestMethod -Uri "https://api.modrinth.com/v2/version_file/$Hash" -Method Get -UseBasicParsing -ErrorAction Stop
        if ($versionInfo.project_id) {
            $projectInfo = Invoke-RestMethod -Uri "https://api.modrinth.com/v2/project/$($versionInfo.project_id)" -Method Get -UseBasicParsing -ErrorAction Stop
            return @{ Name = $projectInfo.title; Slug = $projectInfo.slug }
        }
    } catch {}
    return @{ Name = ""; Slug = "" }
}

function Query-Megabase {
    param([string]$Hash)
    try {
        $result = Invoke-RestMethod -Uri "https://megabase.vercel.app/api/query?hash=$Hash" -Method Get -UseBasicParsing -ErrorAction Stop
        if (-not $result.error) { return $result.data }
    } catch {}
    return $null
}

try { $jarFiles = Get-ChildItem -Path $modsPath -Filter *.jar -ErrorAction Stop }
catch {
    Write-Host "  ┌─────────────────────────────────────────────────────────────┐" -ForegroundColor $danger
    Write-Host "  │                    Ошибка сканирования                      │" -ForegroundColor $danger
    Write-Host "  └─────────────────────────────────────────────────────────────┘" -ForegroundColor $danger
    Write-Host ""
    Write-Host "   Нажмите любую клавишу для выхода..." -ForegroundColor $muted
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

if ($jarFiles.Count -eq 0) {
    Write-Host "  ┌─────────────────────────────────────────────────────────────┐" -ForegroundColor $warning
    Write-Host "  │                     Файлы не найдены                        │" -ForegroundColor $warning
    Write-Host "  └─────────────────────────────────────────────────────────────┘" -ForegroundColor $warning
    Write-Host ""
    Write-Host "   Нажмите любую клавишу для выхода..." -ForegroundColor $muted
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 0
}
Write-Host ""
Write-Host "   Найдено файлов: " -ForegroundColor $muted -NoNewline
Write-Host $jarFiles.Count -ForegroundColor $primary

Write-Host ""

$verifiedMods = @()
$unknownMods = @()
$suspiciousMods = @()
$totalFiles = $jarFiles.Count
$idx = 0

Write-Host "  ┌─────────────────────────────────────────────────────────────┐" -ForegroundColor $primary
Write-Host "  │                      Проверка хешей                         │" -ForegroundColor $light
Write-Host "  └─────────────────────────────────────────────────────────────┘" -ForegroundColor $primary
Write-Host ""

foreach ($jar in $jarFiles) {
    $idx++
    $percent = [math]::Round(($idx / $totalFiles) * 100)
    
    Write-Host "   [" -NoNewline
    Write-Host ("█" * [math]::Min($percent/2, 50)).PadRight(50, "░") -ForegroundColor $primary -NoNewline
    Write-Host "] " -NoNewline
    Write-Host "$percent% " -ForegroundColor $light -NoNewline
    Write-Host "($idx/$totalFiles)" -ForegroundColor $muted
    
    $hash = Get-FileSHA1 -Path $jar.FullName
    if ($hash) {
        $modrinthData = Query-Modrinth -Hash $hash
        if ($modrinthData.Slug) {
            $verifiedMods += [PSCustomObject]@{ 
                ModName = $modrinthData.Name
                FileName = $jar.Name
                Slug = $modrinthData.Slug
            }
            continue
        }
        $megabaseData = Query-Megabase -Hash $hash
        if ($megabaseData.name) {
            $verifiedMods += [PSCustomObject]@{ 
                ModName = $megabaseData.Name
                FileName = $jar.Name
                Slug = ""
            }
            continue
        }
    }
    $src = Get-DownloadSource $jar.FullName
    $unknownMods += [PSCustomObject]@{ 
        FileName = $jar.Name
        FilePath = $jar.FullName
        DownloadSource = $src
    }
}

Write-Host ""


if ($unknownMods.Count -gt 0) {
    Write-Host "  ┌─────────────────────────────────────────────────────────────┐" -ForegroundColor $primary
    Write-Host "  │                      Глубокий анализ                        │" -ForegroundColor $light
    Write-Host "  └─────────────────────────────────────────────────────────────┘" -ForegroundColor $primary
    Write-Host "   Проверка файлов: " -ForegroundColor $muted -NoNewline
    Write-Host $unknownMods.Count -ForegroundColor $primary

    Write-Host ""
    
    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        $pattern = '(' + ($suspiciousPatterns -join '|') + ')'
        $regex = [regex]::new($pattern, [System.Text.RegularExpressions.RegexOptions]::Compiled)
        
        foreach ($mod in $unknownMods) {
            $detected = [System.Collections.Generic.HashSet[string]]::new()
            try {
                $archive = [System.IO.Compression.ZipFile]::OpenRead($mod.FilePath)
                foreach ($entry in $archive.Entries) {
                    $matches = $regex.Matches($entry.FullName)
                    foreach ($m in $matches) { [void]$detected.Add($m.Value) }
                    if ($entry.FullName -match '\.(class|json)$' -or $entry.FullName -match 'MANIFEST\.MF') {
                        try {
                            $stream = $entry.Open()
                            $reader = New-Object System.IO.StreamReader($stream)
                            $content = $reader.ReadToEnd()
                            $reader.Close(); $stream.Close()
                            $contentMatches = $regex.Matches($content)
                            foreach ($m in $contentMatches) { [void]$detected.Add($m.Value) }
                        } catch {}
                    }
                }
                $archive.Dispose()
                if ($detected.Count -gt 0) {
                    $suspiciousMods += [PSCustomObject]@{ 
                        FileName = $mod.FileName
                        DetectedPatterns = $detected
                        DownloadSource = $mod.DownloadSource
                    }
                }
            } catch {}
        }
    } catch {}
}

Write-Host "  ═══════════════════════════════════════════════════════════════" -ForegroundColor $secondary
Write-Host ""

if ($verifiedMods.Count -gt 0) {
    Write-Host "  ┌─────────────────────────────────────────────────────────────┐" -ForegroundColor $success
    Write-Host "  │                     Проверенные моды                        │" -ForegroundColor $success
    Write-Host "  └─────────────────────────────────────────────────────────────┘" -ForegroundColor $success
    
    foreach ($mod in $verifiedMods) {
        Write-Host "   Файл: " -ForegroundColor $muted -NoNewline
        Write-Host $mod.FileName -ForegroundColor $light
        
        if ($mod.Slug) {
            Write-Host "   Ссылка: " -ForegroundColor $muted -NoNewline
            Write-Host "https://modrinth.com/mod/$($mod.Slug)" -ForegroundColor $accent
        }
        Write-Host ""
    }
    
    Write-Host "   Всего: " -ForegroundColor $muted -NoNewline
    Write-Host $verifiedMods.Count -ForegroundColor $success -NoNewline
    Write-Host " модов" -ForegroundColor $muted
    Write-Host ""
}

if ($unknownMods.Count -gt 0) {
    Write-Host "  ┌─────────────────────────────────────────────────────────────┐" -ForegroundColor $warning
    Write-Host "  │                     Неизвестные моды                        │" -ForegroundColor $warning
    Write-Host "  └─────────────────────────────────────────────────────────────┘" -ForegroundColor $warning
    
    foreach ($mod in $unknownMods) {
        $shortName = if ($mod.FileName.Length -gt 40) { $mod.FileName.Substring(0, 37) + "..." } else { $mod.FileName }
        Write-Host "   Файл: " -ForegroundColor $muted -NoNewline
        Write-Host $shortName -ForegroundColor $light
        
        if ($mod.DownloadSource) {
            Write-Host "   Источник: " -ForegroundColor $muted -NoNewline
            Write-Host $mod.DownloadSource -ForegroundColor $warning
        } else {
            Write-Host "   Источник: " -ForegroundColor $muted -NoNewline
            Write-Host "Неизвестно" -ForegroundColor $warning
        }
        Write-Host ""
    }
    
    Write-Host "   Всего: " -ForegroundColor $muted -NoNewline
    Write-Host $unknownMods.Count -ForegroundColor $warning -NoNewline
    Write-Host " модов" -ForegroundColor $muted
    Write-Host ""
}

if ($suspiciousMods.Count -gt 0) {
    Write-Host "  ┌─────────────────────────────────────────────────────────────┐" -ForegroundColor $danger
    Write-Host "  │                     Подозрительные моды                     │" -ForegroundColor $danger
    Write-Host "  └─────────────────────────────────────────────────────────────┘" -ForegroundColor $danger
    
    foreach ($mod in $suspiciousMods) {
        Write-Host "   Файл: " -ForegroundColor $muted -NoNewline
        Write-Host $mod.FileName -ForegroundColor $light
        
        if ($mod.DownloadSource) {
            Write-Host "   Источник: " -ForegroundColor $muted -NoNewline
            Write-Host $mod.DownloadSource -ForegroundColor $danger
        }
        
        $patterns = $mod.DetectedPatterns | Sort-Object
        if ($patterns.Count -gt 0) {
            Write-Host "   Обнаружено: " -ForegroundColor $muted -NoNewline
            Write-Host $patterns.Count -ForegroundColor $danger -NoNewline
            Write-Host " паттернов" -ForegroundColor $muted
            
            foreach ($p in $patterns) {
                Write-Host "     - " -ForegroundColor $danger -NoNewline
                Write-Host $p -ForegroundColor $light
            }
        }
        Write-Host ""
    }
    
    Write-Host "   Всего: " -ForegroundColor $muted -NoNewline
    Write-Host $suspiciousMods.Count -ForegroundColor $danger -NoNewline
    Write-Host " модов" -ForegroundColor $muted
    Write-Host ""
}

Write-Host "  Нажмите любую клавишу для выхода..." -ForegroundColor $muted
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")



