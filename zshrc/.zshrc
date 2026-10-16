# load zgen
source "${HOME}/.zgen/zgen.zsh"

# Load aliases
[[ -f ~/aliases.zsh ]] && source ~/aliases.zsh

# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here
  zgen oh-my-zsh

  zgen oh-my-zsh plugins/z
  zgen load denysdovhan/spaceship-prompt spaceship
  zgen load zsh-users/zsh-syntax-highlighting
  # zgen load zsh-users/zsh-history-substring-search.zsh
  # Load dracula pro theme
  zgen oh-my-zsh themes/dracula-pro

  # generate the init script from plugins above
  zgen save
fi

# Load nvm without its implicit version lookup, then activate the default.
# --delete-prefix clears stale npm prefix settings that conflict with nvm.
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh" --no-use
  nvm use --delete-prefix default --silent
fi

# Add user-installed command-line tools (including leaf) to PATH.
export PATH="$HOME/.local/bin:$PATH"

# Add Homebrew sbin to PATH
export PATH="/usr/local/sbin:$PATH"

# Set up fzf key bindings and fuzzy completion
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# Load Firecrawl API key from the macOS login Keychain for interactive shells.
if [[ -o interactive ]]; then
  export FIRECRAWL_API_KEY="$(security find-generic-password -s "firecrawl-api-key" -w 2>/dev/null)"
fi

# Add nvim to PATH
export PATH="/usr/local/bin/nvim/bin:$PATH"

# Utility to profile zsh loading time
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
