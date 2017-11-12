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

ansible_install_ubuntu:
	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install ansible

# .PHONY:
