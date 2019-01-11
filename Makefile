ANSIBLE_PREFIX := docker run -e "HOST_USER=$(USER)" -v $(HOME):/host/home -v $(CURDIR):/dotfiles -w /dotfiles williamyeh/ansible:ubuntu18.04 ansible-playbook -i local -vv

all: myvim-install
	# ansible-playbook all.yml -i local -vv -K

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
	$(ANSIBLE_PREFIX) dotfiles.yml

docker-build:
	docker build . -t mokevnin/dotfiles

docker-run:
	docker run -it mokevnin/dotfiles bash

myvim-install:
	$(ANSIBLE_PREFIX) myvim.yml

# .PHONY:
