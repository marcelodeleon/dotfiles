# Navigation
setopt AUTO_CD          # type dir name to cd
setopt AUTO_PUSHD       # pushd/popd history
setopt PUSHD_IGNORE_DUPS

# Completion
autoload -Uz compinit
compinit -C
setopt COMPLETE_IN_WORD
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY INC_APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS HIST_REDUCE_BLANKS
