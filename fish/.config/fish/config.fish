set -gx fish_greeting

set -gx SHELL /opt/homebrew/bin/fish
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx EDITOR "nvim"
set -gx HOMEBREW_NO_ANALYTICS 1

set -gx VOLTA_HOME "$HOME/.volta"

set -gx PATH $VOLTA_HOME/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH

# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed and these are never upgraded.
# To link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded) add the following
set -gx RUBY_CONFIGURE_OPTS "--with-openssl-dir=/opt/homebrew/openssl@2.1"

if status --is-interactive
  eval (/opt/homebrew/bin/brew shellenv)

	# abbreviations
	abbr --add lg "lazygit"
end

source /opt/homebrew/opt/asdf/libexec/asdf.fish
zoxide init fish | source
