inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"
nmap <F2> <Plug>(coc-rename)
nnoremap <silent> <F8> :call CocActionAsync('jumpReferences')<CR>
nnoremap <leader>o :CocList outline<CR>
nnoremap <leader>k :call CocAction('doHover')<CR>
nnoremap <leader>f :call CocAction('format')<CR>
vnoremap <leader>f :call CocAction('format')<CR>
nnoremap <leader>f :call FormatFallback()<CR>
vnoremap <leader>f :call Fo matFallback()<CR>
nnoremap <silent> <F12> :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> <leader>d :call CocActionAsync('jumpDeclaration')<CR>
imap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ "\<Tab>"
smap <silent><expr> <TAB> coc#rpc#request('doKeymap', ['snippets-expand-jump',''])
nnoremap <silent> <leader>[ <Plug>(coc-diagnostic-prev)
nnoremap <silent> <leader>] <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>a <Plug>(coc-codeaction)
nnoremap <silent> <leader>gqf <Plug>(coc-fix-current)
nnoremap <silent> <leader>rr <Plug>(coc-refactor)
nnoremap <silent> <leader>gs :call CocActionAsync('jumpDefinition', 'vsplit')<CR>
nnoremap <silent> <leader>gS :call CocActionAsync('jumpDefinition', 'split')<CR>
nnoremap <silent> <leader>gr :CocList references<CR>

