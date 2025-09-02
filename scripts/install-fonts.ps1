# Install Nerd Fonts for better terminal experience
Write-Host "🔤 Installing Nerd Fonts..." -ForegroundColor Cyan

$fonts = @(
    "CascadiaCode",
    "FiraCode", 
    "JetBrainsMono",
    "Hack"
)

foreach ($font in $fonts) {
    Write-Host "Installing $font..." -ForegroundColor Yellow
    oh-my-posh font install $font
}

Write-Host "✅ Fonts installed! Restart terminal to use them." -ForegroundColor Green
