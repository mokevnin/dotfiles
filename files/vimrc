setglobal nocompatible
setglobal pastetoggle=<F2>

set ttyfast
set lazyredraw

" let g:python_host_skip_check=1
" let g:loaded_python3_provider=1

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'liuchengxu/vista.vim'
Plug 'honza/vim-snippets'
Plug 'mhinz/vim-startify'
" Plug 'neomake/neomake'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'lxhillwind/leader-clipboard'
Plug 'ntpeters/vim-better-whitespace'
" Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'chr4/nginx.vim'
Plug 'janko-m/vim-test'
" Plug 'jlanzarotta/bufexplorer'
Plug 'lepture/vim-jinja', { 'for': 'jinja' }
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'tpope/vim-surround'
Plug 'isobit/vim-caddyfile'

" Targets.vim comes with five kinds for text objects:
" Pair text objects
" Quote text objects
" Separator text objects
" Argument text objects
" Tag text objects
Plug 'wellle/targets.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'nanotech/jellybeans.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-projectionist'
Plug 'othree/html5.vim'
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'slim-template/vim-slim', { 'for': ['slim', 'slime'] }
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
Plug 'c-brenn/phoenix.vim', { 'for': 'elixir' }
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-erlang/vim-erlang-runtime', { 'for': 'erlang' }
Plug 'vim-erlang/vim-erlang-compiler', { 'for': 'erlang' }
" Auto close parentheses and repeat by dot dot dot...
Plug 'cohama/lexima.vim'

Plug 'jwalton512/vim-blade', { 'for': 'php' }
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
Plug 'noahfrederick/vim-composer', { 'for': 'php' }
Plug 'noahfrederick/vim-laravel', { 'for': 'php' }

Plug 'joonty/vdebug', { 'on': 'VdebugStart' }
Plug 'rhysd/vim-clang-format', { 'for': ['c', 'cpp'] }
" Plug 'tpope/vim-ragtag'

" Plug 'eagletmt/ghcmod-vim'
" Plug 'eagletmt/ghcmod-vim'
" Plug 'neovimhaskell/haskell-vim'

Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
" Plug 'moll/vim-node'
" Plug 'mattn/emmet-vim', { 'for': 'html' }

" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-easytags'
" Plug 'Valloric/MatchTagAlways'

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

Plug 'tpope/vim-haml', { 'for': 'haml' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
" Plug 'michaeljsmith/vim-indent-object'

" Clojure
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
Plug 'tpope/vim-classpath', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'venantius/vim-eastwood', { 'for': 'clojure' }

Plug 'kovisoft/slimv', { 'for': ['clojure', 'scheme', 'racket'] }
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }

" Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
" Plug 'henrik/vim-yaml-flattener'

Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
      \ 'coc-tabnine',
      \ 'coc-cspell-dicts',
      \ 'coc-spell-checker',
      \ 'coc-tsserver',
      \ 'coc-prettier',
      \ 'coc-html',
      \ 'coc-lists',
      \ 'coc-phpls',
      \ 'coc-sh',
      \ 'coc-css',
      \ 'coc-stylelint',
      \ 'coc-vimlsp',
      \ 'coc-go',
      \ 'coc-elixir',
      \ 'coc-json',
      \ 'coc-eslint',
      \ 'coc-python',
      \ 'coc-java',
      \ 'coc-jest',
      \ 'coc-solargraph',
      \ 'coc-yaml',
      \ 'coc-highlight',
      \ 'coc-snippets',
      \ 'coc-docker',
      \ 'coc-diagnostic',
      \]

call plug#end()

" set rtp+=/root/.fzf

let mapleader = "\<Space>"

" https://github.com/vim/vim/blob/master/runtime/doc/russian.txt
" Enable hotkeys for Russian layout
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" set visualbell
set completeopt=noinsert,menuone,noselect
set complete+=kspell

if has('mouse')
  set mouse=a
endif

" if has("clipboard")
"   set clipboard=unnamed " copy to the system clipboard

"   if has("unnamedplus") " X11 support
"     set clipboard+=unnamedplus
"   endif
" endif

" Don't redraw while executing macros (good performance config)
set lazyredraw
set ttyfast

set shortmess+=c

set cursorline
set hidden
set nofoldenable
set wrap
set linebreak
set number
set hlsearch
set ignorecase
set smartcase

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
set nowb
set noswapfile

set showcmd       " display incomplete commands
set autowrite     " Automatically :write before running commands

" Use one space, not two, after punctuation.
" set nojoinspaces

" set softtabstop=4
set expandtab
" set noexpandtab
set softtabstop=2
set shiftwidth=2

set updatetime=300
set splitbelow
set cmdheight=2
set signcolumn=no
set scrolloff=3

silent! colorscheme jellybeans

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir /tmp/.vim/backups > /dev/null 2>&1
  set undodir=/tmp/.vim/backups
  set undofile
endif

""" Basics Keymaps

" Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with line wrapping on, this can cause the cursor to actually skip a few lines on the screen because it's moving from line N to line N+1 in the file. I want this to act more visually -- I want `down' to mean the next line on the screen
nmap j gj
nmap k gk

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Edit .vimrc
map <leader>vl :vsp $MYVIMRC<CR>
map <leader>vr :source $MYVIMRC<CR>

""" Plugins Keymaps

nmap <C-m> :NERDTreeFind<CR>
nmap <silent> <leader><leader> :NERDTreeToggle<CR>

nnoremap <leader>b :Buffers<CR>

""" Plugin Settings

let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toc_autofit = 1

let g:vista_default_executive = 'coc'

nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

let test#strategy = "neovim"

let g:vim_markdown_folding_disabled = 1

" format the entire file
nnoremap ff :normal! gg=G``<CR>

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :GFiles .<CR>
nnoremap <leader>fc :Commits<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fa :Ag<CR>

let NERDTreeIgnore = ['\.pyc$', '\.retry$']

nmap <silent> // :nohlsearch<CR>
noremap <leader>hl :set hlsearch! hlsearch?<CR>

" Allows you to enter sudo pass and save the file
" " when you forgot to open your file with sudo
cmap w!! %!sudo tee > /dev/null %

" nnoremap <silent> <bs> <C-w><Left>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" if filereadable(expand("~/.vimrc.after"))
"   source ~/.vimrc.after
" endif

" https://thoughtbot.com/blog/vim-spell-checking
" augroup markdownSpell
"     autocmd!
"     autocmd FileType markdown setlocal spell
"     autocmd BufRead,BufNewFile *.md setlocal spell
" augroup END

augroup FileTypeTetect
  autocmd!
  " au BufEnter *.markdown,*.mkd,*.md setl wrap tw=79
  " au BufEnter *.json setl ft=javascript
  " au BufEnter *.coffee setl sw=2 expandtab
  " au BufEnter *.py setl ts=4 sw=4 sts=4
  " autocmd BufEnter *.php setlocal ts=4 sw=4 sts=4
  filetype plugin indent on
  autocmd BufEnter *.java setlocal ts=4 sw=4 sts=4
  autocmd BufEnter Makefile setlocal ts=4 sw=4 noexpandtab
  autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
  autocmd BufNewFile,BufRead *.slime setlocal filetype=slim
  autocmd BufNewFile,BufRead *.jsh setlocal filetype=java

  " au BufEnter *.js setl ts=2 sw=2 sts=2
  " au BufEnter *.html setl ts=4 sw=4 sts=4
  " au BufEnter *.tex setl wrap tw=79 fo=tcqor
  " au BufEnter *.[ch] setl cindent
  " au BufEnter *.[ch]pp setl cindent
  " au BufEnter Makefile setl ts=4 sts=4 sw=4 noet list
  " au BufEnter *.es6 setf javascript
augroup END

"""" COC

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:coc_snippet_next = '<tab>'

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
"
" " Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

"" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

"" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

"" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

"" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

vmap <leader>y :w! /tmp/.vim/.vbuf<CR>
nmap <leader>y :.w! /tmp/.vim/.vbuf<CR>
nmap <leader>p :r /tmp/.vim/.vbuf<CR>
