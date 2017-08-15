### Requirements

* Ubuntu 16.04
* git
* python3
* ansible (see http://docs.ansible.com/ansible/intro_installation.html)
* vim

### Setup

1. Install deps and configs
  ```shell
  git clone <this repo>
  make install_languages // ruby and node for plugins
  make vim_configure
  make install_addons
  ```

1. Install plugins
  ```
  $ vim
  :PlugInstall

  cd ~/.vim/plugged/YouCompleteMe
  ./install.py --all
  ```

1. Restart vim
