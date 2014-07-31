#!/usr/bin/env bash

set -e

echo "      _       _    __ _ _            "
echo "     | |     | |  / _(_) |           "
echo "   __| | ___ | |_| |_ _| | ___  ___  "
echo "  / _\` |/ _ \| __|  _| | |/ _ \/ __| "
echo " | (_| | (_) | |_| | | | |  __/\__ \ "
echo "  \__,_|\___/ \__|_| |_|_|\___||___/ "
echo "                                     "
echo "                                     "


cd ~/.dotfiles
echo "==> Installing..."

# ===================================
# Homebrew installs
# ===================================

echo "  > Updating homebrew..."
brew update &> /dev/null

echo "  > Installing rbenv..."
if command -v rbenv >/dev/null 2>&1; then
  echo "  > Skipping, already installed"
else
  brew install rbenv --HEAD
fi

echo "  > Installing ruby-build..."
if command -v ruby-build >/dev/null 2>&1; then
  echo "  > Skipping, already installed"
else
  brew install ruby-build
fi

echo "  > Installing the_silver_searcher..."
if command -v ag >/dev/null 2>&1; then
  echo "  > Skipping, already installed"
else
  brew install the_silver_searcher
fi

echo "  > Installing fish..."
if command -v fish >/dev/null 2>&1; then
  echo "  > Skipping, already installed"
else
  brew install fish

  echo "  > Setting fish as default shell..."
  echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/fish
fi

echo "  > Installing macvim..."
if command -v mvim >/dev/null 2>&1; then
  echo "  > Skipping, already installed"
else
  brew install macvim --with-cscope --with-lua --HEAD
fi

echo "  > Installing vim..."
if command -v vim >/dev/null 2>&1; then
  echo "  > Skipping, already installed"
else
  brew install vim --with-lua --override-system-vim
fi

echo "  > Pulling latest changes..."
git pull &> /dev/null

echo "  > Copying directories..."
rsync -av ~/.dotfiles ~/ --exclude .git


echo "==> Done."
