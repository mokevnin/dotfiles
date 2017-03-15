all:
	ansible-playbook all.yml -i local -vv -K

install_languages:
	ansible-playbook install.yml -i local -vv -e curdir=$(CURDIR) -K

install_addons:
	ansible-playbook addons.yml -i local -vv -K --tags $(TAGS)

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

nvim_install_ubuntu:
	sudo apt install -yq python3-dev python3-pip
	sudo add-apt-repository ppa:neovim-ppa/stable
	sudo apt update
	sudo apt install -yq neovim
	sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
	sudo update-alternatives --config vi
	sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
	sudo update-alternatives --config vim
	sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
	sudo update-alternatives --config editor

# .PHONY:
