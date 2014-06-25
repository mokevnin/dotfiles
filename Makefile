install: pre ansible

pre:
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
	brew install git ansible
	git clone https://github.com/mokevnin/dotfiles.git ~/dotfiles

ansible:
	ansible-playbook ~/dotfiles/ansible.yml -i ~/dotfiles/local -K -vv

.PHONY: pre ansible
