#!/bin/bash
#
# dotfiles setup script for macOS with Homebrew, mise, and stow.
#
set -e

# --- Configuration ---
# List of packages to stow. Add your package directory names here.
STOW_PACKAGES="zsh git nvim mise"

if [ -n "$STOW_PACKAGES" ]; then
  # The -R flag will restow (re-link) the packages
  stow -R $STOW_PACKAGES
else
  echo "No packages to stow. Please configure STOW_PACKAGES in the script."
fi

# --- Configure Shell for mise ---
# Assuming Zsh. Modify if you use a different shell.
SHELL_CONFIG_FILE="$HOME/.zshrc"
MISE_ACTIVATION_LINE='eval "$(mise activate zsh)"'

echo "Configuring shell for mise..."
if ! grep -qF -- "$MISE_ACTIVATION_LINE" "$SHELL_CONFIG_FILE"; then
  echo "Adding mise activation to $SHELL_CONFIG_FILE"
  echo "" >> "$SHELL_CONFIG_FILE"
  echo "# Activate mise" >> "$SHELL_CONFIG_FILE"
  echo "$MISE_ACTIVATION_LINE" >> "$SHELL_CONFIG_FILE"
  echo "Please restart your shell or run 'source $SHELL_CONFIG_FILE' to apply changes."
else
  echo "mise activation is already configured in $SHELL_CONFIG_FILE."
fi

# --- Install tools with mise ---
echo "Installing tools defined in your mise configuration (.tool-versions or config.toml)..."
# This command should be run from your dotfiles directory
# if your mise config is located there.
mise install

echo "Setup complete!"
echo "Please make sure your mise configuration files (.tool-versions or .config/mise/config.toml) are in place."
echo "You may need to restart your terminal or run 'source ~/.zshrc' to apply all changes."%
