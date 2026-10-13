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

# Pay attention to the '--no-use' flag when
# loading nvm. This cuts zsh loading time by a
# big margin.
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh" --no-use
  nvm use default --silent >/dev/null 2>&1
fi

# Add Homebrew sbin to PATH
export PATH="/usr/local/sbin:$PATH"

# Add nvim to PATH
export PATH="/usr/local/bin/nvim/bin:$PATH"

# Utility to profile zsh loading time
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
