### Requirements

* Linux Or Mac
* git
* python3
* install ansible via `pip3 install ansible` (correct way to make ansible to use python3 - see [this link](https://docs.ansible.com/ansible/2.6/reference_appendices/python_3_support.html#on-the-controller-side) for explanations)
* nvim (min. 0.3.1)

### Setup

1. install https://github.com/ggreer/the_silver_searcher
1. Install deps and configs

```sh
$ git clone <this repo>
$ make install_languages # ruby and node for plugins
$ make nvim_configure
$ make install_addons
```

2. Install plugins

```sh
$ nvim
:PlugInstall
```

3. Restart vim

### VIM

#### Main

* Switch ctrl and caps lock
* Use <kbd>ctrl + [</kbd> instead of <kbd>esc</kdb>

#### Moving between visible buffers

* `ctrl h` - left
* `ctrl l` - right
* `ctrl k` - up
* `ctrl j` - down
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
