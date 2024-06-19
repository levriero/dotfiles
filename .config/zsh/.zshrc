# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set cache directory
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh

# Exported variables
# ------------------
export HOMEBREW_NO_ANALYTICS=1

# Plugins
# ------------------
# Set the directory we want to install zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if it's not installed
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Initial Zinit's hash definition
declare -A ZINIT

# Do not set aliases such as zi or zini
ZINIT[NO_ALIASES]=1

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load powerlevel10k theme
zinit ice depth "1" # git clone depth
zinit light romkatv/powerlevel10k

# Fish shell-like syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

# Additional completion definitions
zinit light zsh-users/zsh-completions

# Fish-like fast/unobtrusive autosuggestions
zinit light zsh-users/zsh-autosuggestions

# Replace default completion selection menu with fzf
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit && compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION

# Re-play all catched compdef calls
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybinds
# ------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
# ------------------
HISTSIZE=5000
HISTFILE="$XDG_STATE_HOME"/zsh/history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
# ------------------
# Match lowercase and uppercase characters
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Display ls --color style on completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Disable default completion menu
zstyle ':completion:*' menu no

# Set directory for completion's cache
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache

# Display preview of directories on cd autocompletion
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Enable previews on zoxide autocompletions
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
# ------------------
alias ls='ls --color'
alias lg='lazygit'

# Shell integrations
# ------------------
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
[[ -f $ZDOTDIR/mise.zsh ]] && source $ZDOTDIR/mise.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
