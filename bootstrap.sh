#!/bin/bash
#
# One-liner bootstrap script for dotfiles setup
# Usage: curl -sSL https://raw.githubusercontent.com/jun-y23/dotfiles/main/bootstrap.sh | bash
#
set -e

DOTFILES_REPO="https://github.com/jun-y23/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

info() {
  echo "[INFO] $1"
}

error() {
  echo "[ERROR] $1" >&2
  exit 1
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
  error "This script is designed for macOS only."
fi

# Check if git is installed, install if not
if ! command -v git &> /dev/null; then
  info "Git is not installed. Installing git..."
  # Install Command Line Tools which includes git
  xcode-select --install 2>/dev/null || true
  
  # Wait for installation to complete
  info "Waiting for Command Line Tools installation to complete..."
  until command -v git &> /dev/null; do
    sleep 5
  done
  
  info "Git has been installed successfully."
fi

# Clone dotfiles repository
if [ -d "$DOTFILES_DIR" ]; then
  info "Dotfiles directory already exists. Pulling latest changes..."
  cd "$DOTFILES_DIR"
  git pull origin main
else
  info "Cloning dotfiles repository..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
  cd "$DOTFILES_DIR"
fi

# Make install script executable and run it
info "Running dotfiles installation..."
chmod +x install.sh
./install.sh

info "Bootstrap complete!"