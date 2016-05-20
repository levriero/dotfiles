# General
# ------------------------------------------
if [ -e $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi

set -o emacs

# Environment variables
# ------------------------------------------
export EDITOR=vim
export CDPATH=.:$HOME:$HOME/Code

# Prompt
# ------------------------------------------
base='\[\e[0m\]'
boldcyan='\[\e[1;36m\]'

PS1="${boldcyan}\W ${base}❯ "

# Aliases
# ------------------------------------------
alias ..='cd ..'
alias g='git'
alias c='clear'
alias vi='vim'
alias be='bundle exec'
alias ls='ls -G'
alias migrate='bundle exec rake db:migrate'
alias rials='rails'

# autocomplete `g` alias
__git_complete g __git_main

# Functions
# ------------------------------------------
function ip() {
  ipconfig getifaddr en0
  ipconfig getifaddr en1
}

function prune-ds() {
  find . -name '.DS_Store' -delete
}

# Switch to a new MAC address
function remac() {
  sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
  sudo ifconfig en0 ether $(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
  sudo networksetup -detectnewhardware
  echo $(ifconfig en0 | grep ether)
}

# - Create (or switch) to a tmux session named after the current directory
# - Start tmux if no server is running
function ta() {
  local session_name=${PWD##*/}

  if [ -z "$TMUX" ]; then
    tmux new-session -As $session_name
  else
    if ! tmux ls | sed -E 's/:.*$//' | ag "^"$session_name"\$"; then
      # if session does not exist create a detached session
      TMUX='' tmux new-session -Ads $session_name
    fi

    tmux switch-client -t $session_name
  fi
}

# Select a tmux session with fuzzy search
#  - Bypass fuzzy finder if there's only one match (--select-1)
#  - Exit if there's no match (--exit-0)
function fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

function psf() {
  ps aux | fzf
}

# Create a gif from a .mov file
#  - Dependencies: ffmpeg, gifsicle
function gif() {
  local video_file=$1
  local resolution=$2
  local output=${3-output}
  local fps=${4-20}

  ffmpeg -i $video_file -s $resolution -pix_fmt rgb24 -r $fps -f gif - |
  gifsicle --optimize=3 --delay=3 > $output.gif
}

# Path shenanigans
# ------------------------------------------
eval "$(rbenv init -)"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
