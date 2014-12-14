# Greeting message
set fish_greeting

# heroku CLI
set heroku /usr/local/heroku/bin

# PATH
set -x PATH $heroku $PATH

# rbenv
set -gx RBENV_ROOT /usr/local/var/rbenv
. (rbenv init -|psub)
