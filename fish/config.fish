set fish_greeting

set heroku /usr/local/heroku/bin
set cdpath $HOME/Projects

set -x EDITOR "vim"
set -x USE_DEBUGGER true
set -x CDPATH . ~ $cdpath
set -x PATH $heroku $PATH

# rbenv
status --is-interactive; and . (rbenv init -|psub)

alias p=prevd
alias n=nextd
