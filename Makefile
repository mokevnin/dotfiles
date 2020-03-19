# ANSIBLE_PREFIX := docker run -v $(HOME):/host/home -v $(CURDIR):/dotfiles -w /dotfiles williamyeh/ansible:ubuntu18.04 ansible-playbook -i local -vv

all: nvim-install dotfiles-install

TAGS := all

dotfiles-install:
	# $(ANSIBLE_PREFIX) dotfiles.yml
	docker run --rm -e RUNNER_PLAYBOOK=dotfiles.yml -v $(HOME):/host/home -v $(CURDIR):/runner/project ansible/ansible-runner

nvim-install:
	mkdir -p ~/.config/nvim
	ln -s $(PWD)/files/vimrc ~/.config/nvim/init.vim | true
	ln -s $(PWD)/files/coc-settings.json ~/.config/nvim/coc-settings.json | true

macos-prepare:
	brew install the_silver_searcher fzf bat htop fd ncdu tldr httpie

deps-all: deps-gem deps-composer deps-npm

deps-gem:
	gem install solargraph rubocop
	gem install rubocop-rspec rubocop-rails rubocop-performance

deps-composer:
	composer global require "squizlabs/php_codesniffer=*"

deps-npm:
	npm install -g eslint babel-eslint
	npx install-peerdeps -g eslint-config-airbnb
	npm install -g stylelint stylelint-config-recommended stylelint-config-standard
