set -x HOMEBREW_NO_ANALYTICS 1
set -x EDITOR "nvim"

set -x TERM xterm-256color
set -x TERMINFO xterm-256color

set -x NVMDIR $XDG_CONFIG_HOME/.nvm

# cargo
set PATH $HOME/.cargo/bin $PATH

set fish_greeting

# homebrew
if status --is-interactive
  eval (/opt/homebrew/bin/brew shellenv)
end

# rbenv
status --is-interactive; and source (rbenv init -|psub)

# The next line updates PATH for the Google Cloud SDK.
if [ -f "($HOME)/google-cloud-sdk/path.fish.inc" ]; . "($HOME)/google-cloud-sdk/path.fish.inc"; end

# pure-fish/pure
set pure_enable_single_line_prompt true
