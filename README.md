### Installation

```bash
git clone git@github.com:gbonfant/dotfiles.git
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sh dotfiles/script/setup.sh
```
### Post installation
- ``brew install vim ``

- Make sure to install [Vundle](https://github.com/gmarik/Vundle.vim)

- Command-T needs to be compilled, run the following to do so:
```bash
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
```
