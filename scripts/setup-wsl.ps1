# WSL 2 Setup Script
Write-Host "🐧 Setting up WSL 2..." -ForegroundColor Cyan

# Install WSL with Ubuntu
wsl --install -d Ubuntu

Write-Host "Please restart your computer and then run the following commands in WSL:" -ForegroundColor Yellow
Write-Host "sudo apt update && sudo apt -y upgrade" -ForegroundColor Gray
Write-Host "sudo apt install -y build-essential curl git libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev" -ForegroundColor Gray
Write-Host "curl https://pyenv.run | bash" -ForegroundColor Gray
