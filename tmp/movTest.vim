function! RotateLeft()
    let l:curbuf = bufnr('%')
    hide
    wincmd h
    split
    exe 'buf' l:curbuf
endfunc

function! TermWinGoto()
  let l:winnr = winnr()
  wincmd t
  10 wincmd j
  if winnr() == l:winnr
    split
  endif
endfunc


call TermWinGoto()
