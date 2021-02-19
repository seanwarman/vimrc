" Give this function any command (marks, tags, ls),
" tell the cursor what position it should be in,
" give it a mapping for the enter key...
" also give it a filetype for syntax highlighting
function! MenuMovement()
  " Limit movement, you can still do "w" etc, this is just to make it a bit
  " like a menu...
  map <buffer> h <NOP>
  map <buffer> l <NOP>
  map <buffer> <esc> <c-w>c
endfunc

function! AnyList(cmd, ftype, cursorposition, onenter, ondelete)
  if bufname("%") == "menu-list" | return | endif

  " Set up the buffer-list buffer (this makes it hidden)
  let g:anylistbuff = bufnr('menu-list', 1)
  call setbufvar(g:anylistbuff, "&buftype", "nofile")
  execute "sbuffer" . g:anylistbuff
  " If we leave buffer-list it'll get deleted...
  au! BufLeave menu-list execute g:anylistbuff . "bwipeout"
  
  " Copy the output of the given command (eg "ls") and paste it into
  " buffer-list
  silent! redir => o | execute 'silent ' . a:cmd | redir END | let @b = o
  silent! set cursorline
  execute "silent! set filetype=" . a:ftype
  execute "norm \<c-w>J10\<c-w>-gg\"bpggdd" . a:cursorposition
  execute "map <silent> <buffer> <cr> :call " . a:onenter . "<cr>"
  execute "map <buffer> dd :call " . a:ondelete . "<cr>"

  call MenuMovement()
endfunction

function! AnyListOnEnterBuffer()
  execute "norm \"byiw\<c-w>\<c-w>:b\<c-r>b\<cr>"
endfunc

function! AnyListDeleteBuffer()
  if len(getbufinfo({'buflisted':1})) > 1
    execute "norm \"byiwV:g/./d\<cr>:Bclose \<c-r>b\<cr>"
  else
    echo "Can't delete the last buffer"
  endif
endfunction

function! EasySplit(filetype, ...)
  if bufname("%") == "easysplit" | return | endif

  " Set up the buffer-list buffer (this makes it hidden)
  let g:easysplit = bufnr('easysplit', 1)
  call setbufvar(g:easysplit, "&buftype", "nofile")
  execute "sbuffer" . g:easysplit
  " If we leave buffer-list it'll get deleted...
  " au! BufLeave easysplit execute g:easysplit . "bwipeout"
  execute "set filetype=".a:filetype
  execute "norm \<c-w>J10\<c-w>-gg"

  for easydo in a:000
    silent execute easydo
  endfor

  silent execute "norm ggd/See also\<cr>dd}2d}gg"
  call MenuMovement()
endfunct

function! FormatMdn()
  return 'norm ggd/See also\<cr>dd}2d}gg'
endfunc

function! Mdn(queryarr)
  return '0read !curl https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/'.a:queryarr[0].'/'.a:queryarr[1].' | w3m -dump -T text/html'
endfunc

function! MdnSplit(query)
  call EasySplit("asm", Mdn(split(a:query, "\\.")), FormatMdn())
endfunc
