install: prepare provision

prepare:
	# sudo apt-get install -y software-properties-common
	# sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	# sudo apt-get install -y ansible
	sudo apt-get -y install python-pip
	sudo pip install ansible
	sudo ansible-galaxy install -ifr roles.txt
	# git clone https://github.com/mokevnin/dotfiles.git ~/dotfiles

provision:
	ansible-playbook $(CURDIR)/playbook.yml -i $(CURDIR)/local -vv # -K only without vagrant

.PHONY: prepare ansible
