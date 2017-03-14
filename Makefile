all:
	ansible-playbook all.yml -i local -vv -K

install:
	ansible-playbook install.yml -i local -vv -e curdir=$(CURDIR) -K

configure_vim:
	ansible-playbook vim.yml -i local -vvv -e curdir=$(CURDIR) -K

configure_spacemacs:
	ansible-playbook spacemacs.yml -i local -vv -e curdir=$(CURDIR)

# update_plugins: vim

TAGS := all

install_addons:
	ansible-playbook addons.yml -i local -vv -K --tags $(TAGS)

install_dotfiles:
	ansible-playbook dotfiles.yml -i local -vv

install_ansible:
	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install ansible

install_nvim_ubuntu:
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
