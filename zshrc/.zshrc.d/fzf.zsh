# If installed via Homebrew, this sources the goodies
if [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi
if [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# Nice defaults (works even without fd)
export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border'
if command -v rg >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Ctrl-R: show better, execute on Enter
export FZF_CTRL_R_OPTS='--sort --exact'
