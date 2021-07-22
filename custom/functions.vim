function! GetLs()
  let l:BuffString = { key, val -> val.bufnr . ":" . (len(val.name) > 1 ? val.name : "[No Name]") . ":" . val.lnum }
  return join(map(getbufinfo({'buflisted':1}), l:BuffString), "\n")
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

function! AnyList(cmd, ftype, cursorposition)
  if bufname("%") == "menu-list" | return | endif

  silent! redir => o | execute 'silent ' . a:cmd | redir END | let l:list = o

  " Set up the buffer-list buffer (this makes it hidden)
  let g:anylistbuff = bufnr('menu-list', 1)
  call setbufvar(g:anylistbuff, "&buftype", "nofile")

  call bufload('menu-list')
  let lnum = 0
  for line in split(l:list, '\n')
    let lnum += 1
    call setbufline(g:anylistbuff, lnum, line)
  endfor

  " If we leave buffer-list it'll get deleted...
  au! BufLeave menu-list execute g:anylistbuff . "bwipeout"

  execute "sbuffer" . g:anylistbuff
  
  " Copy the output of the given command (eg "ls") and paste it into
  " buffer-list
  silent! set cursorline
  exe "silent! set filetype=" . a:ftype
  exe "norm " . a:cursorposition
  exe "map <silent> <buffer> <cr> :b " . expand("<cword>") . "<cr>"
  exe "map <silent> <buffer> dd :bd " . expand("<cword>") . "<cr>V:g/./d\<cr>" . a:cursorposition

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

function OmniCompletionRegisters(findstart, base)
  if a:findstart == 1
    return 0
  endif
  return {
    \'words': [
      \{
        \'word': getreginfo('"').regcontents[0],
        \'abbr': '@"',
        \'menu': getreginfo('"').regcontents[0]
      \},
      \{
        \'word': getreginfo('0').regcontents[0],
        \'abbr': '@0',
        \'menu': getreginfo('0').regcontents[0]
      \},
      \{
        \'word': getreginfo('1').regcontents[0],
        \'abbr': '@1',
        \'menu': getreginfo('1').regcontents[0]
      \},
      \{
        \'word': getreginfo('2').regcontents[0],
        \'abbr': '@2',
        \'menu': getreginfo('2').regcontents[0]
      \},
      \{
        \'word': getreginfo('3').regcontents[0],
        \'abbr': '@3',
        \'menu': getreginfo('3').regcontents[0]
      \},
      \{
        \'word': getreginfo('4').regcontents[0],
        \'abbr': '@4',
        \'menu': getreginfo('4').regcontents[0]
      \},
      \{
        \'word': getreginfo('5').regcontents[0],
        \'abbr': '@5',
        \'menu': getreginfo('5').regcontents[0]
      \},
      \{
        \'word': getreginfo('6').regcontents[0],
        \'abbr': '@6',
        \'menu': getreginfo('6').regcontents[0]
      \},
      \{
        \'word': getreginfo('7').regcontents[0],
        \'abbr': '@7',
        \'menu': getreginfo('7').regcontents[0]
      \},
      \{
        \'word': getreginfo('8').regcontents[0],
        \'abbr': '@8',
        \'menu': getreginfo('8').regcontents[0]
      \},
      \{
        \'word': getreginfo('9').regcontents[0],
        \'abbr': '@9',
        \'menu': getreginfo('9').regcontents[0]
      \},
      \{
        \'word': getreginfo('a').regcontents[0],
        \'abbr': '@a',
        \'menu': getreginfo('a').regcontents[0]
      \},
      \{
        \'word': getreginfo('b').regcontents[0],
        \'abbr': '@b',
        \'menu': getreginfo('b').regcontents[0]
      \},
      \{
        \'word': getreginfo('c').regcontents[0],
        \'abbr': '@c',
        \'menu': getreginfo('c').regcontents[0]
      \},
      \{
        \'word': getreginfo('d').regcontents[0],
        \'abbr': '@d',
        \'menu': getreginfo('d').regcontents[0]
      \},
      \{
        \'word': getreginfo('e').regcontents[0],
        \'abbr': '@e',
        \'menu': getreginfo('e').regcontents[0]
      \},
      \{
        \'word': getreginfo('f').regcontents[0],
        \'abbr': '@f',
        \'menu': getreginfo('f').regcontents[0]
      \},
      \{
        \'word': getreginfo('g').regcontents[0],
        \'abbr': '@g',
        \'menu': getreginfo('g').regcontents[0]
      \},
      \{
        \'word': getreginfo('i').regcontents[0],
        \'abbr': '@i',
        \'menu': getreginfo('i').regcontents[0]
      \},
      \{
        \'word': getreginfo('k').regcontents[0],
        \'abbr': '@k',
        \'menu': getreginfo('k').regcontents[0]
      \},
      \{
        \'word': getreginfo('l').regcontents[0],
        \'abbr': '@l',
        \'menu': getreginfo('l').regcontents[0]
      \},
      \{
        \'word': getreginfo('m').regcontents[0],
        \'abbr': '@m',
        \'menu': getreginfo('m').regcontents[0]
      \},
      \{
        \'word': getreginfo('n').regcontents[0],
        \'abbr': '@n',
        \'menu': getreginfo('n').regcontents[0]
      \},
      \{
        \'word': getreginfo('o').regcontents[0],
        \'abbr': '@o',
        \'menu': getreginfo('o').regcontents[0]
      \},
      \{
        \'word': getreginfo('p').regcontents[0],
        \'abbr': '@p',
        \'menu': getreginfo('p').regcontents[0]
      \},
      \{
        \'word': getreginfo('q').regcontents[0],
        \'abbr': '@q',
        \'menu': getreginfo('q').regcontents[0]
      \},
      \{
        \'word': getreginfo('r').regcontents[0],
        \'abbr': '@r',
        \'menu': getreginfo('r').regcontents[0]
      \},
      \{
        \'word': getreginfo('s').regcontents[0],
        \'abbr': '@s',
        \'menu': getreginfo('s').regcontents[0]
      \},
      \{
        \'word': getreginfo('t').regcontents[0],
        \'abbr': '@t',
        \'menu': getreginfo('t').regcontents[0]
      \},
      \{
        \'word': getreginfo('u').regcontents[0],
        \'abbr': '@u',
        \'menu': getreginfo('u').regcontents[0]
      \},
      \{
        \'word': getreginfo('w').regcontents[0],
        \'abbr': '@w',
        \'menu': getreginfo('w').regcontents[0]
      \},
      \{
        \'word': getreginfo('y').regcontents[0],
        \'abbr': '@y',
        \'menu': getreginfo('y').regcontents[0]
      \},
      \{
        \'word': getreginfo('z').regcontents[0],
        \'abbr': '@z',
        \'menu': getreginfo('z').regcontents[0]
      \},
      \{
        \'word': getreginfo('-').regcontents[0],
        \'abbr': '@-',
        \'menu': getreginfo('-').regcontents[0]
      \},
      \{
        \'word': getreginfo('*').regcontents[0],
        \'abbr': '@*',
        \'menu': getreginfo('*').regcontents[0]
      \},
      \{
        \'word': getreginfo('.').regcontents[0],
        \'abbr': '@.',
        \'menu': getreginfo('.').regcontents[0]
      \},
      \{
        \'word': getreginfo(':').regcontents[0],
        \'abbr': '@:',
        \'menu': getreginfo(':').regcontents[0]
      \},
      \{
        \'word': getreginfo('%').regcontents[0],
        \'abbr': '@%',
        \'menu': getreginfo('%').regcontents[0]
      \},
      \{
        \'word': getreginfo('#').regcontents[0],
        \'abbr': '@#',
        \'menu': getreginfo('#').regcontents[0]
      \},
      \{
        \'word': getreginfo('/').regcontents[0],
        \'abbr': '@/',
        \'menu': getreginfo('/').regcontents[0]
      \},
      \{
        \'word': getreginfo('=').regcontents[0],
        \'abbr': '@=',
        \'menu': getreginfo('=').regcontents[0]
      \},
    \],
    \'refresh': 'always',
  \}
endfunction
