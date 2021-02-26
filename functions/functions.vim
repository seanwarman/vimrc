function! GetLs()
  let l:BuffString = { key, val -> val.bufnr . ":" . (len(val.name) > 1 ? val.name : "[No Name]") . ":" . val.lnum }
  return join(map(getbufinfo({'buflisted':1}), l:BuffString), "\n")
endfunc

function! GomoCd(socket)
  return "gomo cd " . a:socket . ""
endfunc 

function! GomoRun(socket)
  let l:socket ""
  if a:socket | l:socket = " -s" . a:socket | endif
  return "gomo run" . l:socket . ""
endfunc

function! WdioMobileLogin()
  return "mobile.\\$('~passcode-input').addValue('111111')"
endfunc

function! WdioMobileLaunchApp()
  return "mobile.launchApp()"
endfunc

" Jtags
function! JtagsSearchless()
  let l:pattern = expand('<cword>')
  silent execute v:count . 'tag! ' . l:pattern
endfunc

function! Jtags()
  let l:pattern = expand('<cword>')
  silent! call system("$HOME/.vim/scripts/./jtags " . l:pattern)
  silent! execute v:count . 'tag! ' . l:pattern
endfunc

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
  execute "b " . expand("<cword>")
endfunc

function! AnyListDeleteBuffer()
  if len(getbufinfo({'buflisted':1})) > 1
    execute "norm V:g/./d\<cr>:Bclose " . expand("<cword>")
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
" Ranger settings

"
function! TmuxSplit(height, ...)
  return 'tmux split-window -l ' . a:height . ' "' . join(a:000, ' ') . '"'
endfunc

function! TmuxSend(...)
  return 'tmux send "' . join(a:000, ' ') . '"'
endfunc

function! TmuxKeyPress(...)
  return 'tmux send ' . join(a:000, ' ')
endfunc

" Lundo
function! LundoBuffer()
  let g:lundobufname = 'lundo-buffer'

  " Set up the buffer (this makes it hidden)
  let g:lundobuf = bufnr(g:lundobufname, 1)
  call setbufvar(g:lundobuf, "&buftype", "nofile")

  let g:undofile = undofile(expand("%"))
  let g:filecontent = systemlist("cat " . expand("%"))

  " setbufline only works on loaded buffers
  call bufload(g:lundobufname)
  let lnum = 0
  for line in g:filecontent
    let lnum = lnum + 1
    call setbufline(g:lundobuf, lnum, line)
  endfor
endfunc

function! LundoOnLeaveDo(...)
  let g:dos = a:000
  for g:doer in g:dos
    au BufLeave lundo-buffer execute g:doer
  endfor
endfunc

function! LundoWipeOnLeave()
  au! BufLeave lundo-buffer execute g:lundobuf . "bwipeout"
endfunc

function! LundoDiff()
  call LundoBuffer()
  call LundoWipeOnLeave()

  execute "au! BufEnter " . expand("%") . " diffof"

  execute "vert diffsplit " . g:lundobufname
  silent execute 'rundo ' fnameescape(g:undofile)

  norm zR

  map > :diffput<cr>
  map < :diffget<cr>
  " TODO: this doesn't work, these need unmapping after mode is done
  " au! BufLeave * execute "unmap < | unmap >"
endfunc



function! LundoSelect()
  exe "norm \<esc>"
  exe "norm gv"
  let l:top = line('.')
  exe "norm o"
  let l:bottom = line('.')
  exe "norm o"
  echo l:top
  echo l:bottom

  " Here's how itll work:
  " We do a LundoDiff which does
  " an undo then does getline() or get line number
  " if the line number maches the current one we want
  " yank the line then overwirte the line in the current file
  " if it doesn't undo again untill it does.
  " use diff_filler() to find the missing lines above so we can
  " track we're on the right line even when the lines above have been
  " deleted/added.
endfunc

