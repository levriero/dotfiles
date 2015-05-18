# General
# ------------------------------------------
if [ -e ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

# Environment variables
# ------------------------------------------
export EDITOR=vim
export CDPATH=.:$HOME:$HOME/Projects

# Prompt
# ------------------------------------------
base='\e[0m'
boldcyan='\e[1;36m'

PS1="${boldcyan}\W ${base}❯ "

# Aliases
# ------------------------------------------
alias ..='cd ..'
alias g='git'
alias c='clear'
alias vi='vim'
alias be='bundle exec'
alias migrate='bundle exec rake db:migrate'

# autocomplete `g` alias
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
