" Mappings for CoCList + CocFzf
" Show all diagnostics.
"nnoremap <silent><nowait> <space>d  :<C-u>CocFzfList diagnostics<cr>
" Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
"nnoremap <silent> <space>o :<C-u>CocFzfList outline<CR>
"nnoremap <silent> <space>l :<C-u>CocFzfList location<CR>
" Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"call coc_fzf#common#add_list_source('fzf-buffers', 'display open buffers', 'Buffers')
"call coc_fzf#common#add_list_source('fzf-ggrep', 'git grep', 'GGrep')
"call coc_fzf#common#add_list_source('fzf-gfiles', 'display git files', 'GFiles --cached --others --exclude-standard')

"nnoremap <silent><nowait> <leader>b  :<C-u>CocFzfList fzf-buffers<CR>
"nnoremap <silent><nowait> <leader>p  :<C-u>CocFzfList fzf-gfiles<CR>
"nnoremap <silent><nowait> <leader>g  :<C-u>CocFzfList fzf-ggrep<CR>
