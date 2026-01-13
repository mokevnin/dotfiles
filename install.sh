#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

trap 'echo "[install] error at line $LINENO" >&2' ERR

case $OSTYPE in
linux*)
	echo "[install] Linux setup"
	add-apt-repository -y ppa:neovim-ppa/stable
	apt-get update
	apt-get install -y zsh git neovim make \
		silversearcher-ag ripgrep fd-find fzf bat htop ncdu \
		tldr httpie exuberant-ctags zip build-essential python3-pip

	[[ "${SHELL:-}" == "/bin/zsh" ]] || chsh -s /bin/zsh

	# apt-get install -y haskell-platform golang default-jdk

	# https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
	apt-get install -y autoconf bison patch build-essential rustc libssl-dev libyaml-dev \
		libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev \
		libgdbm6 libgdbm-dev libdb-dev uuid-dev

	# https://github.com/asdf-community/asdf-php/blob/master/.github/workflows/workflow.yml
	# apt-get install -y autoconf bison build-essential curl gettext git libgd-dev \
	# 	libcurl4-openssl-dev libedit-dev libicu-dev libjpeg-dev \
	# 	libmysqlclient-dev libonig-dev libpng-dev libpq-dev libreadline-dev \
	# 	libsqlite3-dev libssl-dev libxml2-dev libzip-dev openssl pkg-config \
	# 	re2c zlib1g-dev

	update-alternatives --install /usr/bin/editor editor /usr/bin/vim 100

	apt-get install -y shellcheck
	;;
darwin*)
	echo "[install] macOS setup"
	command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$("$(brew --prefix)/bin/brew" shellenv)"
	brew install jesseduffield/lazygit/lazygit

	brew install mise neovim git the_silver_searcher fzf bat htop fd ncdu \
		tldr httpie git-delta ripgrep gnu-sed wget overmind
	brew install viu chafa sox ast-grep
	brew install pandoc actionlint shellcheck checkmake lazygit markdownlint-cli2
	# brew install lua nodejs golang php composer luarocks ruby
	brew install --cask temurin

	# https://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e
	brew install font-ubuntu-nerd-font
	brew install font-hack-nerd-font

	grep -Fqx 'eval "$(mise activate zsh)"' "$HOME/.zshrc" || echo 'eval "$(mise activate zsh)"' >>"$HOME/.zshrc"
	;;
*)
	echo 'Everything is ready. Go to the next step'
	;;
esac

[[ -d "$HOME/.oh-my-zsh" ]] || RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
[[ -f "$HOME/.zshrc" ]] && sed -i.bak 's/^plugins=.*$/plugins=(git mise vi-mode fzf docker docker-compose you-should-use)/' "$HOME/.zshrc"

mkdir -p "$HOME/.oh-my-zsh/custom"
grep -Fqx "alias fixssh='eval \$(tmux showenv -s SSH_AUTH_SOCK)'" "$HOME/.oh-my-zsh/custom/useful.zsh" || \
	echo "alias fixssh='eval \$(tmux showenv -s SSH_AUTH_SOCK)'" >>"$HOME/.oh-my-zsh/custom/useful.zsh"

# git clone https://github.com/mokevnin/dotfiles ~/dotfiles

# mise use --global ruby@latest
# mise use --global nodejs@latest

REPO="$HOME/.oh-my-zsh/custom/plugins/you-should-use"
[[ -d "$REPO/.git" ]] && git -C "$REPO" pull || git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$REPO"
