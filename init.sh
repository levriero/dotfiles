cd ~

# Install homebrew and some kegs
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew install ruby-build fish ag

# Install latest version of rbenv with support for fish
brew install rbenv --HEAD

# Install latest version of vim and macvim with lua support
brew install macvim --with-cscope --with-lua --HEAD
brew install vim --with-lua --override-system-vim

# Set fish as default shell
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

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

# Make sure fish uses latest vim as editor
set EDITOR /usr/local/bin/vim
