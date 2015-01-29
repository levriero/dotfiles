set fish_greeting

set cdpath $HOME/Projects

set -x EDITOR "vim"
set -x USE_DEBUGGER true
set -x CDPATH . ~ $cdpath

# rbenv
status --is-interactive; and . (rbenv init -|psub)

alias p=prevd
alias n=nextd
