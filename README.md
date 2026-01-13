# Dotfiles

Personal configurations managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's Included

- **zshrc** - Zsh config with antidote, starship, and modular `.zshrc.d/`
- **ghostty** - Ghostty terminal emulator config
- **tmux** - Tmux config with plugins
- **scripts** - Utility scripts (tmux-sessionizer)

> **Note:** Neovim configuration is in a separate repository.

## Setup

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles

# Run setup
cd ~/dotfiles
./setup.sh
```

## How It Works

Uses GNU Stow with two targets:
- `zshrc` → `~` (zsh expects config in home)
- `ghostty`, `tmux` → `~/.config` (XDG config directory)

The `.stowrc` file sets `~/.config` as the default target.
