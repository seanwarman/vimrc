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

function! RawFzF(type)
  execute "silent !$HOME/.vim/vimfzf '".a:type."'"
  redraw!
  execute "e " . system("cat $HOME/.vim/.file")
endfunc
