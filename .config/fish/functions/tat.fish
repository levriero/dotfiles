function tat
  set session_name (basename "$PWD" | tr . -)
  set session_exists (tmux list-sessions | sed -E 's/:.*$//' | ag "^"$session_name"\$")

  if test $TMUX
    if not test $session_exists
      set TMUX ''
      tmux new-session -Ad -s $session_name
    end

    tmux switch-client -t "$session_name"
  else
    tmux new-session -As $session_name
  end
end
