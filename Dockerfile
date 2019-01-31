FROM python:3.7.2-alpine3.8

# Better terminal support
# ENV TERM screen-256color
# ENV DEBIAN_FRONTEND noninteractive

RUN apk update && apk upgrade && \
    apk add --no-cache build-base git curl wget bash
RUN apk add --no-cache libxml2-dev libxslt-dev libgcrypt-dev

RUN apk add --no-cache the_silver_searcher
RUN apk add --no-cache ruby ruby-dev ruby-bundler ruby-json ruby-irb ruby-rake ruby-bigdecimal
RUN apk add --no-cache nodejs-current nodejs-npm
RUN apk add --no-cache composer php7-simplexml php7-tokenizer php7-xmlwriter

# # Update and install
# RUN apt-get update && apt-get install -y \
#       curl \
#       wget \
#       git \
#       software-properties-common \
#       python3-dev \
#       python3-pip \
#       locales

# RUN apt-get install -y \
#       shellcheck \
#       ripgrep

# RUN locale-gen en_US.UTF-8
# ENV LANG en_US.UTF-8
# ENV LANGUAGE en_US:en
# ENV LC_ALL en_US.UTF-8

# RUN apt-get install -y ruby-dev zlib1g-dev php-xml
# RUN apt-get install -y php-xml

# RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -

# RUN apt-get update && apt-get install -y \
#       composer \
#       nodejs \
#       ruby \
#       erlang-inets \
#       erlang-ssl \
#       elixir \
#       openjdk-11-jdk


RUN composer global config minimum-stability dev
RUN composer global require felixfbecker/language-server
RUN composer run-script --working-dir=/root/.composer/vendor/felixfbecker/language-server parse-stubs
RUN composer global require squizlabs/php_codesniffer
RUN composer global require vimeo/psalm

RUN npm install -g typescript vale
RUN npm install -g eslint babel-eslint \
      eslint-config-airbnb eslint-plugin-jest eslint-plugin-flowtype \
      eslint-plugin-babel eslint-plugin-import eslint-plugin-lodash-fp \
      eslint-plugin-jsx-a11y eslint-plugin-react eslint-config-airbnb-base

RUN gem install pkg-config solargraph --no-document -- --use-system-libraries

# RUN mix local.hex --force

# RUN pip3 install neovim yamllint bashate
#         # - sexpdata
#         # - python-language-server
#         # - rope
#         # - isort
#         # - black

RUN apk add --no-cache tidyhtml
RUN apk add --no-cache neovim

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
      && ~/.fzf/install --key-bindings --update-rc --completion \
      && cp /root/.fzf/bin/fzf /usr/local/bin

RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


COPY files/vimrc /root/.config/nvim/init.vim

ENV PATH ~/.composer/vendor/bin:$PATH
# ENV FZF_DEFAULT_COMMAND 'ag -g ""'

RUN nvim -i NONE -c PlugInstall -c quitall

CMD ["nvim"]
# # RUN nvim -i NONE -c PlugInstall -c quitall > /dev/null 2>&1
