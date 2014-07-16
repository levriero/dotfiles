## Installation

```bash
$ cd ~
$ git clone git@github.com:gbonfant/dotfiles.git .dotfiles/
$ sh .dotfiles/script/init
```

## Post installation

- Download iTerm base16 colorscheme [here](https://github.com/gbonfant/base16-iterm2)
- Set command to /usr/local/bin/fish -l in Profiles > General > Preferences

## Troubleshooting
- Colorscheme looks odd? Make sure you are not using the 256 version of the base16 colorscheme.
- iTerm2 is slow? Make sure to clean the logs ``sudo rm /private/var/log/asl/*.asl ``
