### Requirements

* ansible (see http://docs.ansible.com/ansible/intro_installation.html)
* vim
* git

### Install
    git clone <this repo>
    make install_ansible // if you don't have ansible yet
    make configure_vim

### Install addons (linters, checkers)
    make install_addons // optional TAGS variable accepted, see addons.yml for details

### Setup dotfiles
    make install_dotfiles
