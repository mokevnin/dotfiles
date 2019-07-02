ANSIBLE_PREFIX := docker run -v $(HOME):/host/home -v $(CURDIR):/dotfiles -w /dotfiles williamyeh/ansible:ubuntu18.04 ansible-playbook -i local -vv

all: myvim-install
	# ansible-playbook all.yml -i local -vv -K

TAGS := all

dotfiles-install:
	$(ANSIBLE_PREFIX) dotfiles.yml

docker-build:
	docker build . -t mokevnin/dotfiles

docker-push:
	docker push mokevnin/dotfiles

docker-bash:
	docker run -it mokevnin/dotfiles bash

nvim-install:
	mkdir -p ~/.config/nvim
	ln -s $(PWD)/files/vimrc ~/.config/nvim/init.vim | true
	ln -s $(PWD)/files/coc-settings.json ~/.config/nvim/coc-settings.json | true

macos-install:
	brew install ripgrep fzf bat htop fd ncdu tldr httpie bash-completion

# .PHONY:
