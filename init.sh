cd ~

# Install homebrew and some kegs
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew install rbenv ruby-build zsh ag

# Install latest version of vim and macvim with lua support
brew install macvim --with-cscope --with-lua --HEAD
brew install vim --with-lua

# Set zsh as default shell
chsh -s /usr/local/bin/zsh

# Install Oh-my-zsh
curl -L http://install.ohmyz.sh | sh

# Install Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Create backup and temp folders for Vim
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/tmp

# Copy git dotfiles into home
git clone git@github.com:gbonfant/dotfiles.git
mv ~/dotfiles/.* -t ~/ -f
rm -rf ~/dotfiles

# Bootstrap Sublime Text 2
git clone git@github.com:gbonfant/sublime_2.git
sh ~/sublime_2/init.sh
rm -rf sublime_2

# Post rbenv installation for zsh
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
