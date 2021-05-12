## Requirements

* Linux or Mac
* git (for automatic installation)
* make (for automatic installation)
* [Nvim](https://github.com/neovim/neovim/wiki/Installing-Neovim) (version >= 0.4.4)

## Recommendations

* [Oh My Zsh!](https://github.com/ohmyzsh/ohmyzsh)

## Setup

```sh
# or https://github.com/asdf-vm/asdf
curl -sL https://deb.nodesource.com/setup_15.x | bash -

git clone git@github.com:mokevnin/dotfiles.git ~/dotfiles 
cd dotfiles

# ubuntu
make ubuntu-prepare

# macos
make macos-prepare

# configs
make nvim-install

# install all additional packages for languages (See Makefile for install packages for some language)
make deps

# update
make macos-update
make ubuntu-update
```

## VIM

### Update

```vim
:PlugUpdate
:CocCommand java.updateLanguageServer
```

### Main

* Switch `<ctrl>` and `<caps lock>`
* Use `<ctrl> + [` instead of `<Esc>`
* `<leader>` – Space
* `<leader> s` – save current file

### Moving between visible buffers

* `<ctrl> h` – move left or open new left split
* `<ctrl> l` – move right or open new right split
* `<ctrl> k` – move up or open new top split
* `<ctrl> j` – move down or open new bottom split

### File Tree

* `<leader><leader>` – toggle filetree
* `<ctrl> n` – locate opened file in the filetree

### Searching and Navigation

* `<leader> o` – current buffer tags
* `<leader> p` – fuzzy search (files under git)
* `<leader> g` – git grep
* `<leader> b` – show buffer list

### Code editing and code navigation

* `gcc` – toggle commenting
* `gj` – navigate through blocks of code – (), {}, [], etс
* `gf` – open a file corresponding to a word under the cursor
* `gd` – go to definition
* `g;` – go to the last edited line in the current opened buffer
* `gS` – convert oneline expression to multiline (useful for functions, arguments, data structures)
* `gv` – reselect last visual selection
* `<ctrl> n` – insert next matching word (multicursor)
* `]g` and `[g` – go through linter errors
* `"y` & `"p` – copy text to system clipboard
* `]<leader>` and `[<leader>` – add  empty line  above and under cursor
* `<leader> d` – coc diagnostic
* `<leader> f` – format in visual mode (prettier)
* `<leader> fr` – search & replace
* `<leader> rn` – replace word under cursor in current file
