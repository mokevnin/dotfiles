### Requirements

* Linux or Mac
* make (for automatic installation)
* git (for automatic installation)
* docker

### Setup

#### Manual

1. Create alias _myvim_ using your shell (bash/zsh/whatever) for:

    ```sh
    docker run -it --rm -v /tmp:/tmp:cached -v $HOME/myvim/backups:/root/.vim/backups:cached -v $HOME/myvim/plugged:/root/.vim/plugged:delegated -v `pwd`:/app:delegated -w /app mokevnin/dotfiles nvim'
    ```

1. Run _myvim_ and call `:PlugInstall`.
1. Restart _myvim_

#### Automatic

```sh
$ git clone git@github.com:mokevnin/dotfiles.git && cd dotfiles
$ make myvim-install
# open new terminal
$ myvim

# only first time, run inside nvim
:PlugInstall
# exit
$ myvim
```

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
