if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  # habits
  alias cd='z'     # jump by frecency
  alias cdi='zi'   # interactive jump
fi
