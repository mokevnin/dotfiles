### Requirements

* git
* python3
* ansible (see http://docs.ansible.com/ansible/intro_installation.html)
* nvim (see https://github.com/neovim/neovim/wiki/Installing-Neovim)

### Setup

1. Install deps and configs
```
git clone <this repo>
make install // ruby and node for plugins
make configure_nvim
make install_addons
```

1. Install plugins
```
$ nvim
:PlugInstall
```
