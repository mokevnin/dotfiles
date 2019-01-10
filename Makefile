all:
	ansible-playbook all.yml -i local -vv -K

install_languages:
	ansible-playbook install.yml -i local -vv -e curdir=$(CURDIR) -K

install_addons:
	ansible-playbook addons.yml -i local -vv -K --tags $(TAGS)

vim_configure:
	ansible-playbook vim.yml -i local -vvv -e curdir=$(CURDIR) -K

nvim_configure:
	ansible-playbook nvim.yml -i local -vvv -e curdir=$(CURDIR) -K

spacemacs_configure:
	ansible-playbook spacemacs.yml -i local -vv -e curdir=$(CURDIR)

TAGS := all

install_dotfiles:
	ansible-playbook dotfiles.yml -i local -vv

docker-build:
	docker build . -t mokevnin/dotfiles

docker-run:
	docker run -it mokevnin/dotfiles bash

myvim-install:
	docker run -v $(HOME):/host/home -v $(CURDIR):/dotfiles -w /dotfiles williamyeh/ansible:ubuntu18.04 ansible-playbook myvim.yml -i inventory -vv

# .PHONY:
