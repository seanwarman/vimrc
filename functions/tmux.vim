" Tmux relevent settings
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




" Fuzzy Finding

function! FuzzyBuffers(buffers)
  return "~/./.vim/vimfzf buffers " . shellescape(a:buffers)
endfunc

function! FuzzyFiles()
  return "~/./.vim/vimfzf files"
endfunc

function! FuzzyGrep()
  return "~/./.vim/vimfzf grep"
endfunc

function! GetLs()
  let l:BuffString = { key, val -> val.bufnr . ":" . (len(val.name) > 1 ? val.name : "[No Name]") . ":" . val.lnum }
  return join(map(getbufinfo({'buflisted':1}), l:BuffString), "\n")
endfunc


" Ranger settings

function! RnR()
  let l:name = getbufinfo(bufnr())[0].name

  " If this file is on some sort of server don't try and select it in
  " ranger...
  if len(matchstr(l:name, "://"))
    return "tmux split -b \"ranger --confdir='" .$HOME . "/.vim/config/ranger' --choosedir='" . $HOME . "/.vim/.rangertargetfile'\""
  elseif len(l:name)
    return "tmux split -b \"ranger --confdir='" .$HOME . "/.vim/config/ranger' --choosedir='" . $HOME . "/.vim/.rangertargetfile' --selectfile='" . l:name . "'\""
  else
    return "tmux split -b \"ranger --confdir='" .$HOME . "/.vim/config/ranger' --choosedir='" . $HOME . "/.vim/.rangertargetfile'\""
  endif
endfunc

