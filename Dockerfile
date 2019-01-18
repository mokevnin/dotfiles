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
      neovim \
      composer \
      nodejs \
      ruby \
      erlang-inets \
      erlang-ssl \
      elixir

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

RUN composer global config minimum-stability dev
RUN composer global require felixfbecker/language-server
RUN composer run-script --working-dir=/root/.composer/vendor/felixfbecker/language-server parse-stubs
RUN composer global require "squizlabs/php_codesniffer=3.4"

RUN npm install -g eslint babel-eslint \
      eslint-config-airbnb eslint-plugin-jest eslint-plugin-flowtype \
      eslint-plugin-babel eslint-plugin-import eslint-plugin-lodash-fp \
      eslint-plugin-jsx-a11y eslint-plugin-react

RUN gem install solargraph

RUN mix local.hex --force


RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


COPY files/vimrc /root/.config/nvim/init.vim

ENV PATH ~/.composer/vendor/bin:$PATH

# RUN nvim -i NONE -c PlugInstall -c quitall > /dev/null 2>&1
