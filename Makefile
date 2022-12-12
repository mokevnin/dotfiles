all: install nvim-configure deps

TAGS := all

PACKER_PATH=~/.local/share/nvim/site/pack/packer/start

install:
	./install.sh

nvim-configure:
	rm -rf nvim/plugin || exit 0
	rm -rf ~/.local/share/nvim || exit 0
	rm -rf ~/.config/nvim || exit 0
	rm -rf $(PACKER_PATH) || exit 0
	mkdir -p ~/.config
	mkdir -p $(PACKER_PATH)
	git clone --depth 1 https://github.com/wbthomason/packer.nvim $(PACKER_PATH)/packer.nvim
	ln -snf $(PWD)/nvim ~/.config/nvim
	# nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

deps-install: deps-gem deps-composer deps-npm deps-pip deps-go

deps-pip:
	# pip2 install --upgrade pynvim
	pip3 install --upgrade pynvim
	pip3 install --upgrade vim-vint
	pip3 install --upgrade autopep8 flake8 bandit pytype # black

deps-gem:
	gem install --no-document neovim
	gem install --no-document solargraph solargraph-rails
	gem install --no-document rubocop rubocop-rspec rubocop-rails rubocop-performance rubocop-rake
	gem install --no-document sorbet sorbet-runtime
	gem install --no-document haml_lint slim_lint
	gem install --no-document brakeman reek

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

# nvim-log:
# 	tail -f kjj
