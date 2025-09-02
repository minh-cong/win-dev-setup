#!/bin/bash
# WSL Ubuntu Development Environment Setup

echo "🐧 Setting up Ubuntu WSL development environment..."

# Update system
sudo apt update && sudo apt -y upgrade

# Install essential build tools
sudo apt install -y build-essential curl git libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev libffi-dev libncurses5-dev \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev

# Install pyenv for Python version management
echo "📦 Installing pyenv..."
curl https://pyenv.run | bash

# Add pyenv to shell
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

# Install Node.js via NodeSource
echo "📦 Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Yarn
npm install -g yarn pnpm

# Install Ruby via rbenv
echo "💎 Installing rbenv for Ruby..."
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

echo "✅ WSL setup complete! Please restart your shell or run 'source ~/.bashrc'"
