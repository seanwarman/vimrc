" Give this function any command (marks, tags, ls),
" tell the cursor what position it should be in,
" give it a mapping for the enter key...
" also give it a filetype for syntax highlighting

function! AnyList(cmd, ftype, position, onenter, ondelete)
  if bufname("%") == "buffer-list" | return | endif

  " Set up the buffer-list buffer (this makes it hidden)
  let g:anylistbuff = bufnr('buffer-list', 1)
  call setbufvar(g:anylistbuff, "&buftype", "nofile")
  execute "sbuffer" . g:anylistbuff
  " If we leave buffer-list it'll get deleted...
  au! BufLeave buffer-list execute g:anylistbuff . "bwipeout"

  " Copy the output of the given command (eg "ls") and paste it into
  " buffer-list
  silent! redir => o | execute 'silent ' . a:cmd | redir END | let @b = o
  silent! set cursorline
  execute "silent! set filetype=" . a:ftype
  " TODO: make the window a fixed height...
  " execute "bo 10split b"
  execute "norm \<c-w>J10\<c-w>-gg\"bpggdd" . a:position
  execute "map <silent> <buffer> <cr> :call " . a:onenter . "<cr>"
  execute "map <buffer> dd :call " . a:ondelete . "<cr>"

  " Limit movement, you can still do "w" etc, this is just to make it a bit
  " like a menu...
  map <buffer> h <NOP>
  map <buffer> l <NOP>
  map <buffer> <esc> <c-w>c
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

