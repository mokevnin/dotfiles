### Requirements

* Linux Or Mac
* git
* python3
* ansible (see http://docs.ansible.com/ansible/intro_installation.html)
* nvim

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

#### Code

* `gcc` - toggle commenting
