all: install nvim-configure deps-install

TAGS := all

install:
	./install.sh

nvim-configure:
	rm -rf ~/.config/nvim
	rm -rf ~/.local/share/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.cache/nvim
	# rm -rf ~/.config/nvim/.git
	ln -snf $(PWD)/nvim ~/.config/nvim

deps-install: deps-gem deps-composer deps-npm deps-pip deps-go

deps-pip:
	# pip2 install --upgrade pynvim
	pip3 install --break-system-packages pynvim
	# pip3 install --upgrade vim-vint spellcheck yamllint codespell ansible-lint
	# pip3 install --upgrade autopep8 flake8 bandit pytype # black

deps-gem:
	gem install --no-document neovim asciidoctor asciidoctor-diagram
	# gem install --no-document solargraph solargraph-rails
	# gem install --no-document rubocop rubocop-rspec rubocop-rails rubocop-performance rubocop-rake
	# gem install --no-document sorbet sorbet-runtime
	# gem install --no-document haml_lint slim_lint erb_lint
	# gem install --no-document brakeman reek

deps-composer:
	# composer --no-interaction global require \
	# 	squizlabs/php_codesniffer \
	# 	phpstan/phpstan
		# phpactor/phpactor

deps-npm:
	npm install -g neovim
	# npm install -g prettier eslint eslint-plugin-import eslint-plugin-node
	# npx install-peerdeps -yg eslint-config-airbnb
	# npm install -g stylelint stylelint-config-recommended stylelint-config-standard
	# npm install -g yaml-language-server markuplint markdownlint-cli bash-language-server jsonlint
	# npm install -g dockerfile-language-server-nodejs

deps-go:
	# go install honnef.co/go/tools/cmd/staticcheck@latest
	# GO111MODULE=on go install golang.org/x/tools/gopls@latest

deps-luarock:
	# luarocks install luacheck

# nvim-log:
# 	tail -f kjj
