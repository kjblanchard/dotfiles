function! ModeSegment()
  let m = mode()
  if m ==# 'n'
    return ' NORMAL '
  elseif m ==# 'i'
    return ' INSERT '
  " match any visual mode: v, V, or Ctrl-V
  elseif m ==# 'v' || m ==# 'V' || m ==# "\<C-v>"
    return ' VISUAL '
  elseif m ==# 'R'
    return ' REPLACE '
  else
    return ' EX '
  endif
endfunction
set statusline=%{ModeSegment()}%#StatusLine#\ %F\ %M\ %Y\ %R%=
set statusline+=ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
