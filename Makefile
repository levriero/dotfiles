install:
	stow --restow --target="${HOME}" config

dependencies:
	sudo apt install stow
