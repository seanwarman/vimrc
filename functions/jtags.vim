" Jtags
function! JtagsSearchless()
  let l:pattern = expand('<cword>')
  silent execute v:count . 'tag! ' . l:pattern
endfunc

function! Jtags()
  let l:pattern = expand('<cword>')
  call system("$HOME/.vim/./jtags " . l:pattern)
  silent execute v:count . 'tag! ' . l:pattern
endfunc

