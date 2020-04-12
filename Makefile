install:
	stow --restow --target="${HOME}" linux

dependencies:
	sudo apt install stow zsh-syntax-highlighting
