# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="agnoster"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# =====================
# User configuration
# =====================

# Navigation
alias ..="cd .."

# Git
alias gl="git pull origin"
alias gp="git push origin"
alias gb="git branch"
alias gc="git commit"
alias gca="git commit -am"
alias gs="git status -s"
alias gd="git diff"
alias go="git checkout"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gclean="git branch | grep -v "master" | xargs git branch -D"

# Shortcuts
alias p="cd ~/Projects"
alias be="bundle exec"
alias rs='bundle exec rspec'

# Always use color output for `ls`
alias ls="ls -G"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ifconfig en0 inet"

# Path
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin"

# Enable shims and autocomplete in rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# Use mvim as default editor
export EDITOR="mvim -f"

# Set zle in vi mode
bindkey -v

# Keep key shortcuts
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# Fix 0.4s delay after changing modes (via ESC)
export KEYTIMEOUT=1

# Use homebrew instead of system-provided programs
export PATH=/usr/local/bin:$PATH
