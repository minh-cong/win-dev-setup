# Windows Dev Setup Script
# Based on mac-dev-setup by Nicolas Hery, optimized for Windows 11
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

Write-Host "🚀 Starting Windows Dev Setup..." -ForegroundColor Cyan

# 1) Create winget import file
$wingetJson = Get-Content "winget-packages.json" -Raw
if (-not $wingetJson) {
    Write-Host "❌ winget-packages.json not found. Please ensure it exists in the current directory." -ForegroundColor Red
    exit 1
}

Write-Host "📦 Updating winget sources..." -ForegroundColor Yellow
winget source update

Write-Host "📥 Installing packages via winget..." -ForegroundColor Yellow
winget import -i "winget-packages.json" --accept-source-agreements --accept-package-agreements --silent

Write-Host "⬆️ Upgrading existing packages..." -ForegroundColor Yellow
winget upgrade --all --silent --accept-source-agreements --accept-package-agreements

# 2) PowerShell profile setup
Write-Host "🔧 Setting up PowerShell profile..." -ForegroundColor Yellow
if (!(Test-Path -Path $PROFILE)) { 
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null 
}

Install-Module PSReadLine -Scope CurrentUser -Force -AllowClobber
Install-Module posh-git -Scope CurrentUser -Force -AllowClobber

$profileContent = @"
# ===== Windows Dev Setup PowerShell Profile =====
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Import-Module posh-git

# Oh My Posh theme
oh-my-posh init pwsh --config "`$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression

# Useful aliases
function ll { Get-ChildItem -Force }
function la { Get-ChildItem -Force -Hidden }
Set-Alias g git
Set-Alias c code
Set-Alias d docker
Set-Alias dc docker-compose

# Quick navigation
function dev { Set-Location "`$env:USERPROFILE\Dev" }
function repos { Set-Location "`$env:USERPROFILE\Dev\repos" }

Write-Host "✅ Windows Dev Environment Loaded!" -ForegroundColor Green
"@

Set-Content $PROFILE $profileContent

# 3) Create development directories
Write-Host "📁 Creating development directories..." -ForegroundColor Yellow
$devDirs = @(
    "$env:USERPROFILE\Dev",
    "$env:USERPROFILE\Dev\repos",
    "$env:USERPROFILE\Dev\tools",
    "$env:USERPROFILE\Dev\scripts"
)

foreach ($dir in $devDirs) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}

# 4) Git global configuration
Write-Host "⚙️ Please configure Git with your details:" -ForegroundColor Yellow
Write-Host "Run the following commands with your information:"
Write-Host "git config --global user.name 'Your Name'" -ForegroundColor Gray
Write-Host "git config --global user.email 'you@example.com'" -ForegroundColor Gray

Write-Host ""
Write-Host "✅ Windows Dev Setup Complete!" -ForegroundColor Green
Write-Host "🔄 Please restart Windows Terminal to load new fonts and themes." -ForegroundColor Cyan
Write-Host "📚 Check the README.md for next steps and configuration details." -ForegroundColor Cyan
