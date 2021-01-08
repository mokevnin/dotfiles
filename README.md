## Requirements

* Linux or Mac
* [Nvim](https://github.com/neovim/neovim/wiki/Installing-Neovim) (version >= 0.3.x)
* make (for automatic installation)
* git (for automatic installation)
* [Node.js](https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions)
* [Docker](https://www.docker.com/get-started) (optional)

### Global

* [Silver Searcher (ag)](https://github.com/ggreer/the_silver_searcher)
* [fzf](https://github.com/junegunn/fzf)
* [bat](https://github.com/sharkdp/bat)
* [fd](https://github.com/sharkdp/fd)

### Debian

```bash
sudo apt-get install neovim make git gcc fzf bat silversearcher-ag
curl -sL https://deb.nodesource.com/setup_15.x | bash -
apt-get install -y nodejs
```

## Setup

```sh
$ git clone git@github.com:mokevnin/dotfiles.git ~/dotfiles 
$ cd dotfiles
$ make nvim-install
$ make dotfiles-install # optional
# install additional packages for some languages (see Makefile)
$ make deps-all #optional
```

## VIM

### Main

* Switch ctrl and caps lock
* Use <kbd>ctrl + [</kbd> instead of <kbd>esc</kdb>

### Moving between visible buffers

* `ctrl h` - move left or open new left split
* `ctrl l` - move right or open new right split
* `ctrl k` - move up or open new top split
* `ctrl j` - move down or open new bottom split
* `<leader> b` - show buffer list

### File Tree

* `<leader><leader>` - toggle filetree

### Searching

* `<leader> o` - fuzzy search (files under git)
* `<leader> ff` - fuzzy search (all files)
* `<leader> fa` - fuzzy search (content in files)
* `<leader> fc` - fuzzy search (git commits)

### Code editing and navigation

* `gcc` - toggle commenting
* `gj` - navigate through blocks of code - (), {}, [], etс
* `gf` - open a file corresponding to a word under the cursor
* `gd` - go to definition
* `]g` and `[g` - go through linter errors
* `<leader>y` & `<leader>p` Copy text to system clipboard
