. ~/.bashrc
export PATH="/usr/local/sbin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then source "$HOME/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then source "$HOME/google-cloud-sdk/completion.bash.inc"; fi

# bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

if [ -f /sw/etc/bash_completion ]; then
  . /sw/etc/bash_completion
fi

export PATH="$HOME/.cargo/bin:$PATH"
