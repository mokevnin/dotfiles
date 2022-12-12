#!/usr/bin/env bash

# set -e

case "$OSTYPE" in
  linux*)
    add-apt-repository -y ppa:neovim-ppa/stable
    apt-get update
    apt install -yy zsh git neovim make neovim git \
      silversearcher-ag ripgrep fd-find fzf bat htop ncdu \
      tldr httpie exuberant-ctags zip build-essential pip

    chsh -s /bin/zsh

    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2 || true
    echo ". \$HOME/.asdf/asdf.sh" > ~/.oh-my-zsh/custom/asdf.zsh
    echo "alias fixssh='eval \$(tmux showenv -s SSH_AUTH_SOCK)'" > ~/.oh-my-zsh/custom/useful.zsh

    # apt install -y haskell-platform golang default-jdk

    # https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
    apt install -yy autoconf bison patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev

    # https://github.com/asdf-community/asdf-php/blob/master/.github/workflows/workflow.yml
    apt install -yy autoconf bison build-essential curl gettext git libgd-dev libcurl4-openssl-dev libedit-dev libicu-dev libjpeg-dev libmysqlclient-dev libonig-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libzip-dev openssl pkg-config re2c zlib1g-dev

    update-alternatives --install /usr/bin/editor editor /usr/bin/vim 100
    ;;
  darwin*)
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null
    yes | brew upgrade asdf neovim git the_silver_searcher fzf bat htop fd ncdu tldr httpie git-delta ripgrep gnu-sed
    ;;
  *)
    echo 'Everything is ready. Go to the next step'
    ;;
esac

sed -i 's/plugins=.*/plugins=\(git vi-mode fzf asdf docker\)/g' ~/.zshrc

git clone https://github.com/mokevnin/dotfiles ~/dotfiles || true

bash -c ". $HOME/.asdf/asdf.sh"

asdf plugin add nodejs
asdf plugin add php
asdf plugin add ruby
asdf plugin add golang
asdf plugin add java

asdf plugin-add lua https://github.com/Stratus3D/asdf-lua.git

asdf install lua latest
asdf global lua latest

asdf install nodejs latest
asdf global nodejs latest

asdf install ruby latest
asdf global ruby latest

asdf install php latest
asdf global php latest

asdf install golang latest
asdf global golang latest

asdf install java openjdk-19.0.1
asdf global java openjdk-19.0.1

# if already existed
asdf update
asdf plugin update --all

export BOOTSTRAP_HASKELL_NONINTERACTIVE=1
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

echo ". \$HOME/.ghcup/env" > ~/.oh-my-zsh/custom/ghcup.zsh

pip install spellcheck yamllint
npm install jsonlint -g
