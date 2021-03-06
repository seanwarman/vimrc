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

" Lundo

function! LundoDiff()
  let g:lundobufname = 'lundo-diff'

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

  au! BufLeave lundo-diff execute "diffoff! |" . g:lundobuf . "bwipeout"

  execute "vert diffsplit " . g:lundobufname
  silent execute 'rundo ' fnameescape(g:undofile)
  norm zR

  map <buffer> > :diffput<cr>
  map <buffer> < :diffget<cr>
endfunc

function! TotalDiffFiller()
  let l:l = 0
  let l:filler = 0
  while l:l <= line('.')
    let l:filler = l:filler + diff_filler(l)
    let l:l = l:l + 1
  endwhile

  return l:filler
endfunc

function! LundoThisLine()
  let l:cwline = line('.') + TotalDiffFiller()
  silent undo

  " TODO: We need to keep better track of the line numbers
  " both buffer's lines change as we go so we have to keep
  " up with both of them at the same time
  while line('.') != l:cwline && v:errmsg != 'Already at oldest change'
    silent undo
  endwhile

endfunc


function! LundoSelect()
  " exe "norm \<esc>"
  " exe "norm gv"
  " let l:top = line('.')
  " exe "norm o"
  " let l:bottom = line('.')
  " exe "norm o"
  " echo l:top
  " echo l:bottom

  " Here's how itll work:
  " We do a LundoDiff which does
  " an undo then does getline() or get line number
  " if the line number maches the current one we want
  " yank the line then overwirte the line in the current file
  " if it doesn't undo again untill it does.
  " use diff_filler() to find the missing lines above so we can
  " track we're on the right line even when the lines above have been
  " deleted/added.

  let g:lundobufname = 'lundo-select'

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

  execute "vert diffsplit " . g:lundobufname
  " set noscrollbind
  silent execute 'rundo ' fnameescape(g:undofile)
  norm zR
  " close
  " diffoff

  call LundoThisLine()

endfunc
map <leader>ls :call LundoSelect()<cr>

function! Registers(findstart, base)
  if a:findstart == 1
    return 0
  endif
  let l:regs = [ '"', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'i', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'w', 'y', 'z', '-', '.', ':', '%', '#', '/', '=', ]
  return { 'words': map(l:regs, { i, reg -> { 'key': reg, 'word': getreginfo(reg).regcontents[0], 'abbr': '@' . reg, 'menu': slice(trim(getreginfo(reg).regcontents[0]), 0, 20) } }) }
endfunction
