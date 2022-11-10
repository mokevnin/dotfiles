all: nvim-install dotfiles-install

TAGS := all

# macos-update: macos-prepare deps
# 	nvim --headless +PlugUpdate +qall
# 	nvim --headless +CocUpdate +qall

# ubuntu-update: ubuntu-prepare deps
# 	nvim --headless +PlugUpdate +qall
# 	nvim --headless +CocUpdate +qall

dotfiles-install:
	 docker run --rm -e RUNNER_PLAYBOOK=dotfiles.yml -v $(HOME):/host/home -v $(CURDIR):/runner/project ansible/ansible-runner

PACKER_PATH=~/.local/share/nvim/site/pack/packer/start

nvim-install:
	rm -rf nvim/plugin || exit 0
	rm -rf ~/.local/share/nvim || exit 0
	rm -rf ~/.config/nvim || exit 0
	rm -rf $(PACKER_PATH) || exit 0
	mkdir -p ~/.config
	mkdir -p $(PACKER_PATH)
	git clone --depth 1 https://github.com/wbthomason/packer.nvim $(PACKER_PATH)/packer.nvim
	ln -snf $(PWD)/nvim ~/.config/nvim
	nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

macos-prepare:
	brew upgrade neovim git the_silver_searcher fzf bat htop fd ncdu tldr httpie git-delta ripgrep gnu-sed
	# brew install hashicorp/tap/terraform-ls
	# brew install poetry
	# brew install --HEAD universal-ctags/universal-ctags/universal-ctags
	# https://github.com/rlue/vim-barbaric
	# curl -o /usr/local/bin/xkbswitch https://raw.githubusercontent.com/myshov/xkbswitch-macosx/master/bin/xkbswitch

# ripgrep https://github.com/BurntSushi/ripgrep/issues/1562
ubuntu-prepare:
	sudo add-apt-repository -y ppa:neovim-ppa/stable
	sudo apt-get update
	sudo apt-get install neovim
	# curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	# apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(shell lsb_release -cs) main"
	apt-get install -yy neovim git silversearcher-ag fd-find fzf bat htop ncdu tldr httpie exuberant-ctags zsh

	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2 || exit 0
	# $(shell . $(HOME)/.asdf/asdf.sh)
	# . $HOME/.asdf/completions/asdf.bash
	chsh -s /bin/zsh
	$(shell sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)")



deps: deps-gem deps-composer deps-npm deps-pip deps-go

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
		# phpactor/phpactor

deps-npm:
	npm install -g neovim
	npm install -g prettier eslint @babel/eslint-parser eslint-plugin-import eslint-plugin-node
	npx install-peerdeps -g eslint-config-airbnb
	npm install -g stylelint stylelint-config-recommended stylelint-config-standard
	npm install -g yaml-language-server markdownlint bash-language-server
	npm install -g dockerfile-language-server-nodejs

deps-go:
	go install honnef.co/go/tools/cmd/staticcheck@latest
	GO111MODULE=on go install golang.org/x/tools/gopls@latest
