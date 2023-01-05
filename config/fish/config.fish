set -x HOMEBREW_NO_ANALYTICS 1
set -x EDITOR "vim"
set -x TERM tmux-256color

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

# ---
# aliases
# ---
# alias vim "nvim"

# TokyoNight Color Palette
# set -l foreground c0caf5
# set -l selection 33467C
# set -l comment 565f89
# set -l red f7768e
# set -l orange ff9e64
# set -l yellow e0af68
# set -l green 9ece6a
# set -l purple 9d7cd8
# set -l cyan 7dcfff
# set -l pink bb9af7

# Material Default Colors
# set -l bg         263238
# set -l fg         eeffff
# set -l invisibles 65738e
# set -l caret      ffcc00
# set -l comment    546e7a
# set -l selection  2c3b41
# set -l red        ff5370
# set -l orange     f78c6c
# set -l yellow     ffcb6b
# set -l green      c3e88d
# set -l cyan       89ddff
# set -l blue       82aaff
# set -l paleblue   b2ccd6
# set -l purple     c792ea
# set -l brown      c17e70
# set -l pink       f07178
# set -l violet     bb80b3
#
# # Syntax Highlighting Colors
# set -g fish_color_normal $foreground
# set -g fish_color_command $cyan
# set -g fish_color_keyword $pink
# set -g fish_color_quote $yellow
# set -g fish_color_redirection $foreground
# set -g fish_color_end $orange
# set -g fish_color_error $red
# set -g fish_color_param $purple
# set -g fish_color_comment $comment
# set -g fish_color_selection --background=$selection
# set -g fish_color_search_match --background=$selection
# set -g fish_color_operator $green
# set -g fish_color_escape $pink
# set -g fish_color_autosuggestion $comment
#
# # Completion Pager Colors
# set -g fish_pager_color_progress $comment
# set -g fish_pager_color_prefix $cyan
# set -g fish_pager_color_completion $foreground
# set -g fish_pager_color_description $comment
