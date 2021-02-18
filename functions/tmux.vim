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
