#!/bin/bash
#
# dotfiles setup script for macOS with Homebrew, mise, and stow.
#
set -e

# --- Configuration ---
# List of packages to stow. Add your package directory names here.
# Example: STOW_PACKAGES="zsh git nvim"
STOW_PACKAGES="zsh git nvim"

# --- Helper Functions ---
info() {
  echo "[INFO] $1"
}

error() {
  echo "[ERROR] $1" >&2
  exit 1
}

# --- Check if running on macOS ---
if [[ "$OSTYPE" != "darwin"* ]]; then
  error "This script is designed for macOS only."
fi

# --- Check Homebrew ---
if ! command -v brew &> /dev/null; then
  info "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to PATH for Apple Silicon Macs
  if [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  info "Homebrew is already installed."
fi

# --- Update Homebrew ---
info "Updating Homebrew..."
brew update

# --- Install packages from Brewfile ---
if [ -f "Brewfile" ]; then
  info "Installing packages from Brewfile..."
  brew bundle --file=Brewfile
else
  info "No Brewfile found. Installing basic packages..."
  brew install mise stow
fi

# --- Apply macOS settings ---
if [ -f "macos_setup.sh" ]; then
  info "Applying macOS settings..."
  chmod +x macos_setup.sh
  ./macos_setup.sh
else
  info "No macOS setup script found. Skipping macOS settings."
fi

# --- Stow dotfiles ---
if [ -n "$STOW_PACKAGES" ]; then
  info "Stowing packages: $STOW_PACKAGES"
  # The -R flag will restow (re-link) the packages
  stow -R $STOW_PACKAGES
else
  info "No packages to stow. Please configure STOW_PACKAGES in the script."
fi

# --- Configure Shell for mise ---
# Assuming Zsh. Modify if you use a different shell.
SHELL_CONFIG_FILE="$HOME/.zshrc"
MISE_ACTIVATION_LINE='eval "$(mise activate zsh)"'

info "Configuring shell for mise..."
if ! grep -qF -- "$MISE_ACTIVATION_LINE" "$SHELL_CONFIG_FILE"; then
  info "Adding mise activation to $SHELL_CONFIG_FILE"
  echo "" >> "$SHELL_CONFIG_FILE"
  echo "# Activate mise" >> "$SHELL_CONFIG_FILE"
  echo "$MISE_ACTIVATION_LINE" >> "$SHELL_CONFIG_FILE"
  info "Please restart your shell or run 'source $SHELL_CONFIG_FILE' to apply changes."
else
  info "mise activation is already configured in $SHELL_CONFIG_FILE."
fi

# --- Install tools with mise ---
info "Installing tools defined in your mise configuration (.tool-versions or config.toml)..."
# This command should be run from your dotfiles directory
# if your mise config is located there.
mise install

info "Setup complete!"
echo "Please make sure your mise configuration files (.tool-versions or .config/mise/config.toml) are in place."
echo "You may need to restart your terminal or run 'source ~/.zshrc' to apply all changes."%
