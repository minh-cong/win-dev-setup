# windows dev setup

> Comprehensive Windows 11 development environment setup guide and scripts. Inspired by Nicolas Hery's `mac-dev-setup`, optimized for Windows with **winget**, **PowerShell 7**, **Windows Terminal**, **WSL 2**, **Volta** (Node), **pyenv-win** (Python), and **Docker Desktop**.

## quick start

1. **clone this repository:**
   ```powershell
   git clone https://github.com/minh-cong/win-dev-setup.git
   cd win-dev-setup
   ```

2. **run the setup script:**
   ```powershell
   .\windows-dev-setup.ps1
   ```

3. **follow the detailed guide:** See [windows_dev_setup_based_on_mac_dev_setup.md](./windows_dev_setup_based_on_mac_dev_setup.md)

## what's included

### core tools
- **Package Manager:** winget
- **Terminal:** Windows Terminal + PowerShell 7 + Oh-My-Posh
- **Version Control:** Git + GitHub CLI
- **Editor:** VS Code with essential extensions
- **Containers:** Docker Desktop with WSL 2 backend

### development runtimes
- **JavaScript/TypeScript:** Volta (Node.js version manager)
- **Python:** pyenv-win or WSL-based pyenv
- **Ruby:** Ruby Installer or WSL-based rbenv

### development databases
- PostgreSQL
- Redis
- Elasticsearch
- MongoDB

## repository structure

```
win-dev-setup/
├── README.md                                    # This file
├── windows_dev_setup_based_on_mac_dev_setup.md # Detailed setup guide
├── windows-dev-setup.ps1                       # Main setup script
├── winget-packages.json                         # Package definitions
├── dev-dbs/
│   └── docker-compose.yml                      # Development databases
├── vscode/
│   ├── settings.json                           # VS Code settings
│   └── extensions.json                         # Recommended extensions
├── scripts/
│   ├── install-fonts.ps1                      # Install Nerd Fonts
│   └── setup-wsl.ps1                          # WSL 2 setup
└── wsl-setup.sh                               # Ubuntu WSL configuration
```

## manual setup steps

### 1. system updates
```powershell
# Windows Update: Settings → Windows Update → Check for updates
# Microsoft Store → Library → Get updates
```

### 2. package installation
```powershell
winget source update
winget import -i .\winget-packages.json --accept-source-agreements --accept-package-agreements --silent
```

### 3. terminal configuration
- Install Nerd Fonts: `.\scripts\install-fonts.ps1`
- Configure Windows Terminal with Cascadia Code NF
- Set PowerShell 7 as default profile

### 4. git configuration
```powershell
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
git config --global credential.helper manager
```

### 5. ssh key setup
```powershell
ssh-keygen -t ed25519 -C "you@example.com"
Get-Content $env:USERPROFILE\.ssh\id_ed25519.pub | Set-Clipboard
# Add the key to GitHub/GitLab
```

### 6. wsl 2 setup (recommmended)
```powershell
.\scripts\setup-wsl.ps1
# After restart, run in WSL:
chmod +x wsl-setup.sh
./wsl-setup.sh
```

### 7. development databases
```powershell
cd dev-dbs
docker compose up -d
```

## vs code configs

Copy the provided VS Code settings:
```powershell
# Create VS Code user settings directory if it doesn't exist
$vscodeDir = "$env:APPDATA\Code\User"
if (!(Test-Path $vscodeDir)) { New-Item -ItemType Directory -Path $vscodeDir -Force }

# Copy settings
Copy-Item "vscode\settings.json" "$vscodeDir\settings.json"
```

Install recommended extensions:
```powershell
Get-Content "vscode\extensions.json" | ConvertFrom-Json | Select-Object -ExpandProperty recommendations | ForEach-Object { code --install-extension $_ }
```

## python setup options

### Option 1: Windows Native (pyenv-win)
```powershell
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"
& "./install-pyenv-win.ps1"
# Restart PowerShell
pyenv install 3.12.5
pyenv global 3.12.5
```

### Option 2: WSL (Recommended)
```bash
# In WSL Ubuntu
pyenv install 3.12.5
pyenv global 3.12.5
```

## 📦 Node.js Setup with Volta
```powershell
volta install node@lts
volta install npm yarn pnpm
```

## 🗃 Database Quick Start
```powershell
# Start all development databases
cd dev-dbs
docker compose up -d

# Connection details:
# PostgreSQL: localhost:5432, user: dev_user, password: dev_password
# Redis: localhost:6379
# Elasticsearch: localhost:9200
# MongoDB: localhost:27017, user: dev_user, password: dev_password
```

## troubleshooting

### winget import fails
- Ensure you have the latest App Installer from Microsoft Store
- Run `winget source update` before importing
- Check package identifiers are correct

### Terminal doesn't show icons/glyphs
- Install Nerd Fonts: `.\scripts\install-fonts.ps1`
- Set font to "Cascadia Code NF" in Windows Terminal settings
- Restart Windows Terminal

### Docker not working
- Ensure WSL 2 is installed and set as default
- Enable WSL 2 backend in Docker Desktop settings
- Enable integration with your Ubuntu distribution

### PowerShell execution policy
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
```

## additional Resources

- [Windows Terminal Documentation](https://docs.microsoft.com/en-us/windows/terminal/)
- [WSL 2 Documentation](https://docs.microsoft.com/en-us/windows/wsl/)
- [Oh My Posh Themes](https://ohmyposh.dev/docs/themes)
- [Volta Documentation](https://volta.sh/)
- [pyenv-win](https://github.com/pyenv-win/pyenv-win)

## contributing

Feel free to submit issues and enhancement requests! This setup is meant to be a solid foundation that can be customized for different development workflows.

## license

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## acknowledgments

- Inspired by [mac-dev-setup](https://github.com/nicolashery/mac-dev-setup) by Nicolas Hery
- Windows Terminal and PowerShell teams at Microsoft
- The amazing open-source community for all the tools and packages
