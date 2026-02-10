hi StatusModified ctermfg=black ctermbg=red guifg=black guibg=#e06c75
" Update colors for status bar when we change modes
function! UpdateModeHL()
  let m = mode()
  if m ==# 'n'
    hi ModeSegmentHL ctermfg=black ctermbg=green   guifg=black guibg=#98c379
  elseif m ==# 'i'
    hi ModeSegmentHL ctermfg=black ctermbg=blue    guifg=black guibg=#61afef
  elseif m ==# 'v' || m ==# 'V' || m ==# "\<C-v>"
    hi ModeSegmentHL ctermfg=black ctermbg=yellow  guifg=black guibg=#e5c07b
  elseif m ==# 'R'
    hi ModeSegmentHL ctermfg=black ctermbg=red     guifg=black guibg=#e06c75
  else
    hi ModeSegmentHL ctermfg=black ctermbg=magenta guifg=black guibg=#c678dd
  endif
endfunction
"Run it when mode changes in vim
augroup ModeSegmentColors
  autocmd!
  autocmd ModeChanged * call UpdateModeHL()
augroup END
" Gets the name to display
function! ModeSegment()
  let m = mode()
  if m ==# 'n'
    return ' NORMAL '
  elseif m ==# 'i'
    return ' INSERT '
  elseif m ==# 'v' || m ==# 'V' || m ==# "\<C-v>"
    return ' VISUAL '
  elseif m ==# 'R'
    return ' REPLACE '
  else
    return ' EX '
  endif
endfunction
" run it once to initialize the color
call UpdateModeHL()
set statusline=
" LEFT SIDE
set statusline+=\ \ %#ModeSegmentHL#%{ModeSegment()}%#StatusLine#
set statusline+=\ \ %F
set statusline+=%#StatusModified#%M%#StatusLine#
set statusline+=\ %#ModeSegmentHL#\ %Y
set statusline+=\ %R
" CENTER GAP
set statusline+=%#StatusLine#\ \ \ %=%#StatusLine#
" RIGHT SIDE
set statusline+=row:%#StatusLine#%l
set statusline+=\ col:%#StatusLine#%c
set statusline+=\ %p\ \ \ 
