# Dotfiles

My personal dotfiles.

## Installation

Fork and review these dotfiles before applying them. Remove and modify things as you wish.

### Stow
All the dotfiles are managed with [GNU Stow](https://www.gnu.org/software/stow/) so you can confidently apply and remove these configurations as you need without messing your current setup.


Clone the repo in your root directory
```bash
cd $HOME && git clone git@github.com:levriero/dotfiles.git && cd dotfiles
```

Install `stow`
```bash
brew install stow
```

Tell stow to create symlinks
```bash
stow */
```

### Setup script
A utility script is available to install system dependencies or tools I use on a daily basis.

```bash
./setup
```

# Fonts

- [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
- [Nerd Fonts](https://www.nerdfonts.com/)

```bash
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font
```
