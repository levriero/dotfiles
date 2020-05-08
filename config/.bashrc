# --------------------------------------------------------------------
# Options
# --------------------------------------------------------------------

# Append to the history file
shopt -s histappend

# Check the window size after each command ($LINES, $COLUMNS)
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Bash completion
[ -f /etc/bash_completion ] && . /etc/bash_completion

# enable color support
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# --------------------------------------------------------------------
# Environment Variables
# --------------------------------------------------------------------

# man bash
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "
[ -z "$TMPDIR" ] && TMPDIR=/tmp

# Global
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=nvim

export CDPATH=".:$HOME:$HOME/code"
export PATH="$HOME/.rbenv/bin:$PATH"

# --------------------------------------------------------------------
# Aliases
# --------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'

alias vi=$EDITOR
alias vim=$EDITOR
alias tmux="tmux -2"

alias ls='ls -h --group-directories-first --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias gitv='git log --graph --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

alias be="bundle exec"
alias ber="bundle exec rake"


# --------------------------------------------------------------------
# Prompt
# --------------------------------------------------------------------
base='\[\e[0m\]'
boldcyan='\[\e[1;36m\]'

PS1="${boldcyan} \W${base}\$(__git_ps1) → "

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

# Make a new note
function nn() {
  nvim ~/Tresors/Documents/Notes/${1}.txt -c Goyo
}

# --------------------------------------------------------------------
# Extras
# --------------------------------------------------------------------

# rbenv
eval "$(rbenv init -)"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# git completion
source /usr/share/git-core/contrib/completion/git-prompt.sh
