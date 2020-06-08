set -x HOMEBREW_NO_ANALYTICS 1
set -x EDITOR "nvim"

set fish_greeting

# ----------------------------------------------------------------------------
# Homebrew (macOS)
# ----------------------------------------------------------------------------

# openssl@1.1 is keg-only, which means it was not symlinked into /usr/local,
# because macOS provides LibreSSL.
#
# If you need to have openssl@1.1 first in your PATH run:
#  echo 'set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths' >> ~/.config/fish/config.fish

# For compilers to find openssl@1.1 you may need to set:
set -gx LDFLAGS "-L/usr/local/opt/openssl@1.1/lib"
set -gx CPPFLAGS "-I/usr/local/opt/openssl@1.1/include"

# For pkg-config to find openssl@1.1 you may need to set:
set -gx PKG_CONFIG_PATH "/usr/local/opt/openssl@1.1/lib/pkgconfig"

# ----------------------------------------------------------------------------
# Tools
# ----------------------------------------------------------------------------

# rbenv
status --is-interactive; and source (rbenv init -|psub)
