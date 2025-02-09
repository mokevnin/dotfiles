#!/usr/bin/env bash

set -e

# SCRIPT_DIR="$(dirname "$0")"

case $OSTYPE in
linux*)
	add-apt-repository -y ppa:neovim-ppa/stable
	apt-get update
	apt install -yy zsh git neovim make neovim git \
		silversearcher-ag ripgrep fd-find fzf bat htop ncdu \
		tldr httpie exuberant-ctags zip build-essential pip

	chsh -s /bin/zsh

	# apt install -y haskell-platform golang default-jdk

	# https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
	apt install -yy autoconf bison patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev

	# https://github.com/asdf-community/asdf-php/blob/master/.github/workflows/workflow.yml
	# apt install -yy autoconf bison build-essential curl gettext git libgd-dev libcurl4-openssl-dev libedit-dev libicu-dev libjpeg-dev libmysqlclient-dev libonig-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libzip-dev openssl pkg-config re2c zlib1g-dev

	update-alternatives --install /usr/bin/editor editor /usr/bin/vim 100

        apt install -yy shellcheck

	;;
darwin*)
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew install jesseduffield/lazygit/lazygit

	yes | brew install mise neovim git the_silver_searcher fzf bat htop fd ncdu tldr httpie git-delta ripgrep gnu-sed wget
	yes | brew install viu chafa sox ast-grep asciidoctor
	yes | brew install pandoc actionlint shellcheck checkmake lazygit markdownlint-cli2
  yes | brew install lua nodejs golang php composer luarocks ruby
  yes | brew install --cask temurin

  # https://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e
  yes | brew install font-ubuntu-nerd-font
	;;
*)
	echo 'Everything is ready. Go to the next step'
	;;
esac

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
sed -i'.bak' 's/^plugins=.*$/plugins=(git mise vi-mode fzf docker docker-compose you-should-use)/' ~/.zshrc
# https://mise.jdx.dev/getting-started.html
echo "alias fixssh='eval \$(tmux showenv -s SSH_AUTH_SOCK)'" >~/.oh-my-zsh/custom/useful.zsh

# git clone https://github.com/mokevnin/dotfiles ~/dotfiles || true

# mise use --global ruby@latest
# mise use --global nodejs@latest
#

REPO="$HOME/.oh-my-zsh/custom/plugins/you-should-use"
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$REPO" || true
git -C "$REPO" pull
