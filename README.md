### Install as vagrant provision
    // Vagrantfile
    ansible_script = <<SCRIPT
      sudo apt-get install -y git
      git clone https://github.com/mokevnin/dotfiles.git /var/tmp/dotfiles
      cd /var/tmp/dotfiles
      git pull -f
      make
    SCRIPT
    config.vm.provision 'shell', inline: ansible_script,
      privileged: false

    // Shell
    vagrant provision

### Install without vagrant
    git clone <this repo> /var/tmp/dotfiles
    cd /var/tmp/dotfiles
    make
