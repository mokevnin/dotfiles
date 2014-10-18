set nocompatible
filetype off

let mapleader=","

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'

Plugin 'tpope/vim-rvm'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'altercation/vim-colors-solarized'
Plugin 'nanotech/jellybeans.vim'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-dispatch'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'mbbill/undotree'
Plugin 'kchmck/vim-coffee-script'
Plugin 'othree/html5.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'tmatilai/vim-monit'
Plugin 'ervandew/supertab'
Plugin 'jpalardy/vim-slime'
Plugin 'Matt-Deacalion/vim-systemd-syntax'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'fatih/vim-go'
Plugin 'jimenezrick/vimerl'
Plugin 'wting/rust.vim'

Plugin 'elzr/vim-json'
" Plugin 'vim-scripts/JavaScript-Indent'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'moll/vim-node'
Plugin 'mattn/emmet-vim'

Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'

Plugin 'Valloric/MatchTagAlways'

Plugin 'plasticboy/vim-markdown'
" Plugin 'greyblake/vim-preview'

" Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-git'

" Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'

" Plugin 'Shougo/neocomplete.vim'
Plugin 'tpope/vim-endwise'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'Shougo/vimshell.vim'

" Plugin 'chase/vim-ansible-yaml'

Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-leiningen'
Plugin 'tpope/vim-classpath'
Plugin 'tpope/vim-fireplace'
" Plugin 'kien/rainbow_parentheses.vim'
Plugin 'vim-scripts/paredit.vim'

Plugin 'chrisbra/csv.vim'
Plugin 'dotcloud/docker', {'rtp': 'contrib/syntax/vim'}
Plugin 'nginx/nginx', {'rtp': 'contrib/vim'}

call vundle#end()
filetype plugin indent on

" set mouse=a
set cursorline
set hidden
"set modelines=0
" set clipboard=unnamed
"set synmaxcol=128
"set ttyscroll=10
"set encoding=utf-8
set nowrap
set number
"set nowritebackup
"set noswapfile
"set nobackup
set hlsearch
set ignorecase
set smartcase
set tabstop=4
set shiftwidth=4
set expandtab

" set background=dark
set t_Co=256
colorscheme jellybeans

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

let g:slime_target = "tmux"

let g:vim_json_syntax_conceal = 0

" let g:acp_enableAtStartup = 0
" let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_smart_case = 1

" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" if !exists('g:neocomplete#keyword_patterns')
" 	let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'

let g:easytags_async = 1

" Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType ruby setlocal omnifunc=rubycomplete#CompleteTags

let g:buffergator_viewport_split_policy = "B"
let g:buffergator_sort_regime = "mru"

let g:vim_markdown_folding_disabled = 1

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_haml_checkers = ['haml_lint']
let g:syntastic_ruby_checkers = ['rubocop']
" let g:syntastic_erlang_checkers = ['syntaxerl']

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

nmap <F8> :TagbarToggle<CR>
nnoremap <F5> :UndotreeToggle<cr>

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

nmap <C-\> :NERDTreeFind<CR>
nmap <silent> <leader><leader> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

nmap <silent> // :nohlsearch<CR>
noremap ,hl :set hlsearch! hlsearch?<CR>

" Allows you to enter sudo pass and save the file
" " when you forgot to open your file with sudo
cmap w!! %!sudo tee > /dev/null %

" Allow to copy/paste between VIM instances
" "copy the current visual selection to ~/.vbuf
vmap <Leader>y :w! ~/.vbuf<CR>
" "copy the current line to the buffer file if no visual selection
nmap <Leader>y :.w! ~/.vbuf<CR>
" "paste the contents of the buffer file
nmap <Leader>p :r ~/.vbuf<CR>

" Automatically removing all trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
au BufRead,BufNewFile {Vagrantfile,Gemfile,Capfile} set ft=ruby

au FileType ruby setl sw=2 sts=2 et
au FileType javascript setl sw=2 sts=2 et
au FileType yaml setl sw=2 sts=2 et
