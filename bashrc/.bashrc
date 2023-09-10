# --------------------------------------------------------------------
# Options
# --------------------------------------------------------------------

# Append to the history file
shopt -s histappend

# Check the window size after each command ($LINES, $COLUMNS)
shopt -s checkwinsize

### Better-looking less for binary files
[ -x /usr/bin/lesspipe    ] && eval "$(SHELL=/bin/sh lesspipe)"

# --------------------------------------------------------------------
# Environment Variables
# --------------------------------------------------------------------

# man bash
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "
[ -z "$TMPDIR" ] && TMPDIR=/tmp

# gsutils
# https://github.com/GoogleCloudPlatform/gsutil/issues/29#issuecomment-525063367
export CLOUDSDK_GSUTIL_PYTHON=python3

# Global
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=nvim
export VOLTA_HOME="$HOME/.volta"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$VOLTA_HOME/bin:$PATH"

# --------------------------------------------------------------------
# Git prompt & Completion
# --------------------------------------------------------------------

# Git prompt
GIT_PROMPT_IGNORE_SUBMODULES=1 # avoid searching for changed files in submodules
GIT_PROMPT_SHOW_UNTRACKED_FILES=no # can be no, normal or all; determines counting of untracked files
GIT_PROMPT_WITH_VIRTUAL_ENV=0 # avoid setting virtual environment infos for node/python/conda environments
GIT_PROMPT_THEME=Single_line_Minimalist

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi


# --------------------------------------------------------------------
# Aliases
# --------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'

alias vi=$EDITOR
alias vim=$EDITOR
alias tmux="tmux -2"

alias ls='ls -G'
alias gitv='git log --graph --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

# Ruby
alias be="bundle exec"
alias ber="bundle exec rake"


# --------------------------------------------------------------------
# fzf
# --------------------------------------------------------------------

fzf-down() {
  fzf --height 50% "$@" --border
}

if command -v fd > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git'
fi

command -v bat  > /dev/null && export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
command -v blsd > /dev/null && export FZF_ALT_C_COMMAND='blsd'
command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# checkout git branch/tag
fco() {
  local tags branches target
  tags=$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") | sed '/^$/d' |
    fzf-down --no-hscroll --reverse --ansi +m -d "\t" -n 2 -q "$*") || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# switch tmux-sessions
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --height 40% --reverse --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}


is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# git changes
gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

# git branches
gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -200' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

# git log
gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -200' |
  grep -o "[a-f0-9]\{7,\}"
}

# --------------------------------------------------------------------
# Functions
# --------------------------------------------------------------------

# Pipe process status to fzf
function psf() {
  ps aux | fzf
}

# Return a unique timestamp.
function ts() {
  date +%Y%m%d%H%M%S
}

# Delete all local branches except `master` and `staging`
function gclean() {
  git for-each-ref --format '%(refname:short)' refs/heads | grep -v 'master\|staging' | xargs git branch -D
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
