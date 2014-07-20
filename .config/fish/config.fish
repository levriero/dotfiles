# Greeting message
set fish_greeting

# PATH
set default_path /usr/bin /usr/sbin /bin /sbin
set homebrew /usr/local/bin /usr/local/sbin

set -gx PATH $homebrew $default_path

# rbenv
status --is-interactive; and . (rbenv init -|psub)

# Editor
set -gx EDITOR vim

