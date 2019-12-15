# ANSIBLE_PREFIX := docker run -v $(HOME):/host/home -v $(CURDIR):/dotfiles -w /dotfiles williamyeh/ansible:ubuntu18.04 ansible-playbook -i local -vv

all: nvim-install dotfiles-install

TAGS := all

dotfiles-install:
	# $(ANSIBLE_PREFIX) dotfiles.yml
	docker run --rm -e RUNNER_PLAYBOOK=dotfiles.yml -v $(HOME):/host/home -v $(CURDIR):/runner/project ansible/ansible-runner

nvim-install:
	mkdir -p ~/.config/nvim
	ln -s $(PWD)/files/vimrc ~/.config/nvim/init.vim | true
	ln -s $(PWD)/files/coc-settings.json ~/.config/nvim/coc-settings.json | true

macos-prepare:
	brew install ripgrep fzf bat htop fd ncdu tldr httpie bash-completion

# docker-build:
# 	docker build . -t mokevnin/dotfiles
# docker-push:
# 	docker push mokevnin/dotfiles
# docker-bash:
# 	docker run -it mokevnin/dotfiles bash

# .PHONY:
