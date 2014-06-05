cd ~

git clone git@github.com:gbonfant/dotfiles.git
mv -f ~/dotfiles/.* ~/
rm -rf ~/dotfiles

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brew install rbenv ruby-build
