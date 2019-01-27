FROM ubuntu:18.10

# Better terminal support
ENV TERM screen-256color
ENV DEBIAN_FRONTEND noninteractive

# Update and install
RUN apt-get update && apt-get install -y \
      curl \
      wget \
      git \
      software-properties-common \
      python3-dev \
      python3-pip \
      locales

RUN apt-get install -y \
      shellcheck \
      ripgrep

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get install -y ruby-dev zlib1g-dev php-xml
RUN apt-get install -y php-xml

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -

RUN apt-get update && apt-get install -y \
      composer \
      nodejs \
      ruby \
      erlang-inets \
      erlang-ssl \
      elixir \
      openjdk-11-jdk

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

RUN composer global config minimum-stability dev
RUN composer global require felixfbecker/language-server
RUN composer run-script --working-dir=/root/.composer/vendor/felixfbecker/language-server parse-stubs
RUN composer global require squizlabs/php_codesniffer

RUN npm install -g eslint babel-eslint \
      eslint-config-airbnb eslint-plugin-jest eslint-plugin-flowtype \
      eslint-plugin-babel eslint-plugin-import eslint-plugin-lodash-fp \
      eslint-plugin-jsx-a11y eslint-plugin-react eslint-config-airbnb-base

RUN gem install solargraph

RUN mix local.hex --force

RUN pip3 install neovim yamllint bashate
        # - sexpdata
        # - python-language-server
        # - rope
        # - isort
        # - black

RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.3.4/nvim.appimage \
      && chmod u+x nvim.appimage \
      && ./nvim.appimage --appimage-extract
      # && mv ./squashfs-root/usr/bin/nvim /usr/local/bin/nvim

ENV PATH /squashfs-root/usr/bin:$PATH

RUN npm i -g typescript

RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


COPY files/vimrc /root/.config/nvim/init.vim

ENV PATH ~/.composer/vendor/bin:$PATH

# RUN nvim -i NONE -c PlugInstall -c quitall > /dev/null 2>&1
