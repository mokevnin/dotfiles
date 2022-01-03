lua require('config')

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" set mouse=a
set breakindent
set number
set signcolumn=yes
set updatetime=250
set smartcase
set undofile
" set undodir=/tmp/.vim/backups
set ignorecase
set scrolloff=3
" :set numberwidth=1
set completeopt=menu,menuone,noselect
set termguicolors

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

let g:vimsyn_embed = 'l'

colorscheme material

map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Edit .vimrc
map <leader>vl :vsp $MYVIMRC<CR>
map <leader>vr :source $MYVIMRC<CR>

nmap <silent> // :nohlsearch<CR>

nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" TODO: improve n+1 line moving by russian keys
nnoremap <expr> л (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> о (v:count == 0 ? 'gj' : 'j')

" Find files using Telescope command-line sugar
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>sf <cmd>Telescope find_files<cr>
nnoremap <leader>sb <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>sg <cmd>Telescope live_grep<cr>
nnoremap <leader>sd <cmd>Telescope diagnostics<cr>
nnoremap <leader>sc <cmd>Telescope git_commits<cr>
nnoremap <leader>sr <cmd>Telescope lsp_references<cr>
nnoremap <leader>so <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>sa <cmd>Telescope lsp_range_code_actions<cr>
nnoremap <leader>sh <cmd>Telescope help_tags<cr>

nnoremap <leader><leader> :NvimTreeToggle<CR>
nnoremap <C-n> :NvimTreeFindFile<CR>

nnoremap <leader>S :lua require('spectre').open()<CR>

" automatically run :PackerCompile whenever plugins.lua is updated
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua config.lua | PackerCompile
  autocmd BufWritePost config.lua config.lua | PackerCompile
  autocmd BufWritePost *plugins* config.lua | PackerCompile
augroup end

" Highlight on yank
" nnoremap gV `[v`]
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
