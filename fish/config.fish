# Greeting message
set fish_greeting

# heroku CLI
set heroku /usr/local/heroku/bin

# PATH
set -x PATH $heroku $PATH

# rbenv
status --is-interactive; and . (rbenv init -|psub)
