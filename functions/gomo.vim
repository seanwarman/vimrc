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

