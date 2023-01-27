#!/bin/sh

echo "Linking files..."
cd ~
ln -sf dotfiles/bashrc        .bashrc
ln -sf dotfiles/gitconfig     .gitconfig
ln -sf dotfiles/tmux.conf     .tmux.conf
ln -sf dotfiles/vimrc         .vimrc

rm -rf .config/fish
rm -rf .config/nvim

ln -sF ~/dotfiles/config/fish ~/.config/fish
ln -sF ~/dotfiles/config/nvim ~/.config/nvim

command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew..."; \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }

read -r -p "Install dependencies? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  brew install bat ctags go fish fd fzf git git-lfs node redis ripgrep ruby tig tree tmux neovim wget
  $(brew --prefix)/opt/fzf/install

  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
else
  exit 0
fi

echo "Done!"
