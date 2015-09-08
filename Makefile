vim:
	ansible-playbook vim.yml -i local -vv -e curdir=$(CURDIR)

update_plugins: vim

TAGS := always

addons:
	ansible-playbook addons.yml -i local -vv -K --tags $(TAGS)

dotfiles:
	ansible-playbook dotfiles.yml -i local -vv --tags $(TAGS)

# .PHONY:
