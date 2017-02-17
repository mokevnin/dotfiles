all:
	ansible-playbook all.yml -i local -vv -K


configure_vim:
	ansible-playbook vim.yml -i local -vv -e curdir=$(CURDIR) -K

configure_spacemacs:
	ansible-playbook spacemacs.yml -i local -vv -e curdir=$(CURDIR) -K

# update_plugins: vim

TAGS := always

install_addons:
	ansible-playbook addons.yml -i local -vv -K --tags $(TAGS)

install_dotfiles:
	ansible-playbook dotfiles.yml -i local -vv

install_ansible:
	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install ansible

# .PHONY:
