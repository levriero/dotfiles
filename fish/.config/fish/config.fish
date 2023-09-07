#
# shell variables
#
set -gx fish_greeting
set -gx SHELL /opt/homebrew/bin/fish
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx EDITOR "nvim"
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx GPG_TTY (tty)
set -gx VOLTA_HOME "$HOME/.volta"

fish_add_path $VOLTA_HOME/bin
fish_add_path /opt/homebrew/opt/postgresql@15/bin

if status --is-interactive
	# exports environment variables needed for brew to work
  eval (/opt/homebrew/bin/brew shellenv)

	#
	# abbreviations
	#
	abbr --add lg "lazygit"

	#
	# script sourcing
	#

	# asdf
	source /opt/homebrew/opt/asdf/libexec/asdf.fish

	# zoxide
	zoxide init fish | source
end
