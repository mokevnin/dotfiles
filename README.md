### Requirements

* Linux Or Mac
* git
* python3
* ansible (see http://docs.ansible.com/ansible/intro_installation.html)
* nvim

### Setup

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
