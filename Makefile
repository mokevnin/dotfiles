install: prepare provision

prepare:
	sudo apt-get install -y software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install -y ansible
	sudo ansible-galaxy install -ir roles.txt
	# git clone https://github.com/mokevnin/dotfiles.git ~/dotfiles

provision:
	ansible-playbook $(CURDIR)/playbook.yml -i $(CURDIR)/local -K -vv

.PHONY: prepare ansible
