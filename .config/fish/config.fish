set fish_greeting

set cdpath $HOME/Projects

set -x EDITOR "vim"
set -x CDPATH . ~ $cdpath
set -x PATH $PATH /usr/local/sbin
set -x RUBYGEMS_GEMDEPS -

# rbenv
status --is-interactive; and . (rbenv init -|psub)

alias p=prevd
alias n=nextd
