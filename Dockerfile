FROM alpine:3.9

RUN apk update && apk upgrade && \
    apk add --no-cache build-base git curl wget bash
RUN apk add --no-cache libxml2-dev libxslt-dev libgcrypt-dev

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories
RUN apk update && apk upgrade

RUN apk add --no-cache the_silver_searcher
RUN apk add --no-cache python3 py-pip
RUN apk add --no-cache ruby ruby-dev ruby-bundler ruby-json ruby-irb ruby-rake ruby-bigdecimal
RUN apk add --no-cache composer php7-simplexml php7-tokenizer php7-xmlwriter
RUN apk add --no-cache inotify-tools elixir erlang erlang-inets erlang-ssl
RUN apk add --no-cache nodejs nodejs-npm


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
RUN npm install -g yaml-language-server typings pug-lint js-yaml js-beautify jsonlint neovim
RUN npm install -g stylelint stylelint-config-recommended
# import-js

RUN gem install pkg-config solargraph --no-document -- --use-system-libraries
RUN solargraph download-core
RUN gem install rubocop rubocop-rspec rubocop-performance --no-document
RUN gem install haml-lint slim_lint rake neovim --no-document

RUN apk add --no-cache libffi python2-dev python3-dev openssl-dev libffi-dev
RUN pip install yamllint ansible-lint python-language-server bashate neovim jedi rope isort # black

RUN apk add --no-cache tidyhtml
RUN apk add --no-cache neovim

RUN wget -qO- -O ~/elixir-ls.zip https://github.com/JakeBecker/elixir-ls/releases/download/v0.2.24/elixir-ls.zip \
      && mkdir ~/elixir-ls \
      && unzip ~/elixir-ls.zip -d ~/elixir-ls

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
      && ~/.fzf/install --key-bindings --update-rc --completion \
      && cp /root/.fzf/bin/fzf /usr/local/bin

RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY files/vimrc /root/.config/nvim/init.vim

ENV PATH ~/.composer/vendor/bin:$PATH

ENV VERSION 13022019

RUN nvim -i NONE -c PlugInstall -c quitall

ENV FZF_DEFAULT_COMMAND 'ag -g ""'

CMD ["nvim"]
