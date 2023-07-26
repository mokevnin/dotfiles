## Requirements

* Linux or Mac
* git (for automatic installation)
* make (for automatic installation)
* [Nvim](https://github.com/neovim/neovim/wiki/Installing-Neovim) (version >= 0.4.4)

## Recommendations

* [Oh My Zsh!](https://github.com/ohmyzsh/ohmyzsh)

## Setup

```sh
sh -c "$(wget -O- https://raw.githubusercontent.com/mokevnin/dotfiles/main/install.sh)"

# or
git clone git@github.com:mokevnin/dotfiles.git
make install # same when updating

# configure nvim
make nvim-configure

# install all additional packages for languages (See Makefile for install packages for some language)
make deps-install
```

## VIM

https://www.lazyvim.org/

surround
autopairs

