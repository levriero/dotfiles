install:
	stow --restow --target="${HOME}" config

dependencies:
	sudo dnf install neovim fzf stow
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
