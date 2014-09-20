# Greeting message
set fish_greeting

# Set macvim in CLI mode as editor
set -x EDITOR 'mvim -v'
set -x GIT_EDITOR 'mvim -v'

# Homebrew
set homebrew /usr/local/bin

# heroku CLI
set heroku /usr/local/heroku/bin

# PATH
set -x PATH $homebrew $heroku $PATH

# rbenv
set PATH $HOME/.rbenv/bin $PATH
. (rbenv init -|psub)

