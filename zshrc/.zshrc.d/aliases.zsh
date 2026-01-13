alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# eza powered ls
if command -v eza >/dev/null 2>&1; then
  # Quick listing
  alias l='eza -la'
  # Long list with git, icons, human sizes
  alias ll='eza -lah --git --group'
  # Tree view
  alias lt='eza -T -L 2 --git-ignore'
  # Show dotfiles only
  alias la='eza -a'
else
  alias l='ls -la'
  alias ll='ls -lah'
  alias la='ls -A'
  alias lt='ls -R'
fi

# Quality of life
alias cls='clear'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias please='sudo $(fc -ln -1)'

# Git shorties
alias gs='git status -sb'
alias gb='git branch -vv'
alias gl='git log --oneline --graph --decorate -n 20'
alias gco='git checkout'
alias gc='git commit'
alias ga='git add'
alias gp='git pull --rebase && git push'
alias gsw='git switch'

# Make & cd
mkcd () { mkdir -p "$1" && cd "$1"; }
