# 🗂️ Dotfiles Repository

Welcome to my **dotfiles** repository! This is where I keep all my personalized configurations for various tools and applications I use daily.

These dotfiles are designed to make setting up a new machine (or keeping my environment consistent across machines) quick and hassle-free.

---

## 📂 What’s Included

This repository contains configuration files and folders for:

- **Zsh** (`zsh/zshrc`): My customized Zsh setup, including prompt and plugins.
- **Bash** (`bash/bashrc`, `bash/bash_aliases`): Useful aliases and functions for Bash.
- **Alacritty** (`alacritty.yml`): My terminal emulator configuration.
- **Tmux** (`tmux`): My Tmux configuration.
- **Powerline** (`powerline/themes`): Powerline themes for a better-looking status bar.
- **Other configs** as needed.

> **Note:** My Neovim configuration is maintained in a separate repository and is **not** included here.

---

## 🚀 How to Set Up

To **clone** this repository and **symlink** the relevant dotfiles to your home directory:

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles

# Navigate to the repo
cd ~/dotfiles

# Run the setup script to create symlinks
./setup_symlinks.sh
```
### 🔍 Dry Run
Want to see what the script will do without making changes? Use:
```
./setup_symlinks.sh --dry-run
```
