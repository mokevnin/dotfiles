" https://github.com/preservim/nerdtree

nmap <silent> <leader><leader> :NERDTreeToggle<CR>
" n – navigate
nnoremap <C-n> :NERDTreeFind<CR>

let NERDTreeIgnore = ['\.pyc$', '\.retry$']
