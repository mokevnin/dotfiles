all: nvim-install dotfiles-install

TAGS := all

macos-update: macos-prepare deps
	nvim --headless +PlugUpdate +qall
	nvim --headless +CocUpdate +qall

ubuntu-update: ubuntu-prepare deps
	nvim --headless +PlugUpdate +qall
	nvim --headless +CocUpdate +qall

dotfiles-install:
	 docker run --rm -e RUNNER_PLAYBOOK=dotfiles.yml -v $(HOME):/host/home -v $(CURDIR):/runner/project ansible/ansible-runner

nvim-install:
	mkdir -p ~/.config/nvim
	ln -sf $(PWD)/files/vimrc ~/.config/nvim/init.vim
	ln -sf $(PWD)/files/coc-settings.json ~/.config/nvim/coc-settings.json
	ln -snf $(PWD)/files/vim-ftplugins ~/.config/nvim/ftplugin

macos-prepare:
	brew upgrade neovim git the_silver_searcher fzf bat htop fd ncdu tldr httpie git-delta ripgrep
	brew install hashicorp/tap/terraform-ls
	brew install poetry
	brew install --HEAD universal-ctags/universal-ctags/universal-ctags
	# https://github.com/rlue/vim-barbaric
	curl -o /usr/local/bin/xkbswitch https://raw.githubusercontent.com/myshov/xkbswitch-macosx/master/bin/xkbswitch

# ripgrep https://github.com/BurntSushi/ripgrep/issues/1562
ubuntu-prepare:
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(shell lsb_release -cs) main"
	apt-get update
	apt-get install -yy neovim git silversearcher-ag fd-find fzf bat htop ncdu tldr httpie exuberant-ctags terraform-ls

deps: deps-gem deps-composer deps-npm deps-pip

deps-pip:
	# pip2 install --upgrade pynvim
	pip3 install --upgrade pynvim
	pip3 install --upgrade vim-vint
	pip3 install --upgrade autopep8 flake8 bandit pytype # black

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
	npm install -g prettier eslint @babel/eslint-parser eslint-plugin-import eslint-plugin-node
	npx install-peerdeps -g eslint-config-airbnb
	npm install -g stylelint stylelint-config-recommended stylelint-config-standard
	npm install -g yaml-language-server markdownlint bash-language-server
	npm install -g dockerfile-language-server-nodejs
