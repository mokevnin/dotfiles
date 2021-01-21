" let g:airline#extensions#ale#enabled = 1
let g:ale_disable_lsp = 1

let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_sign_highlight_linenrs = 1
let g:ale_linters = {
\   'haml': ['hamllint'],
\   'slim': ['slimlint'],
\   'ruby': ['brakeman', 'reek'],
\}
