# Dotfiles

Personal configurations managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's Included

- **zshrc** - Zsh config with antidote, starship, and modular `.zshrc.d/`
- **ghostty** - Ghostty terminal emulator config
- **tmux** - Tmux config with plugins
- **pi-agent** - Pi settings, themes, and extensions
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

Uses GNU Stow with three targets:
- `zshrc`, `tmux`, `aerospace` → `~`
- `ghostty`, `starship` → `~/.config` (XDG config directory)
- `pi-agent` → `~/.pi/agent`

The `.stowrc` file sets `~/.config` as the default target.

## Pi workflow

Pi-managed files in this repo live under `pi-agent/` and are symlinked into `~/.pi/agent`.

- Theme edits are reflected immediately for the active custom theme.
- Extension and keybinding changes can be applied with `/reload`.
- `auth.json`, `sessions/`, and `trust.json` stay outside the repo.
