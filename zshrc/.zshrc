export LANG=en_US.UTF-8

# Fix terminal dimensions for tmux/multiplexers
export COLUMNS=$(tput cols)
export LINES=$(tput lines)

# Preferred editor for local and remote sessions
# Use full path for EDITOR since aliases don't work in non-interactive shells (e.g., Claude Code)
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export VISUAL='vim'
else
  export EDITOR='/usr/local/bin/nvim-macos-arm64/bin/nvim'
  export VISUAL="$EDITOR"
fi

# source antidote
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh

# initialize completions before loading plugins
autoload -Uz compinit
compinit

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# --- modular config loader (load AFTER plugins) ---
for f in ~/.zshrc.d/*.zsh; do
  [ -r "$f" ] && source "$f"
done

export XDG_CONFIG_HOME="$HOME/.config"

alias nvim=/usr/local/bin/nvim-macos-arm64/bin/nvim

eval "$(zoxide init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

alias ls=eza

# Needed for llm-proxy-keys
export PATH="$HOME/.local/bin:$PATH"

# nvm config
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval "$(starship init zsh)"
