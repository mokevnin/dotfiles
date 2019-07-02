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
	ln -s $(PWD)/files/vimrc ~/.config/nvim/init.vim

macos-install:
	brew install ripgrep fzf bat htop fd ncdu tldr httpie bash-completion

myvim-test:
	docker run -it -w /app -v `pwd`/fixtures:/app -v `pwd`/files/vimrc:/root/.config/nvim/init.vim mokevnin/dotfiles bash


# .PHONY:
