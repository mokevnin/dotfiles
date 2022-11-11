#!/usr/bin/env bash

case "$OSTYPE" in
  linux*)
    sudo add-apt-repository -y ppa:neovim-ppa/stable
    sudo apt-get update
    apt install -yy zsh git neovim make neovim git \
      silversearcher-ag fd-find fzf bat htop ncdu \
      tldr httpie exuberant-ctags zip build-essential

    chsh -s /bin/zsh

    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2 || true
    echo ". \$HOME/.asdf/asdf.sh" > ~/.oh-my-zsh/custom/asdf.zsh

    # https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
    apt install -yy autoconf bison patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
    ;;
  darwin*)
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew upgrade asdf neovim git the_silver_searcher fzf bat htop fd ncdu tldr httpie git-delta ripgrep gnu-sed
    ;;
  *)
    echo 'Everything is ready. Go to the next step'
    ;;
esac

git clone https://github.com/mokevnin/dotfiles || true

sh "$HOME/.asdf/asdf.sh"

asdf plugin add nodejs
asdf plugin add php
asdf plugin add ruby

asdf install nodejs latest
asdf install ruby latest
asdf install php latest
