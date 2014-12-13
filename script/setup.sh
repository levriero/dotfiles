#!/usr/bin/env bash

set -e

DOTFILES_DIR=$(pwd)
BREW_DEPENDENCIES=(rbenv ruby-build ag tree tig node reattach-to-user-namespace ctags tmux)
NPM_DEPENDENCIES=(jshint)

create_symlinks() {
  for file in *; do
    if ! (echo $file | grep -q "script\|README"); then
      ln -sf $(pwd)/$file $HOME/.$file
    fi
  done
}

install_dependencies_with_homebrew() {
  for dependency in ${BREW_DEPENDENCIES[@]}; do
    if ! hash $dependency 2>/dev/null; then
      echo "  > Installing" $dependency "..."
      brew install $dependency
    fi
  done
}

install_dependencies_with_npm() {
  for dependency in ${NPM_DEPENDENCIES[@]}; do
    if ! hash $dependency 2>/dev/null; then
      echo "  > Installing" $dependency "..."
      npm install -g $dependency
    fi
  done
}

install_fish() {
  if ! hash fish 2>/dev/null; then
    echo "  > Installing fish..."
    brew install fish

    echo "  > Setting fish as default shell..."
    echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/fish
  fi
}

install_macvim() {
  if ! hash mvim 2>/dev/null; then
    echo "  > Installing macvim..."
    brew install macvim --with-cscope --with-lua --HEAD
  fi
}

echo "      _       _    __ _ _            "
echo "     | |     | |  / _(_) |           "
echo "   __| | ___ | |_| |_ _| | ___  ___  "
echo "  / _\` |/ _ \| __|  _| | |/ _ \/ __| "
echo " | (_| | (_) | |_| | | | |  __/\__ \ "
echo "  \__,_|\___/ \__|_| |_|_|\___||___/ "
echo "                                     "
echo "                                     "


cd $DOTFILES_DIR

echo "  > Updating homebrew..."
brew update &> /dev/null

echo "  > Pulling latest changes..."
git pull &> /dev/null

install_dependencies_with_homebrew
install_dependencies_with_npm
install_fish

echo "  > Creating symlinks..."
create_symlinks

echo "==> Done."
