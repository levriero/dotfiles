# Greeting message
set fish_greeting

# PATH
set default_path /usr/bin /usr/sbin /bin /sbin
set homebrew /usr/local/bin /usr/local/sbin
set heroku /usr/local/heroku/bin

set -gx PATH $homebrew $heroku $default_path

# rbenv
status --is-interactive; and . (rbenv init -|psub)

# Editor
set -gx EDITOR vim

# Docker daemon
set -x DOCKER_HOST "tcp://192.168.59.103:2375"
