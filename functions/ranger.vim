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

function! RawRnR(filename)
  execute "silent !ranger --confdir='$HOME/.vim/config/ranger' --selectfile='" . a:filename . "'"
  redraw!
endfunc
