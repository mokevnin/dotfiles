### Requirements

* Ubuntu 16.04
* git
* python3
* ansible (see http://docs.ansible.com/ansible/intro_installation.html)
```
make ansible_install_ubuntu
```
* nvim (see https://github.com/neovim/neovim/wiki/Installing-Neovim)
```
make nivm_install_ubuntu
```

### Setup

1. Install deps and configs
  ```shell
  git clone <this repo>
  make install_languages // ruby and node for plugins
  make nvim_configure
  make install_addons
  ```

1. Install plugins
  ```
  $ nvim
  :PlugInstall
  ```

1. Restart nvim
