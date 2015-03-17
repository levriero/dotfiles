set fish_greeting

set cdpath $HOME/Projects

set -x EDITOR "vim"
set -x CDPATH . ~ $cdpath
set -U fish_user_paths /usr/local/sbin $HOME/.fzf/bin

# rbenv
status --is-interactive; and . (rbenv init -|psub)

alias p=prevd
alias n=nextd
