function _git_branch_name() {
  git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||'
}

function _is_git_dirty() {
  git status -s --ignore-submodules=dirty 2> /dev/null
}

function _zsh_prompt() {
  local branch_name=$(_git_branch_name)

  if [ "$branch_name" ]; then
    if [ "$(_is_git_dirty)" ]; then
      local fancy_branch_name="%F{red}[$branch_name] ±%f"
    else
      local fancy_branch_name="%F{green}[$branch_name]%f"
    fi
  fi

  echo "%B%F{cyan}%1~%f $fancy_branch_name%b » "
}

setopt PROMPT_SUBST
PROMPT='$(_zsh_prompt)'
