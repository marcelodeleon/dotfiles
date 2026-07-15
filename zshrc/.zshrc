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
export NODE_EXTRA_CA_CERTS="$HOME/certs/combined-ca-bundle.pem"

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
export JAVA_HOME=$(/usr/libexec/java_home -v 17)

# payhub-knowledge-base-setup
alias claude-kb='/Users/marcelodeleon/projects/payment-hub-knowledge-base/setup/claude-kb-launcher.sh'

# pi_kb (personal, not repo-managed): start a pi session at the KB repo root.
# cwd = KB root, so pi auto-loads the KB's CLAUDE.md. Also loads the KB skills.
# No MCP — dev skills have CLI alternatives. Subshell keeps caller's cwd intact.
pi_kb() {
  local kb="$HOME/projects/payment-hub-knowledge-base"
  # Best-effort KB auto-update: only fast-forward when on main + clean + behind.
  if [ -d "$kb/.git" ]; then
    git -C "$kb" fetch --quiet origin main 2>/dev/null || true
    local branch behind
    branch=$(git -C "$kb" symbolic-ref --short HEAD 2>/dev/null)
    behind=$(git -C "$kb" rev-list --count HEAD..origin/main 2>/dev/null || echo 0)
    if [ "$branch" = "main" ] && [ "$behind" -gt 0 ]; then
      if git -C "$kb" diff-index --quiet HEAD -- 2>/dev/null \
         && git -C "$kb" merge --ff-only --quiet origin/main 2>/dev/null; then
        echo "[kb] fast-forwarded main by $behind commit(s)" >&2
      else
        echo "[kb] main is $behind commit(s) behind origin/main — not pulling (dirty or non-ff)" >&2
      fi
    elif [ -n "$branch" ] && [ "$branch" != "main" ]; then
      echo "[kb] on '$branch' (not main) — KB auto-update skipped" >&2
    fi
  fi
  ( cd "$kb" && pi --skill "$kb/.claude/skills" "$@" )
}
