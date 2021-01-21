# ANSIBLE_PREFIX := docker run -v $(HOME):/host/home -v $(CURDIR):/dotfiles -w /dotfiles williamyeh/ansible:ubuntu18.04 ansible-playbook -i local -vv

all: nvim-install dotfiles-install

TAGS := all

# dotfiles-install:
# 	# $(ANSIBLE_PREFIX) dotfiles.yml
# 	docker run --rm -e RUNNER_PLAYBOOK=dotfiles.yml -v $(HOME):/host/home -v $(CURDIR):/runner/project ansible/ansible-runner

nvim-install:
	mkdir -p ~/.config/nvim
	ln -s $(PWD)/files/vimrc ~/.config/nvim/init.vim | true
	ln -s $(PWD)/files/coc-settings.json ~/.config/nvim/coc-settings.json | true

macos-prepare:
	brew upgrade neovim git the_silver_searcher fzf bat htop fd ncdu tldr httpie git-delta ripgrep ctags

ubuntu-prepare:
	apt install neovim git silversearcher-ag fd-find fzf bat htop ncdu tldr httpie ripgrep exuberant-ctags

deps: deps-gem deps-composer deps-npm deps-pip

deps-pip:
	# pip2 install --upgrade pynvim
	pip3 install --upgrade pynvim
	pip install --upgrade vim-vint

deps-gem:
	gem install solargraph rubocop neovim
	gem install rubocop-rspec rubocop-rails rubocop-performance rubocop-rake
	gem install sorbet sorbet-runtime
	gem install haml_lint slim_lint
	gem install brakeman reek

deps-composer:
	composer --no-interaction global require \
		squizlabs/php_codesniffer \
		phpstan/phpstan

deps-npm:
	npm install -g neovim
	npm install -g prettier eslint babel-eslint eslint-plugin-import eslint-plugin-node
	npx install-peerdeps -g eslint-config-airbnb
	npm install -g stylelint stylelint-config-recommended stylelint-config-standard
	npm install -g yaml-language-server markdownlint
