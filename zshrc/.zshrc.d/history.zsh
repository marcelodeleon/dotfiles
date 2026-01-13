# History keybindings - must load after zsh-history-substring-search

# Bind up/down arrows to history substring search
# This allows you to type part of a command, then use up/down to search history
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Also bind for different terminal emulators (vi mode compatibility)
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

# Bind Ctrl-P and Ctrl-N as well (common vim-style bindings)
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# Ensure Ctrl-R still uses fzf (in case something tries to override it)
# This should already be set by fzf, but we explicitly ensure it here
if (( $+commands[fzf] )); then
  bindkey '^R' fzf-history-widget
fi

# Additional history behavior options
setopt HIST_FIND_NO_DUPS        # Don't show duplicates when searching
setopt HIST_IGNORE_SPACE        # Don't save commands starting with space
