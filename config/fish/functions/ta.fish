# [t]mux [a]ttach
# - Create (or switch) to a tmux session named after the current directory
# - Start tmux if no server is running
function ta
  set session_name (basename $PWD)

  if test -z $TMUX
    tmux new-session -As $session_name
  else
    if ! tmux ls | sed -E 's/:.*$//' | rg "^"$session_name"\$"
      TMUX='' tmux new-session -Ads $session_name
    end

    tmux switch-client -t $session_name
  end
end
