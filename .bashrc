# General
# ------------------------------------------
# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Environment variables
# ------------------------------------------
export EDITOR=vim
export CDPATH=.:$HOME:$HOME/Projects

# Prompt
# ------------------------------------------
if [ -e ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
fi

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
PROMPT_COMMAND='__git_ps1 "\W " "\\\$ " "[%s] "'

# Aliases
# ------------------------------------------
alias ..='cd ..'
alias g='git'
alias c='clear'
alias vi='vim'
alias be='bundle exec'
alias migrate='bundle exec rake db:migrate'

# autocomplete `g` git alias
__git_complete g __git_main

# Functions
# ------------------------------------------
function ip() {
  ipconfig getifaddr en0
  ipconfig getifaddr en1
}

function prune-ds() {
  find . -name '.DS_Store' -delete
}

# Path shenanigans
# ------------------------------------------
eval "$(rbenv init -)"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
