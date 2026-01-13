#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

# Packages that stow to ~ (home)
HOME_PACKAGES=(zshrc)

# Packages that stow to ~/.config (via .stowrc default)
CONFIG_PACKAGES=(ghostty tmux)

echo "Setting up dotfiles from $DOTFILES_DIR"

# Stow home-targeted packages
for pkg in "${HOME_PACKAGES[@]}"; do
  echo "Stowing $pkg -> ~"
  stow -t ~ "$pkg"
done

# Stow config-targeted packages (uses .stowrc)
for pkg in "${CONFIG_PACKAGES[@]}"; do
  echo "Stowing $pkg -> ~/.config"
  stow "$pkg"
done

echo "Done!"
