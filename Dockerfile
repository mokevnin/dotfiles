FROM alpine:3.9.4

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories
RUN apk update && apk upgrade

ENV HOME /root

RUN apk add --no-cache build-base git curl wget bash ctags
RUN apk add --no-cache libxml2-dev libxslt-dev libgcrypt-dev
RUN apk add --no-cache libffi openssl-dev libffi-dev

RUN apk add --no-cache python3 py-pip python2-dev python3-dev
RUN apk add --no-cache ruby ruby-dev ruby-bundler ruby-json ruby-irb ruby-rake ruby-bigdecimal ruby-rdoc
RUN apk add --no-cache composer php7-simplexml php7-tokenizer php7-xmlwriter
RUN apk add --no-cache inotify-tools elixir erlang erlang-inets erlang-ssl
RUN apk add --no-cache openjdk8-jre
RUN apk add --no-cache neovim
RUN apk add --no-cache tidyhtml
RUN apk add --no-cache the_silver_searcher

RUN composer global config minimum-stability dev
RUN composer global require felixfbecker/language-server
RUN composer run-script --working-dir=/root/.composer/vendor/felixfbecker/language-server parse-stubs
RUN composer global require squizlabs/php_codesniffer
RUN composer global require vimeo/psalm

RUN apk add --no-cache nodejs nodejs-npm
RUN npm config set unsafe-perm true
RUN npm install -g typescript vale
RUN npm install -g eslint babel-eslint \
      eslint-config-airbnb eslint-plugin-jest eslint-plugin-flowtype \
      eslint-plugin-babel eslint-plugin-import eslint-plugin-lodash-fp \
      eslint-plugin-jsx-a11y eslint-plugin-react eslint-config-airbnb-base
RUN npm install -g yaml-language-server typings pug-lint js-yaml js-beautify jsonlint neovim
RUN npm install -g stylelint stylelint-config-recommended
RUN curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

RUN gem install pkg-config solargraph --no-document -- --use-system-libraries
RUN solargraph download-core
RUN yard config --gem-install-yri
RUN gem install rubocop rubocop-rspec rubocop-performance --no-document
RUN gem install haml-lint slim_lint rake neovim --no-document

RUN pip install yamllint ansible-lint python-language-server bashate neovim jedi rope isort # black

RUN curl https://languagetool.org/download/LanguageTool-stable.zip --output languagetool.zip
RUN unzip languagetool.zip && rm -rf languagetool.zip

RUN wget -qO- -O ~/elixir-ls.zip https://github.com/JakeBecker/elixir-ls/releases/download/v0.2.25/elixir-ls.zip \
      && mkdir ~/elixir-ls \
      && unzip ~/elixir-ls.zip -d ~/elixir-ls \
      && rm ~/elixir-ls.zip \
      && chmod +x /root/elixir-ls/language_server.sh

RUN mix local.hex --force

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
      && ~/.fzf/install --key-bindings --update-rc --completion \
      && cp /root/.fzf/bin/fzf /usr/local/bin

RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY files/vimrc /root/.config/nvim/init.vim

ENV PATH $HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH
ENV PATH $HOME/.composer/vendor/bin:$PATH

ENV VERSION 17062019

RUN nvim -i NONE -c PlugInstall -c quitall

COPY languagetool.sh /usr/local/bin/languagetool
RUN chmod +x /usr/local/bin/languagetool

ENV FZF_DEFAULT_COMMAND 'ag -g ""'

COPY files/coc-settings.json /root/.config/nvim/coc-settings.json

CMD ["nvim"]
