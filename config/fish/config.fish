# Greeting message
set fish_greeting

# Set macvim in CLI mode as editor
set -x EDITOR 'mvim -v'
set -x GIT_EDITOR 'mvim -v'

# Homebrew
set -x PATH /usr/local/bin $PATH

# rbenv
set PATH $HOME/.rbenv/bin $PATH
. (rbenv init -|psub)
