" ---------- General ----------
let g:rainbow_active = 1
set backspace=indent,eol,start
" set ruler
set  noruler
set cursorline
set gdefault
set encoding=utf-8
scriptencoding utf-8
set number relativenumber
" Don't use the system clipboard in vim
"set clipboard^=unnamed,unnamedplus
" set mouse=a
if !has('nvim')
  set ttymouse=sgr
endif
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=number
set splitright
set splitbelow
set laststatus=2
" Clear status line when vimrc is reloaded.
set statusline=
" set statusline+=%F
" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2
" allow to switch buffers when not saved
set hidden
set showtabline=2
if has('termguicolors')
  set termguicolors
endif
" yml fix
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


" ---------- Indentation ----------
set tabstop=4
set shiftwidth=4
set expandtab

" ---------- File handling ----------
set directory^=$HOME/tempswap//

" ---------- Search ----------
set ignorecase
set smartcase
set incsearch
set hlsearch
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,\
      \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc,*/node_modules/*,\
      \rake-pipeline-*

" ---------- Visual ----------
set showmatch
set matchtime=2
set listchars=tab:▸▸,trail:•,extends:>,precedes:<

" ---------- Leader & mappings ----------
let mapleader = "\<Space>"
noremap <Space> <Nop>

" ---------- Splits ----------
nmap <F4> :wall<CR>:bufdo bd<CR>:Ex<CR>
map <F5> :!make debug<CR>
map <F7> :make build<CR>
nnoremap <leader>' :vsplit<CR>
nnoremap <leader>5 :split<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>n :tabnext<CR>



" ---------- Misc ----------
filetype plugin indent on
syntax enable
if !has('nvim')
  let g:molokai_original = 1
  " let g:rehash256 = 1
  colorscheme molokai
  " colorscheme catppuccin_mocha
  " let g:lightline = {'colorscheme': 'catppuccin_mocha'}
endif
set noshowmode

" ---------- Build / Make ----------

" ---------- Folds ----------
set foldopen-=hor
set foldopen-=block
set foldopen-=search
set foldmethod=indent
set nofoldenable    " disable folding
" set foldlevel=0

" --- Allow find to work as a file opener ---
set path=
set path+=**
set wildmenu
set wildignore+=*/node_modules/*,*/.git/*,*/build/*
set wildignorecase
"issues with this as it conflicts with scrollingnnoremap <C-p> :find<Space>
" nnoremap <leader>p :find<Space>
set wildoptions=pum
set pumheight=10

" Use <Tab> to jump to next snippet placeholder
set complete-=i
set smarttab
set nrformats-=octal
set ttimeout
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
set ttimeoutlen=100
set scrolloff=1
set sidescroll=1
set sidescrolloff=2
set display+=lastline
set display+=truncate
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif
if has('path_extra') && (',' . &g:tags . ',') =~# ',\./tags,'
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif
set autoread
set history=1000
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif
" Correctly highlight $() and other modern affordances in filetype=sh.
if !exists('g:is_posix') && !exists('g:is_bash') && !exists('g:is_kornshell') && !exists('g:is_dash')
  let g:is_posix = 1
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

autocmd BufRead,BufNewFile terraform.tfvars set filetype=terraform-vars syntax=terraform


"format using COC if we have a formatter, otherwise use the built in
"formatting for the file.
function! FormatFallback()
  if !has('nvim') && CocAction('hasProvider', 'format')
    " Use coc.nvim formatter
    call CocAction('format')
    echo "COC format"
  else
    " Fallback to Vim's built-in formatting for the whole buffer
    let b:PlugView = winsaveview()
    normal! gg=G
    call winrestview(b:PlugView)
    " Fallback to Vim's built-in formatting for the whole buffer
    ":let b:PlugView=winsaveview()<CR>gg=G:call winrestview(b:PlugView) <CR>:echo "file indented"<CR>
    echo "Used Vim fallback formatter"
  endif
endfunction

" ---------- Plugins ----------
" --- Coc.nvim and VScode like ide ---
if !has('nvim')
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
  "fzf and file opening and finding
  nnoremap <leader>p :Files<CR>
  nnoremap <leader>r :Rg<CR>
endif

let $FZF_DEFAULT_OPTS="--preview-window 'right:57%' --preview 'bat --style=numbers --line-range :300 {}'
      \ --bind ctrl-y:preview-up,ctrl-e:preview-down,
      \ctrl-b:preview-page-up,ctrl-f:preview-page-down,
      \ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,
      \shift-up:preview-top,shift-down:preview-bottom,
      \alt-up:half-page-up,alt-down:half-page-down"
