" ---------- General ----------
let g:rainbow_active = 1
set backspace=indent,eol,start
set ruler
set cursorline
set gdefault
set encoding=utf-8
scriptencoding utf-8
set number
" Don't use the system clipboard in vim
"set clipboard^=unnamed,unnamedplus
set mouse=a
set ttymouse=sgr
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set splitright
set splitbelow
set laststatus=2
set statusline+=%F
" allow to switch buffers when not saved
set hidden
set showtabline=2
if has('termguicolors')
  set termguicolors
endif
" yml fix
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"format using COC if we have a formatter, otherwise use the built in
"formatting for the file.
function! FormatFallback()
  if CocAction('hasProvider', 'format')
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
"  zoom with leader z , otherwise you have to do ctrl-w | and =
function! s:ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>

" ---------- Plugins ----------
" --- Coc.nvim and VScode like ide ---
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"
nmap <F2> <Plug>(coc-rename)
nmap <F4> :wall<CR>:bufdo bd<CR>:Ex<CR>

map <F5> :!make debug<CR>
map <F7> :make build<CR>
nnoremap <silent> <F8> :call CocActionAsync('jumpReferences')<CR>
nnoremap <leader>o :CocList outline<CR>
" map <F12> <Plug>(coc-definition)
nnoremap <leader>k :call CocAction('doHover')<CR>
" Format current buffer with leader+f
nnoremap <leader>f :call CocAction('format')<CR>
vnoremap <leader>f :call CocAction('format')<CR>
nnoremap <leader>f :call FormatFallback()<CR>
vnoremap <leader>f :call FormatFallback()<CR>
nnoremap <silent> <F12> :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> <leader>d :call CocActionAsync('jumpDeclaration')<CR>


" ---------- Misc ----------
filetype plugin indent on
syntax enable
colorscheme molokai
let g:airline_theme='minimalist'
let g:airline_powerline_fonts=1
let g:airline#extensions#tmuxline#enabled = 0

" ---------- Build / Make ----------

" ---------- Folds ----------
set foldopen-=hor
set foldopen-=block
set foldopen-=search
set foldmethod=indent
set foldlevel=0

" --- Allow find to work as a file opener ---
set path=
set path+=**
set wildmenu
set wildignore+=*/node_modules/*,*/.git/*,*/build/*
set wildignorecase
"issues with this as it conflicts with scrollingnnoremap <C-p> :find<Space>
nnoremap <leader>p :find<Space>
set wildoptions=pum
set pumheight=10

" Use <Tab> to jump to next snippet placeholder
imap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ "\<Tab>"
smap <silent><expr> <TAB> coc#rpc#request('doKeymap', ['snippets-expand-jump',''])
" Make Vim use a transparent background
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi Folded guibg=NONE ctermbg=NONE
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


