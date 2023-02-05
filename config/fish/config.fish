set -x HOMEBREW_NO_ANALYTICS 1
set -x EDITOR "nvim"

set -x TERM xterm-256color
set -x TERMINFO xterm-256color

set -x NVMDIR $XDG_CONFIG_HOME/.nvm

# cargo
set PATH $HOME/.cargo/bin $PATH

# homebrew
if status --is-interactive
  eval (/opt/homebrew/bin/brew shellenv)
end

# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed and these are never upgraded.
# To link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded) add the following
set RUBY_CONFIGURE_OPTS "--with-openssl-dir=$(brew --prefix openssl@1.1)"

# rbenv
status --is-interactive; and source (rbenv init -|psub)

# The next line updates PATH for the Google Cloud SDK.
if [ -f "($HOME)/google-cloud-sdk/path.fish.inc" ]; . "($HOME)/google-cloud-sdk/path.fish.inc"; end

set fish_greeting

# pure-fish/pure
set pure_enable_single_line_prompt true

# volta
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# zoxide
zoxide init fish | source
