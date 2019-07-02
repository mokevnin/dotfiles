### Requirements

* Linux or Mac
* [Nvim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
* make (for automatic installation)
* git (for automatic installation)
* [Node.js](https://nodejs.org/en/download/package-manager/) 

    curl -sL install-node.now.sh | sh

#### Ruby

* gem install solargraph rubocop

#### PHP

* composer global require "squizlabs/php_codesniffer=*"

### Setup

```sh
$ git clone git@github.com:mokevnin/dotfiles.git ~/dotfiles 
$ cd dotfiles
$ make nvim-install
$ make dotfiles-install # optional
```

### VIM

#### Main

* Switch ctrl and caps lock
* Use <kbd>ctrl + [</kbd> instead of <kbd>esc</kdb>

#### Moving between visible buffers

* `ctrl h` - move left or open new left split
* `ctrl l` - move right or open new right split
* `ctrl k` - move up or open new top split
* `ctrl j` - move down or open new bottom split
* `<leader> b` - show buffer list

#### File Tree

* `<leader><leader>` - toggle filetree

#### Searching

* `<leader> o` - fuzzy search (files under git)
* `<leader> ff` - fuzzy search (all files)
* `<leader> fa` - fuzzy search (content in files)
* `<leader> fc` - fuzzy search (content in files)

#### Code editing and navigation

* `gcc` - toggle commenting
* `gj` - navigate through blocks of code - (), {}, [], etс
* `gf` - open a file corresponding to a word under the cursor
* `gd` - go to definition
* `]r` and `[r` - go through linter errors
* `<leader>y` & `<leader>p` Copy text to system clipboard
