# ------------------------------------------
# Prompt
# ------------------------------------------

if [ -e ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
fi

PROMPT_COMMAND='__git_ps1 "\W " "\\\$ " "[%s] "'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
