#
# shell variables
#
set -gx fish_greeting
set -gx SHELL /opt/homebrew/bin/fish
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx EDITOR "nvim"
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx GPG_TTY (tty)

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

#
# Colours
#
# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 283457
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection
