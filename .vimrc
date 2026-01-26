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

" " ---------- File handling ----------
" set directory^=$HOME/tempswap//

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
  colorscheme molokai
endif
set noshowmode

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
set autoread
set history=1000

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
    echo "Used Vim fallback formatter"<CR>
  endif
endfunction

if !has('nvim')
  source ~/.vim/coc_config.vim
  source ~/.vim/fzf_config.vim
endif

