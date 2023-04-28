
" -----------------------------------------------------------------------------------------  PLUGINS  --------------------------------------------------------------------------------------------------

" Uses the :Man builtin plugin
runtime ftplugin/man.vim

call plug#begin('~/.local/share/vim/plugged')
  Plug 'flazz/vim-colorschemes'

  " Syntax
  Plug 'mattn/emmet-vim'
  Plug 'yuezk/vim-js'
  " Plug 'leafOfTree/vim-vue-plugin'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'digitaltoad/vim-pug'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " CSS and inline colors >> #344390 <<
  Plug 'KabbAmine/vCoolor.vim'
  Plug 'ap/vim-css-color'

  " Can't do without this one...
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Best git plugin ever
  Plug 'tpope/vim-fugitive'
  Plug 'tommcdo/vim-fugitive-blame-ext'

  " Bookmarks that behave nicer than default
  " Plug 'Yilin-Yang/vim-markbar'

  " Hatred for Netrw
  Plug 'justinmk/vim-dirvish'
  Plug 'kristijanhusak/vim-dirvish-git'

  " Startup splash screen and workspaces
  Plug 'mhinz/vim-startify'

  " Every editor needs multi cursors
  Plug 'mg979/vim-visual-multi'

  " Trying this again...
  Plug 'jacquesbh/vim-showmarks'

  " Tags plugin
  Plug 'preservim/tagbar'

  " Vim-like utils
  Plug 'itchyny/vim-cursorword'
  Plug 'adelarsq/vim-matchit'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-abolish'
  Plug 'justinmk/vim-sneak'
  Plug 'easymotion/vim-easymotion'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'seanwarman/dundo'

  " Markdown preview from Browser
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
call plug#end()
command! PluginBaby PlugClean | PlugInstall

" -----------------------------------------------------------------------------------------  DEFAULTS  ---------------------------------------------------------------------------------------------------

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Bail out if something that ran earlier, e.g. a system wide vimrc, does not
" want Vim to use these default values.
if exists('skip_defaults_vim')
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Add new tags to the .vim/tags file
set tags=~/.vim/tags
" Don't make tags reletive to that folder...
set notagrelative

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
noremap Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" Only do this part when Vim was compiled with the +eval feature.
if 1

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

" -----------------------------------------------------------------------------------------  SETTINGS  -------------------------------------------------------------------------------------------------

set background=dark

" Remaps the spacebar as leader
nnoremap <space> <Nop>
let mapleader = " "

set relativenumber
set nu

set mouse=a

" Set tabs to indent 2 spaces
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

" Allows buffers to stay unsaved in the background
" vim will prompt you if you want to quit to save them.
set hidden

" stop showing the swap file error
set shortmess+=A
set noswapfile
" Put .swp files into here...
set dir=$HOME/.vim/tmp

" Keeps the cursors col position between buffers
set nostartofline

set nowrap

" Maintain undo
set undofile 
" nvim has a different undo format to normal vim
" keep them both...
if has("nvim")
  set undodir=~/.vim/nvim-undodir
else
  set undodir=~/.vim/undodir
endif

" Set's yank to use the normal clipboard
set clipboard=unnamed

" Don't ask to [L]oad the file just load it...
set autoread

set previewheight=30

set diffopt+=vertical

" Fix terrible side scrolling defaults
" Increment for the scroll amount...
set sidescroll=10
" Padding to for the cursor position...
set sidescrolloff=10

" -----------------------------------------------------------------------------------------  STARTIFY  -------------------------------------------------------------------------------------------------

let g:startify_change_to_dir = 0
let g:startify_custom_header = [
      \"        ________ ++     ________",
      \"       /VVVVVVVV\\++++  /VVVVVVVV\\",
      \"       \\VVVVVVVV/++++++\\VVVVVVVV/",
      \"        |VVVVVV|++++++++/VVVVV/\'",
      \"        |VVVVVV|++++++/VVVVV/\'",
      \"       +|VVVVVV|++++/VVVVV/\'+",
      \"     +++|VVVVVV|++/VVVVV/\'+++++",
      \"   +++++|VVVVVV|/VVVVV/\'+++++++++",
      \"     +++|VVVVVVVVVVV/\'+++++++++",
      \"       +|VVVVVVVVV/\'+++++++++",
      \"        |VVVVVVV/\'+++++++++",
      \"        |VVVVV/\'+++++++++",
      \"        |VVV/\'+++++++++",
      \"        \'V/\'   ++++++",
      \"                 ++",
\]
let g:startify_skiplist = [
      \ $HOME . "/.vim/vimrc",
\]

let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'files',     'header': ['   Recent Files']   },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]

" The quit mapping in startify conflicts with 'q:'...
autocmd User Startified sil! unmap <buffer> q

noremap <leader>G :Startify<cr>

" --------------------------------------------------------------------------------------  COMMENTARY  ----------------------------------------------------------------------------------------------------

" autocmd FileType vue.html.javascript.css setlocal commentstring=\/\/\ %s
" autocmd FileType vue setlocal commentstring=\/\/\ %s
" autocmd FileType javascript setlocal commentstring=\/\/\ %s

" --------------------------------------------------------------------------------------  EASYMOTION  ----------------------------------------------------------------------------------------------------

noremap <Leader>j <Plug>(easymotion-j)
noremap <Leader>k <Plug>(easymotion-k)

let g:EasyMotion_startofline = 0

" ------------------------------------------------------------------------------------------  VUE  ----------------------------------------------------------------------------------------------------

let g:vue_pre_processors = ['scss']

" -----------------------------------------------------------------------------------------  EMMET  ---------------------------------------------------------------------------------------------------

let g:user_emmet_leader_key = '<c-z>'

" ----------------------------------------------------------------------------------------  SESSIONS  -------------------------------------------------------------------------------------------------

function SaveSesh(name)
  exe 'SSave ' . a:name
endfunction

command! SaveSesh call SaveSesh(fnamemodify(getcwd(), ':t') . '-' . join(split(StatusLineGitBranch(), '\/'), '-'))

noremap <leader>ss :SaveSesh<cr>

" ------------------------------------------------------------------------------------------  COLORS  -------------------------------------------------------------------------------------------------

function LightColours()
  return [
        \ 'buttercream',
        \ 'cake16',
        \ 'carrot',
        \ 'cherryblossom',
        \ 'codeburn',
        \ 'dawn',
        \ 'flattened_light',
        \ 'fruidle',
        \ 'seagull',
        \ 'whitebox',
        \ 'bubblegum-256-light'
        \]
endfunction
function DarkColours()
  return [
        \ 'abbott',
        \ 'abra',
        \ 'atom',
        \ 'base16-atelierdune',
        \ 'birds-of-paradise',
        \ 'buddy',
        \ 'bvemu',
        \ 'desert',
        \ 'evening1',
        \ 'flatland',
        \ 'gruvbox',
        \ 'impactjs',
        \ 'itg_flat',
        \ 'lumberjack',
        \ 'luna',
        \ 'lxvc',
        \ 'material',
        \ 'molokai',
        \ 'monokai-chris',
        \ 'Monokai',
        \ 'monokain',
        \ 'new-railscasts',
        \ 'pacific',
        \ 'parsec',
        \ 'seti',
        \ 'slate2',
        \ 'srcery-drk',
        \ 'srcery',
        \ 'stereokai',
        \ 'Tomorrow-Night-Eighties',
        \ 'vimbrant',
        \]
endfunction

command! -nargs=* Dark :set background=dark | exe 'colo ' . DarkColours()[<args>]
command! -nargs=* Light :set background=light | exe 'colo ' . LightColours()[<args>]

command Daytime :Light 10
command Nighttime :Dark 10

Daytime

" An array of colours for the term_colourscheme_colours function based on the
" current values of the colourscheme's highlight groups...
let g:term_colourscheme_colours = [
      \ { 'hi': 'Vertsplit',    'type': 'fg' },
      \ { 'hi': 'Normal',       'type': 'fg' },
      \ { 'hi': 'Conditional',  'type': 'fg' },
      \ { 'hi': 'Special',      'type': 'fg' },
      \ { 'hi': 'UnderLined',   'type': 'fg' },
      \ { 'hi': 'Cursor',       'type': 'bg' },
      \ { 'hi': 'Operator',     'type': 'fg' },
      \ { 'hi': 'Error',        'type': 'bg' },
      \ { 'hi': 'MoreMsg',      'type': 'fg' },
      \ { 'hi': 'Type',         'type': 'fg' },
      \ { 'hi': 'Directory',    'type': 'fg' },
      \ { 'hi': 'Boolean',      'type': 'fg' },
      \ { 'hi': 'Normal',       'type': 'bg' },
      \ { 'hi': 'FoldColumn',   'type': 'fg' },
      \ { 'hi': 'Define',       'type': 'fg' },
      \ { 'hi': 'StatusLine',   'type': 'fg' }
      \]

function MapAnsiTermColours(key, val)
  silent! let l:colour = synIDattr(hlID(a:val.hi), a:val.type)
  if len(l:colour)
    return l:colour
  else
    return term_getansicolors(bufnr())[a:key]
  endif
endfunction

let g:MapAnsiTermFunc = function("MapAnsiTermColours")

" This sets the ansi term colours (for gui vim) so they match the current
" colorscheme...
function SetAnsiTermColours()
  silent! call term_setansicolors(bufnr(), map(g:term_colourscheme_colours, g:MapAnsiTermFunc))
endfunction

" autocmd TerminalOpen,TermChanged,TerminalWinOpen,Syntax * silent! call SetAnsiTermColours()

" Fold highlights are always too strong looking, link it to whatever the
" Comment color is for the color scheme...
hi! link Folded Comment

" -----------------------------------------------------------------------------------------  COC  -------------------------------------------------------------------------------------------------

let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint', 'coc-browser', 'coc-css', 'coc-json', 'coc-prettier', 'coc-html']

map ]e <Plug>(coc-diagnostic-next)
map [e <Plug>(coc-diagnostic-prev)
map <leader>ef <Plug>(coc-fix-current)
map <leader>ea <Plug>(coc-codeaction)
noremap <leader>ed :CocDisable<cr>
noremap <leader>ee :CocEnable<cr>
" noremap <leader>jj :CocCommand fzf-preview.Jumps<cr>
noremap <leader>cc :CocCommand fzf-preview.Changes<cr>
noremap <leader>mm :CocCommand fzf-preview.Marks<cr>


" Hide the gutter background colour
hi SignColumn ctermbg=NONE

function s:tryTagOrUseCoc(actionType)
  try
    call CocAction(a:actionType)
  catch
    exe 'tag! ' . expand('<cword>')
  endtry
endfunction

" noremap <c-]> :<c-u>call <SID>tryTagOrUseCoc('jumpDefinition')<cr>
" nnoremap gt :<c-u>call <SID>tryTagOrUseCoc('jumpTypeDefinition')<cr>
nnoremap gr :<c-u>call <SID>tryTagOrUseCoc('jumpReferences')<cr>

" ----------------------------------------------------------------------------------------  STATUSLINE  ------------------------------------------------------------------------------------------------

function FindArgv(path)
  for file in argv()
    if fnamemodify(file, ":p") == fnamemodify(a:path, ":p")
      return 1
    endif
  endfor
  return 0
endfunction

function FilePathToBufName(path, bufnr)
  let l:file = ''
  if len(a:path) > 0
    let l:file = fnamemodify(a:path, ":t")
  else
    let l:file = 'No Name'
  endif

  if FindArgv(a:path)
    let l:file = l:file . '«'
  endif
  if bufnr() == a:bufnr
    let l:file = '[' . l:file . ']'
  endif

  return l:file
endfunction

function ListBuffers()
  return join(map(getbufinfo({'buflisted':1}), { key, val -> FilePathToBufName(val.name, val.bufnr) }), ' • ')
endfunction

function FileNameOrPath(path)
  if !len(fnamemodify(a:path, ':t'))
    return a:path
  else
    return fnamemodify(a:path, ':t')
  endif
endfunction

function FilePathToSelected(path)
  if a:path == bufname(bufnr())
    return '[' . FileNameOrPath(a:path) . ']'
  else
    return FileNameOrPath(a:path)
  endif
endfunction

function ListArgs()
  return join(map(argv(), { key,val -> FilePathToSelected(val) }), ' • ')
endfunction

let g:args_or_buffers = 'buffers'
function ToggleStatusLine()
  if g:args_or_buffers == 'buffers'
    let g:args_or_buffers = 'args'
  else
    let g:args_or_buffers = 'buffers'
  endif
endfunction
noremap <leader><leader>t :call ToggleStatusLine()<cr>

function ListArgsOrBuffers()
  if g:args_or_buffers == 'args'
    return ListArgs() . ' = A '
  elseif g:args_or_buffers == 'buffers'
    return ListBuffers() . ' = B '
  else
    return ''
  endif
endfunction

" let statusline_git_branch = trim(system('git rev-parse --abbrev-ref HEAD'))
" au DirChanged * let g:statusline_git_branch = trim(system('git rev-parse --abbrev-ref HEAD'))

function StatusLineGitBranch()
  try
    return FugitiveHead()
  catch
    return ''
  endtry

  " This is slow FugitiveHead is much better optimised
  if substitute(split(g:statusline_git_branch, ' ')[0], '^fatal:', 'NOT_GIT_REPO', 'g') == 'NOT_GIT_REPO'
    return 'not a repo'
  else
    return g:statusline_git_branch
  endif
endfunction

" Status line that shows the args or the bufs list
set statusline=%#MatchParen#\ %{fnamemodify(getcwd(),':t')}\ %*%#IncSearch#\ %{StatusLineGitBranch()}\ %*\ %t:%p%%:%c\ %#ErrorMsg#%m%*%=%{ListArgsOrBuffers()}\ 

" Always show the statusline
set laststatus=2

" -----------------------------------------------------------------------------------------  BUFFERS/ARGS  ---------------------------------------------------------------------------------------------

function ListEmptyBufNums()
  return join(map(getbufinfo({'buflisted':1}), { key, val -> len(val.name) == 0 ? val.bufnr : ''}))
endfunction
function ListAllBufNums(missbuf)
  return join(map(getbufinfo({'buflisted':1}), { key, val -> val.bufnr == a:missbuf ? '' : val.bufnr }))
endfunction

" Delete all empty buffers
function DeleteEmptyBuffers()
  let l:bufnums = ListEmptyBufNums()
  if len(trim(l:bufnums)) > 1
    exe 'bd! ' . ListEmptyBufNums()
  else 
    echo 'No empty buffers'
  endif
endfunction

function ListAllBufNames()
  return map(getbufinfo({'buflisted':1}), { key, val -> fnamemodify(val.name, ':p') })
endfunction

function ListAllArgPaths()
  return map(argv(), { key, val -> fnamemodify(val, ':p') })
endfunction

function PathExistsInArgv(path)
  for path in ListAllArgPaths()
    if path == a:path
      return 1
    endif
  endfor
  return 0
endfunction

function ArgAddOrRemoveFile(path)
  if PathExistsInArgv(fnamemodify(a:path, ':p'))
    exe 'argdelete ' . a:path
  else
    exe 'argadd ' . a:path
  endif
endfunction

function ListAllBufsNotInArgv()
  let l:paths = []
  for path in ListAllBufNames()
    if !PathExistsInArgv(path)
      call add(l:paths, path)
    endif
  endfor
  return l:paths
endfunction

function DeleteAllBufsNotInArgv()
  let l:paths = ListAllBufsNotInArgv()
  if len(l:paths)
    exe 'bd! ' . join(ListAllBufsNotInArgv())
  endif
  call DeleteEmptyBuffers()
endfunction

function DeleteAllButThisBuf()
  exe 'sil! bd! ' . ListAllBufNums(bufnr())
  call DeleteEmptyBuffers()
endfunction

" Buffer mappings
noremap <leader>bp :bp<cr>
noremap <leader>bn :bn<cr>
noremap <leader>bdd :Bclose!<cr>
noremap <leader>bd<tab> :<c-f>ibd! 
" Select buffer from completion menu...
noremap <leader>b<tab> q:ib 
noremap <leader>bd* :sil! call DeleteAllBufsNotInArgv()<cr>
noremap <leader>bdD :sil! call DeleteAllButThisBuf()<cr>
noremap <leader>bde :call DeleteEmptyBuffers()<cr>
noremap <leader><leader>n :new \| wincmd p \| close!<cr>
nnoremap <leader>b <Nop>
nnoremap <leader>bd <Nop>

" Args list mappings
noremap <leader>an :n<cr>
noremap <leader>ap :N<cr>
noremap <leader>aa :call ArgAddOrRemoveFile(expand('%'))<cr>
" Add all open buffers to the args list...
noremap <leader>aA :exe 'argadd ' . join(ListAllBufNames())<cr>
noremap <leader>al :sall<cr>
noremap <leader>aD :argdelete *<cr>
" Select buffer from completion menu...
command! -nargs=* -complete=arglist Args argedit <args>
noremap <leader>a<tab> q:iArgs 
" Add to args list from buffer completion menu...
command! -nargs=* -complete=buffer BufArgs argedit <args>
noremap <leader>ab<tab> q:iBufArgs 
nnoremap <leader>a <Nop>

" -----------------------------------------------------------------------------------------  AUTOCOMPLETION  -------------------------------------------------------------------------------------------------

" set completeopt=menuone
" set complete=.,w,b,u,t,i

" set omnifunc=syntaxcomplete#Complete
" function CompleteOmni()
"   if !pumvisible()
"     call feedkeys("\<c-x>\<c-o>")
"   else
"     call feedkeys("\<c-n>")
"   endif
"   return ''
" endfunction

" " This works but it's actually not as useful as c-n
" " imap <tab> <c-r>=CompleteOmni()<cr>
" imap <tab> <c-n>
" imap <s-tab> <c-p>


" function CountCols()
"   let l:n = 1
"   let l:total = 0
"   let l:curline = getcharpos('.')[1]
"   while l:n < l:curline
"     let l:total += col([l:n, '$'])
"     let l:n += 1
"   endwhile
"   " col() adds a 1 for every line so minus off the number of lines...
"   let l:total += (col('.') - l:curline)
"   return 'total is: ' . l:total
" endfunction





" function CompleteNode()
"   call setcursorcharpos('.', col('.') -1)
"   let l:word = expand('<cWORD>')
"   call setcursorcharpos('.', col('.') +1)


"   " call complete(col('.'), [ 'constructor', '__defineGetter__', '__defineSetter__', 'hasOwnProperty', '__lookupGetter__', '__lookupSetter__', 'isPrototypeOf', 'propertyIsEnumerable', 'toString', 'valueOf', '__proto__', 'toLocaleString' ])
"   return l:word
" endfunction

" -------------------------------------------------------------------------------------------  FZF  ---------------------------------------------------------------------------------------------------

let g:fzf_layout = { 'down': '35%' }

if system('echo $TMUX') <= 1
  map <leader>pp :Files<cr>
  " Find file under cursor...
  " map <leader>pw "zyiw:Files<cr><c-\><c-n>"zpi
  " Find file name...
  map <leader>fp :exe 'Ag ' . expand('%:t:r')<cr>
  " Find vue markup type component from file name...
  map <leader>fcp :exe 'Ag <' . expand('%:t:r')<cr>
  map <leader>ff :Ag<cr>
  map <leader>fw :Ag <c-r><c-w><cr>
endif

" -----------------------------------------------------------------------------------------  DIRVISH  --------------------------------------------------------------------------------------------------

" Settings

let g:dirvish_relative_paths = 0
let g:custom_dirvish_split_width = 60

function PreviewIfDir()
  if len(finddir(expand('<cWORD>'))) > 0 
    call feedkeys("p")
  endif
endfunction

function DirvishPreviewTreeMaps()
  augroup dirvish_config
    autocmd!
    autocmd FileType dirvish silent! nnoremap <buffer> l :call dirvish#open("edit", 0)<CR> \| :call PreviewIfDir()<CR>
    autocmd FileType dirvish silent! nnoremap <buffer> k k:call PreviewIfDir()<CR>
    autocmd FileType dirvish silent! nnoremap <buffer> j j:call PreviewIfDir()<CR>
    autocmd FileType dirvish silent! nnoremap <buffer> h <Plug>(dirvish_up):call feedkeys("p")<CR>
    autocmd FileType dirvish silent! nnoremap <buffer> gq <Plug>(dirvish_quit):pc<cr>
  augroup END
endfunction

function DirvishUnMap()
  augroup dirvish_config
    autocmd!
    autocmd FileType dirvish silent! unmap <buffer> l
    autocmd FileType dirvish silent! unmap <buffer> k
    autocmd FileType dirvish silent! unmap <buffer> j
    autocmd FileType dirvish silent! unmap <buffer> h
    autocmd FileType dirvish silent! unmap <buffer> gq
  augroup END
endfunction

" Commands

function DirvishPreviewTree()
  call DirvishUnMap()
  call DirvishPreviewTreeMaps()
  set nopreviewwindow
  pclose
  pedit
  call DirvishHereOrCwd("%:h")
  call DirvishPositionLeft(g:custom_dirvish_split_width)
  norm p
endfunction
command! DirvishPreviewTree :sil! call DirvishPreviewTree()
if system('echo $TMUX') <= 1
  map <leader>. :DirvishPreviewTree<cr>
endif

function DirvishPositionLeft(width)
  exe "norm \<c-w>H " . a:width . " \<c-w><"
endfunction

function PreviewOrClosePreview(prevcmd)
  if &filetype != 'dirvish'
    pc
    " Do I want to add the file to args automatically?
    " argadd %
  else
    exe 'call ' . a:prevcmd
  endif
endfunction

function DirvishFindMatchAtCursor()
  let l:bits = split(expand('<cWORD>'), ':')
  exe 'pedit +' . l:bits[1] . ' ' . l:bits[0]
endfunction

function DirvishHereOrCwd(dir)
  if len(expand(a:dir))
    exe 'Dirvish ' . a:dir
  else
    exe 'Dirvish .'
  endif
endfunction

" -----------------------------------------------------------------------------------------  SEARCHER  ----------------------------------------------------------------------------------------------------

function PeditFileAtLine()
  try
    let l:file = split(expand('<cWORD>'), ':')
    if len(l:file) > 1
      exe 'pedit '  . ' +' . l:file[1] . ' ' . l:file[0]
    else
      exe 'pedit ' . l:file[0]
    endif
  catch
    echo 'No file'
  endtry
endfunction

function ReadCommandToSearcherBuf(cmd)
  let l:gobackbuf = bufnr()
  silent! bw! searcher
  try
    e $HOME/.vim/searcher
  catch
    new
    file $HOME/.vim/searcher
  endtry
  exe '%d_'
  only
  set nopreviewwindow
  sil! unmap <buffer> <cr>
  sil! unmap <buffer> x
  sil! unmap <buffer> l
  sil! unmap <buffer> k
  sil! unmap <buffer> j
  sil! unmap <buffer> gq
  nnoremap <silent> <buffer> <cr> :pc!<cr>gF:bd!{searcher}<cr>
  nnoremap <silent> <buffer> l :pc!<cr>gF:bd!{searcher}<cr>
  nnoremap <silent> <buffer> k k:call PeditFileAtLine()<cr>
  nnoremap <silent> <buffer> j j:call PeditFileAtLine()<cr>
  nnoremap <silent> <buffer> x :call ArgAddOrRemoveFile(split(expand('<cWORD>'), ':')[0])<cr>
  " I'd like to put this in but it behaves janky...
  " au CursorMoved <buffer> call PeditFileAtLine()
  nnoremap <silent> <buffer> gq :sil! pc \| Bclose!<cr>
  silent! pedit
  exe '0read! ' . a:cmd 
  w
endfunction

function ReturnToSearcher()
  try
    b{searcher}
  catch
    try
      e $HOME/.vim/searcher
    catch
      echo 'No previous searcher buffer'
      return
    endtry
  endtry
  sil! only
  set nopreviewwindow
  sil! unmap <buffer> <cr>
  sil! unmap <buffer> x
  sil! unmap <buffer> l
  sil! unmap <buffer> k
  sil! unmap <buffer> j
  sil! unmap <buffer> q
  nnoremap <silent> <buffer> <cr> :pc!<cr>gF:sil! bd!{searcher}<cr>
  nnoremap <silent> <buffer> l :pc!<cr>gF:sil! bd!{searcher}<cr>
  nnoremap <silent> <buffer> k k:call PeditFileAtLine()<cr>
  nnoremap <silent> <buffer> j j:call PeditFileAtLine()<cr>
  nnoremap <silent> <buffer> x :call ArgAddOrRemoveFile(split(expand('<cWORD>'), ':')[0])<cr>
  " I'd like to put this in but it behaves janky...
  " au CursorMoved <buffer> call PeditFileAtLine()
  nnoremap <silent> <buffer> gq :sil! pc \| bd!<cr>
  call PeditFileAtLine()
endfunction

function LsDirsFromCwdExcluding(exclude)
  return substitute(join(split(system('ls'), '\n'), ','), a:exclude . ',', '', 'g')
endfunction

function FindFile(path)
  try
    exe 'find ' . expand(a:path)
  catch
    silent! call ReadCommandToSearcherBuf('ag -g ' . shellescape(expand(a:path)) . ' ' . getcwd())
    call PeditFileAtLine()
  endtry
endfunction
command! -nargs=* -complete=file_in_path FindFile let &path=LsDirsFromCwdExcluding('.angular .git node_modules') | call FindFile(expand("<args>")) | let @/ = '<args>'
" nnoremap <leader>pp :FindFile <c-f>i<c-x><c-v><c-p>
nnoremap <leader>pw :FindFile <c-r><c-w><c-f><tab><cr>
nnoremap <leader>pW :exe 'FindFile ' . expand('<cWORD>')<cr>

function Search(term)
  call ReadCommandToSearcherBuf('ag ' . shellescape(a:term) . ' .')
  let @/ = a:term
  call PeditFileAtLine()
endfunction
command! -nargs=* Search silent! call Search(expand("<args>"))
" These are taken out because I'm just using fzf
" map <leader>ff :Search 
" map <leader>fw :Search <c-r><c-w><cr>
" map <leader>fW :exe 'Search ' . expand('<cWORD>')<cr>

" map <leader>ss :call ReturnToSearcher()<cr>

" -----------------------------------------------------------------------------------------  SEARCHING  ------------------------------------------------------------------------------------------------

" Causes search to highlight while entering it...
set hlsearch
" Allows case sensitivity only when capitals are used
" set ignorecase
" set smartcase
" I've switched these off becuase they effect autocomplete

" Custom colour for search highlighting...
" hi Search term=standout ctermfg=0 ctermbg=11 guifg=Blue guibg=Yellow
" Clears the hlsearch on most movements...
nnoremap <silent> h h:noh<cr>
nnoremap <silent> j j:noh<cr>
nnoremap <silent> k k:noh<cr>
nnoremap <silent> l l:noh<cr>
nnoremap <silent> l l:noh<cr>
nnoremap <silent> b b:noh<cr>
nnoremap <silent> w w:noh<cr>
nnoremap <silent> W W:noh<cr>
nnoremap <silent> B B:noh<cr>
nnoremap <silent> E E:noh<cr>
nnoremap <silent> e e:noh<cr>

" vim-sneak Mappings
" Remaps f and t to work over multi lines
nmap <Nop> <Plug>Sneak_S
nmap <Nop> <Plug>Sneak_s
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" -----------------------------------------------------------------------------------------  COMMANDS  -------------------------------------------------------------------------------------------------

" Kind of works...
function TerminalBufCmd()
  let l:line = line('.')
  call term_sendkeys(4, getline(l:line) . "\r")
  1,$ d _
  return "\r" . join(getbufline(4, 1, 1000), "\r") . "\r"
endfunction

au FileType bufterm.sh sil! inoremap <buffer> <cr> <c-r>=TerminalBufCmd()<cr>

command BufTerm new | set filetype=bufterm.sh | norm i

command DelEmptyLines exe 'g/^\([\s\t]\)*$/d'

" Config file shortcuts
command! Vimrc e ~/.vim/vimrc
command! Vimzsh e ~/.zshrc
" Goes to my vom config folder
command! VimConfig e ~/.vim
" Writes and reloads the vimrc...
command! W :w | so ~/.vimrc
" Goes to my tags file...
command! Tags e ~/.vim/tags
" Goes to the jtags script...
command! Jtags e ~/.vim/scripts/jtags
" Finds all merge conflicts inside the app/ dir...
command! -nargs=+ -complete=dir Fix :F '<<<' <args>
" Inputs a search for conflict markers in file...
command! Conflicts /=======\|>>>>>>>\|<<<<<<< HEAD
" Creates an actions creator, with types...
command! AC call ActionCreator()
" Runs anything and prints it in a preview window...
command! -nargs=* Log silent! pedit! +setfiletype\ javascript\|0read<args> log

let g:testcommand = "npm run test"

" Runs projects tests and prints results to a buffer...
function Test()
  new
  set filetype=sh
  file tests
  silent let @t = system(g:testcommand)
  norm "tPggdj
endfunction
command! Test call Test()

" Write file then yank it...
" command! WriteYank w | norm ggyG``

" -----------------------------------------------------------------------------------------  AUTOCMDS  -------------------------------------------------------------------------------------------------

" au OptionSet,BufEnter *.vue set filetype=vue.html.javascript.css
" au OptionSet,BufEnter *.js set filetype=typescript

" -----------------------------------------------------------------------------------------  QUICKFIX  -------------------------------------------------------------------------------------------------

" Search for a search term in the given directory ':F searchterm folder'
command! -nargs=+ -complete=dir F :silent grep! -RHn --exclude-dir node_modules <args> | copen | norm <c-w>L40<c-w><

" Set the make program to eslint in the project's node modules...
set makeprg=./node_modules/.bin/eslint
" Set the error format to understand eslint's unix output...
set errorformat=%A%f:%l:%c:%m,%-G%.%#

" command! -nargs=* MakeLint silent make --ext .js,.vue,.ts,.tsx,.jsx --ignore-path .gitignore -f unix <args>
" command! -nargs=* LMakeLint silent lmake --ext .js,.vue,.ts,.tsx,.jsx --ignore-path .gitignore -f unix <args>
" command! -nargs=* LMakeLintFix lmake --fix --ext .js,.vue,.ts,.tsx,.jsx --ignore-path .gitignore -f unix <args>

" Run linting on the current file...
noremap <leader>l% :LMakeLint % \| lopen<cr>
" Run linting on the cwd...
noremap <leader>l. :MakeLint . \| copen<cr>
" Fix problems in current file...
noremap <leader>lf :LMakeLintFix %<cr>

noremap <leader>lo :lopen<cr>
noremap <leader>ln :lne<cr>
noremap <leader>lp :lp<cr>

noremap <leader>co :copen<cr>
noremap <leader>cn :cn<cr>
noremap <leader>cp :cp<cr>

" Runs eslint and prints results to a buffer...
function Lint(dir)
  silent! bd! {linter}
  echo 'Linting...'
  exe 'silent! pedit +setfiletype\ sh\|0read!' &makeprg . '\ ' . a:dir . ' linter'
endfunction
command! -nargs=* -complete=dir LintFile call Lint(expand("<args>"))

function FixLint(dir)
  echo 'Fixing...'
  call system(&makeprg . ' --fix --ext .js,.vue,.ts,.tsx,.jsx --ignore-path .gitignore ' . a:dir)
  e!
  echo 'Done!'
endfunction
command! -nargs=* -complete=dir FixLintFile call FixLint(expand("<args>"))

" ----------------------------------------------------------------------------------------  SHOW MARKS  -------------------------------------------------------------------------------------------------

autocmd VimEnter * DoShowMarks!

nnoremap mQ :mark Q \| DoShowMarks<cr>
nnoremap mW :mark W \| DoShowMarks<cr>
nnoremap mE :mark E \| DoShowMarks<cr>
nnoremap mR :mark R \| DoShowMarks<cr>
nnoremap mT :mark T \| DoShowMarks<cr>
nnoremap mY :mark Y \| DoShowMarks<cr>
nnoremap mU :mark U \| DoShowMarks<cr>
nnoremap mI :mark I \| DoShowMarks<cr>
nnoremap mO :mark O \| DoShowMarks<cr>
nnoremap mP :mark P \| DoShowMarks<cr>
nnoremap mA :mark A \| DoShowMarks<cr>
nnoremap mS :mark S \| DoShowMarks<cr>
nnoremap mD :mark D \| DoShowMarks<cr>
nnoremap mF :mark F \| DoShowMarks<cr>
nnoremap mG :mark G \| DoShowMarks<cr>
nnoremap mH :mark H \| DoShowMarks<cr>
nnoremap mJ :mark J \| DoShowMarks<cr>
nnoremap mK :mark K \| DoShowMarks<cr>
nnoremap mL :mark L \| DoShowMarks<cr>
nnoremap mZ :mark Z \| DoShowMarks<cr>
nnoremap mX :mark X \| DoShowMarks<cr>
nnoremap mC :mark C \| DoShowMarks<cr>
nnoremap mV :mark V \| DoShowMarks<cr>
nnoremap mB :mark B \| DoShowMarks<cr>
nnoremap mN :mark N \| DoShowMarks<cr>
nnoremap mM :mark M \| DoShowMarks<cr>

nnoremap mq :mark q \| DoShowMarks<cr>
nnoremap mw :mark w \| DoShowMarks<cr>
nnoremap me :mark e \| DoShowMarks<cr>
nnoremap mr :mark r \| DoShowMarks<cr>
nnoremap mt :mark t \| DoShowMarks<cr>
nnoremap my :mark y \| DoShowMarks<cr>
nnoremap mu :mark u \| DoShowMarks<cr>
nnoremap mi :mark i \| DoShowMarks<cr>
nnoremap mo :mark o \| DoShowMarks<cr>
nnoremap mp :mark p \| DoShowMarks<cr>
nnoremap ma :mark a \| DoShowMarks<cr>
nnoremap ms :mark s \| DoShowMarks<cr>
nnoremap md :mark d \| DoShowMarks<cr>
nnoremap mf :mark f \| DoShowMarks<cr>
nnoremap mg :mark g \| DoShowMarks<cr>
nnoremap mh :mark h \| DoShowMarks<cr>
nnoremap mj :mark j \| DoShowMarks<cr>
nnoremap mk :mark k \| DoShowMarks<cr>
nnoremap ml :mark l \| DoShowMarks<cr>
nnoremap mz :mark z \| DoShowMarks<cr>
nnoremap mx :mark x \| DoShowMarks<cr>
nnoremap mc :mark c \| DoShowMarks<cr>
nnoremap mv :mark v \| DoShowMarks<cr>
nnoremap mb :mark b \| DoShowMarks<cr>
nnoremap mn :mark n \| DoShowMarks<cr>
nnoremap mm :mark m \| DoShowMarks<cr>

nnoremap dmQ :delm Q \| DoShowMarks<cr>
nnoremap dmW :delm W \| DoShowMarks<cr>
nnoremap dmE :delm E \| DoShowMarks<cr>
nnoremap dmR :delm R \| DoShowMarks<cr>
nnoremap dmT :delm T \| DoShowMarks<cr>
nnoremap dmY :delm Y \| DoShowMarks<cr>
nnoremap dmU :delm U \| DoShowMarks<cr>
nnoremap dmI :delm I \| DoShowMarks<cr>
nnoremap dmO :delm O \| DoShowMarks<cr>
nnoremap dmP :delm P \| DoShowMarks<cr>
nnoremap dmA :delm A \| DoShowMarks<cr>
nnoremap dmS :delm S \| DoShowMarks<cr>
nnoremap dmD :delm D \| DoShowMarks<cr>
nnoremap dmF :delm F \| DoShowMarks<cr>
nnoremap dmG :delm G \| DoShowMarks<cr>
nnoremap dmH :delm H \| DoShowMarks<cr>
nnoremap dmJ :delm J \| DoShowMarks<cr>
nnoremap dmK :delm K \| DoShowMarks<cr>
nnoremap dmL :delm L \| DoShowMarks<cr>
nnoremap dmZ :delm Z \| DoShowMarks<cr>
nnoremap dmX :delm X \| DoShowMarks<cr>
nnoremap dmC :delm C \| DoShowMarks<cr>
nnoremap dmV :delm V \| DoShowMarks<cr>
nnoremap dmB :delm B \| DoShowMarks<cr>
nnoremap dmN :delm N \| DoShowMarks<cr>
nnoremap dmM :delm M \| DoShowMarks<cr>

nnoremap dmq :delm q \| DoShowMarks<cr>
nnoremap dmw :delm w \| DoShowMarks<cr>
nnoremap dme :delm e \| DoShowMarks<cr>
nnoremap dmr :delm r \| DoShowMarks<cr>
nnoremap dmt :delm t \| DoShowMarks<cr>
nnoremap dmy :delm y \| DoShowMarks<cr>
nnoremap dmu :delm u \| DoShowMarks<cr>
nnoremap dmi :delm i \| DoShowMarks<cr>
nnoremap dmo :delm o \| DoShowMarks<cr>
nnoremap dmp :delm p \| DoShowMarks<cr>
nnoremap dma :delm a \| DoShowMarks<cr>
nnoremap dms :delm s \| DoShowMarks<cr>
nnoremap dmd :delm d \| DoShowMarks<cr>
nnoremap dmf :delm f \| DoShowMarks<cr>
nnoremap dmg :delm g \| DoShowMarks<cr>
nnoremap dmh :delm h \| DoShowMarks<cr>
nnoremap dmj :delm j \| DoShowMarks<cr>
nnoremap dmk :delm k \| DoShowMarks<cr>
nnoremap dml :delm l \| DoShowMarks<cr>
nnoremap dmz :delm z \| DoShowMarks<cr>
nnoremap dmx :delm x \| DoShowMarks<cr>
nnoremap dmc :delm c \| DoShowMarks<cr>
nnoremap dmv :delm v \| DoShowMarks<cr>
nnoremap dmb :delm b \| DoShowMarks<cr>
nnoremap dmn :delm n \| DoShowMarks<cr>
nnoremap dmm :delm m \| DoShowMarks<cr>

" -------------------------------------------------------------------------------------------  MDN  ----------------------------------------------------------------------------------------------------

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
  execute "set filetype=" . a:filetype
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

command! -nargs=* MDN call MdnSplit('<args>')
noremap <leader>mdn :MDN 

" ------------------------------------------------------------------------------------------  JTAGS  --------------------------------------------------------------------------------------------------

" Custom tags command that saves tags one by one...
function! SaveToJtags(pattern)
  silent! call system("$HOME/.vim/scripts/./jtags " . a:pattern)
endfunc
function TryTagOrSaveJtag()
  let l:pattern = expand("<cword>")
  try
    " First, try the tag in case we already have it...
    exe v:count . 'tag! ' . l:pattern
  catch
    " Otherwise run the jtags script...
    call SaveToJtags(l:pattern)
    exe v:count . 'tag! ' . l:pattern
  finally
    " This adds the relative filepath to the "p reg as well...
    silent! let @p = trim(system('realpath --relative-to=' . expand("#:h") . ' ' . expand("%")))
  endtry
endfunction
noremap <silent> <c-]> :<c-u>call TryTagOrSaveJtag()<cr>

" ------------------------------------------------------------------------------------------  TMUX  ----------------------------------------------------------------------------------------------------

function FileOrDir()
  if len(expand('%'))
    return '%'
  endif

  return '%:p:h'
endfunc

" Open ranger in a tmux split with the current file selected...
noremap <leader>. :silent call system('tmux split bash -c "export TERM=xterm-256color; export HIGHLIGHT_STYLE=zenburn && ranger --selectfile=' . expand(FileOrDir()) . '"')<cr>

" Can add a mapping to ranger rc.conf that looks like this to open files in
" vim...
" map e shell tmux send -t! ':e ' %p '^M'

" fzf file browser (enter moves dir, ctrl-l opens in vim)
if strlen(system('echo $TMUX')) > 1
  noremap <silent> <leader>rr :silent !tmux split bash -c "export TERM=xterm-256color; export BAT_THEME=gruvbox-dark; ranger %:p:h<tab>"<cr>
  noremap <silent> <leader>rj :silent !tmux split -v bash -c "export TERM=xterm-256color; export BAT_THEME=gruvbox-dark; ranger %:p:h<tab>"<cr>
  noremap <silent> <leader>rk :silent !tmux split -v -b bash -c "export TERM=xterm-256color; export BAT_THEME=gruvbox-dark; ranger %:p:h<tab>"<cr>
  noremap <silent> <leader>rl :silent !tmux split -h bash -c "export TERM=xterm-256color; export BAT_THEME=gruvbox-dark; ranger %:p:h<tab>"<cr>
  noremap <silent> <leader>rh :silent !tmux split -h -b bash -c "export TERM=xterm-256color; export BAT_THEME=gruvbox-dark; ranger %:p:h<tab>"<cr>
  " noremap <silent> <leader>. :silent !tmux split bash -c "export TERM=xterm-256color; export BAT_THEME=gruvbox-dark; ~/.vim/scripts/./fzf-tree %:p:h<tab>"<cr>
  noremap <silent> <leader>pp :silent !tmux split bash -c "export TERM=xterm-256color; export BAT_THEME=gruvbox-dark; ~/.vim/scripts/./fzf-files ."<cr>
  noremap <silent> <leader>pw :silent !tmux split bash -c "export TERM=xterm-256color; export BAT_THEME=gruvbox-dark; ~/.vim/scripts/./fzf-files . '<c-r><c-w>'"<cr>
  " noremap <silent> <leader>ff :silent !tmux split bash -c "export TERM=xterm-256color; export BAT_THEME=gruvbox-dark; ~/.vim/scripts/./fzf-search ."<cr>
  noremap <silent> <leader>fw :silent !tmux split bash -c "export TERM=xterm-256color; export BAT_THEME=gruvbox-dark; ~/.vim/scripts/./fzf-search . '<c-r><c-w>'"<cr>
  noremap <silent> <leader>fW "fyW:silent !tmux split bash -c "export TERM=xterm-256color; export BAT_THEME=gruvbox-dark; ~/.vim/scripts/./fzf-search . '<c-r>f'"<cr>
  noremap <silent> <leader>fp :silent !tmux split bash -c "export TERM=xterm-256color; export BAT_THEME=gruvbox-dark; ~/.vim/scripts/./fzf-search . '%:t<tab><bs>'"<cr>

  " TODO This only jumps backward
  " noremap <silent> <leader>jj :redir! > ~/.vim/tmp/jumps \| silent! jumps \| redir END \| silent! !tmux split zsh -c "export TERM=xterm-256color; export BAT_THEME=gruvbox-dark; ~/.vim/scripts/./fzf-jumps"<cr>
endif

" -----------------------------------------------------------------------------------------  REGPREVIEW  -------------------------------------------------------------------------------------------------

function! RegPop ()
  " let s:popid = popup_create(split(execute('reg'), '\n'), #{
  "       \ line: 38,
  "       \ col: 168,
  "       \ maxwidth: 45,
  "       \ maxheight: 21,
  "       \ wrap: 0,
  "       \ close: 'button',
  "       \ })
endfunc

" -----------------------------------------------------------------------------------------  FUGITIVE  -------------------------------------------------------------------------------------------------

" Add a commit or branch name to the "d" register then you can use
" it to diff any file from the current branch...
noremap <leader>pd :Gdiff <c-r>d<cr>
nnoremap <silent> <leader>gg :G<cr>
nnoremap <leader>gd :Gdiff 
nnoremap <leader>gc :G checkout 
nnoremap <silent> <leader>gr :Gread<cr>
nnoremap <silent> <leader>gb :G blame<cr>
nnoremap <leader>gpp :G pull origin 
nnoremap <leader>gpu :!git push -u origin $(git branch --show-current)<cr>
nnoremap <leader>gl :G log<cr>

" Note, this always refers to the cwd git repo...
nnoremap <leader>fch :!git checkout $(git branch \| fzf)<cr>

" -----------------------------------------------------------------------------------------  MAPPINGS  -------------------------------------------------------------------------------------------------

nnoremap <silent> [f :let @f = '[{@f' \| norm @f<cr>
nnoremap <silent> ]f :let @f = ']}@f' \| norm @f<cr>

inoremap <c-j> <c-o>J

" Create a CodeCommit PR (needs aws installed)
" nnoremap <leader><leader>pr :echo system('aws codecommit create-pull-request --title "' . FugitiveHead() . '" --targets sourceReference=' . FugitiveHead() . ',repositoryName=$(git remote get-url origin \| awk -F "/" \'{print $(NF)}\')')<cr>

" Create or edit a test file for this component
nnoremap <leader>tt :exe 'e ' . expand('%:s?js?test.js?')<cr>
" Create or edit a component version of this test
nnoremap <leader>tc :exe 'e ' . expand('%:s?test.js?js?')<cr>

" Quick search case-insensitive
noremap <leader>/ /\c

" Quick git command (ends with a space)
noremap <leader>g<leader> :G 

" Do Kakoun type mappings for end and start of line
noremap gh 0
noremap gl $

" Jump commands that use va...
nnoremap [t vato<esc>
nnoremap ]t vat<esc>
nnoremap ]" va"<esc>
nnoremap [" va"o<esc>
nnoremap ]' va'<esc>
nnoremap [' va'o<esc>
nnoremap ]> va><esc>
nnoremap [> va>o<esc>
" nnoremap [f [{?\w(<cr>^:noh<cr>
" nnoremap ]f /\w(<cr>f(%f{%:noh<cr>
nnoremap [[ va[<esc>%
nnoremap ]] va[<esc>

" Add a eslint ignore comment above
nnoremap <leader>iO O/* eslint-disable */<esc>
nnoremap <leader>io o/* eslint-disable */<esc>
nnoremap <leader>ii cc/* eslint-disable */<esc>

" Run this file with node-repl
noremap <leader>! :!pretty-repl %<tab><cr>

" type any word then press ctrl-a in insert mode to console log it
" with an id string...
inoremap <c-a> <esc>^Cconsole.log(`@FILTER <c-r>":`, <c-r>")
inoremap <c-f> <esc>^Cconsole.log(`@FILTER <c-r>"`)

inoremap {<Space> {  }<Left><Left>
inoremap {{<Space> {{  }}<Left><Left><Left>
inoremap ({<Space> ({  })<Left><Left><Left>
inoremap [{<Space> [{  }]<Left><Left><Left>
inoremap (<Space> ()<Left>
inoremap [<Space> []<Left>
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap {<cr> {<cr>}<esc>O
inoremap {{<cr> {{<cr>}}<esc>O
inoremap ({<cr> ({<cr>})<esc>O
inoremap [{<cr> [{<cr>}]<esc>O
inoremap `<cr> `<cr>`<esc>O
inoremap {`<cr> {`<cr>`}<c-d><esc>O
inoremap [`<cr> [`<cr>`]<c-d><esc>O
inoremap (`<cr> (`<cr>`)<c-d><esc>O
inoremap ({`<cr> ({`<cr>`})<c-d><esc>O
inoremap ([`<cr> ([`<cr>`])<c-d><esc>O
" TODO make a function that detects if this is the second quote or not
" inoremap ' ''<Left>
" inoremap " ""<Left>

" re-maps capital Yank to yank till the end of the line
noremap Y y$

" Attempts to put a single line of properties (eg: {1,2,3}) onto multiple lines
noremap <silent> <leader>g= :silent! s/\([{\[(]\)\(.\{-}\)\([}\])]\)/\1\r\2\r\3/ \| silent! -1s/ //g \| silent! s/,/,\r/g \| silent! s/$/,/<cr>j=%
noremap <silent> <leader>g- /[}\])]<cr>v%J<esc>:s/,\([ ]\?}\)/\1/g<cr>gv:s/:/: /g<cr>
" Puts html attributes onto multi-lines
noremap <silent> <leader>=< :silent! s/\(<[a-zA-z-]\+\)\s/\1\r/ \| silent! s/>/\r>/g \| silent! -1s/\s/\r/g<cr>=a<:noh<cr>
noremap <silent> <leader>=> :silent! s/\(<[a-zA-z-]\+\)\s/\1\r/ \| silent! s/>/\r>/g \| silent! -1s/\s/\r/g<cr>=a<:noh<cr>

" select last pasted text
nnoremap gp `[v`]

" Moving lines up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" New tab
noremap <c-w>gn :tab new %<CR>

noremap <leader>> :diffput<cr>
noremap <leader>< :diffget<cr>

" Split a jsx component's props onto multi lines
noremap <leader>t= 0f<f v/\/>\\|><cr>hc<cr><c-r>"<cr><esc>kA<bs><esc>0dwv$:s/ /\r/g<cr>='[:noh<cr>
noremap <leader>t- ?<<cr>v/\/>\\|><cr>J<esc>:noh<cr>
" Go to the styles from a style.<name> for RN
noremap gs <c-w>v"syiwbbgdf'gf/<c-r>s<cr>

" Running node scripts
noremap <leader><leader>r :w! \| silent pedit! +setfiletype\ javascript\|0read!node\ . console<cr>

" Show marks before jumping to mark position...
noremap <leader>' :marks<cr>:'

" " Auto indent when pasting...
" nnoremap p :pu<cr>='['[
" nnoremap P P='['[

" Find Vue component sections
nnoremap <leader>vst /<style/s+1<cr>
nnoremap <leader>vd /data()<cr>
nnoremap <leader>vc /computed:<cr>
nnoremap <leader>vm /methods:<cr>
nnoremap <leader>vp /props:<cr>
nnoremap <leader>vsc /<script/s+1<cr>

" Quick finds (this is backwards to usual vim commands but feels more natural
" because of how the * key usually works)

" Quicker search for word under cursor (also not as specific)
" Forwards
noremap <leader>nw /<c-r><c-w><cr>
noremap <leader>n" /<c-r>"<cr>
nnoremap <leader>na" "fya"/<c-r>f<cr>
nnoremap <leader>na' "fya'/<c-r>f<cr>
nnoremap <leader>na< "fya</<c-r>f<cr>
nnoremap <leader>na> "fya>/<c-r>f<cr>
nnoremap <leader>na( "fya(/<c-r>f<cr>
nnoremap <leader>na) "fya)/<c-r>f<cr>
nnoremap <leader>nab "fyab/<c-r>f<cr>
nnoremap <leader>naB "fyaB/<c-r>f<cr>
nnoremap <leader>na[ "fya[/<c-r>f<cr>
nnoremap <leader>na] "fya]/<c-r>f<cr>
nnoremap <leader>na{ "fya{/<c-r>f<cr>
nnoremap <leader>na} "fya}/<c-r>f<cr>
nnoremap <leader>ni" "fyi"/<c-r>f<cr>
nnoremap <leader>ni' "fyi'/<c-r>f<cr>
nnoremap <leader>ni< "fyi</<c-r>f<cr>
nnoremap <leader>ni> "fyi>/<c-r>f<cr>
nnoremap <leader>ni( "fyi(/<c-r>f<cr>
nnoremap <leader>ni) "fyi)/<c-r>f<cr>
nnoremap <leader>nib "fyib/<c-r>f<cr>
nnoremap <leader>niB "fyiB/<c-r>f<cr>
nnoremap <leader>ni[ "fyi[/<c-r>f<cr>
nnoremap <leader>ni] "fyi]/<c-r>f<cr>
nnoremap <leader>ni{ "fyi{/<c-r>f<cr>
nnoremap <leader>ni} "fyi}/<c-r>f<cr>
nnoremap <leader>nit "fyit/<c-r>f<cr>
nnoremap <leader>nW "fyW/<c-r>f<cr>
nnoremap <leader>niW "fyiW/<c-r>f<cr>
" These both mapped to buffer switching
" nnoremap <leader>bn "fyb/<c-r>f<cr>
" nnoremap <leader>Bn "fyB/<c-r>f<cr>
nnoremap <leader>ne "fye/<c-r>f<cr>
nnoremap <leader>nE "fyE/<c-r>f<cr>

" Backwards
noremap <leader>Nw ?<c-r><c-w><cr>
noremap <leader>N" ?<c-r>"<cr>
nnoremap <leader>Na" "fya"?<c-r>f<cr>
nnoremap <leader>Na' "fya'?<c-r>f<cr>
nnoremap <leader>Na< "fya<?<c-r>f<cr>
nnoremap <leader>Na> "fya>?<c-r>f<cr>
nnoremap <leader>Na( "fya(?<c-r>f<cr>
nnoremap <leader>Na) "fya)?<c-r>f<cr>
nnoremap <leader>Nab "fyab?<c-r>f<cr>
nnoremap <leader>NaB "fyaB?<c-r>f<cr>
nnoremap <leader>Na[ "fya[?<c-r>f<cr>
nnoremap <leader>Na] "fya]?<c-r>f<cr>
nnoremap <leader>Na{ "fya{?<c-r>f<cr>
nnoremap <leader>Na} "fya}?<c-r>f<cr>
nnoremap <leader>Ni" "fyi"?<c-r>f<cr>
nnoremap <leader>Ni' "fyi'?<c-r>f<cr>
nnoremap <leader>Ni< "fyi<?<c-r>f<cr>
nnoremap <leader>Ni> "fyi>?<c-r>f<cr>
nnoremap <leader>Ni( "fyi(?<c-r>f<cr>
nnoremap <leader>Ni) "fyi)?<c-r>f<cr>
nnoremap <leader>Nib "fyib?<c-r>f<cr>
nnoremap <leader>NiB "fyiB?<c-r>f<cr>
nnoremap <leader>Ni[ "fyi[?<c-r>f<cr>
nnoremap <leader>Ni] "fyi]?<c-r>f<cr>
nnoremap <leader>Ni{ "fyi{?<c-r>f<cr>
nnoremap <leader>Ni} "fyi}?<c-r>f<cr>
nnoremap <leader>NW "fyW?<c-r>f<cr>
nnoremap <leader>NiW "fyiW?<c-r>f<cr>
nnoremap <leader>Ne "fye?<c-r>f<cr>
nnoremap <leader>NE "fyE?<c-r>f<cr>

" Exact matches
nnoremap <leader>a"* "fya"/\<<c-r>f\><cr>
nnoremap <leader>a'* "fya'/\<<c-r>f\><cr>
nnoremap <leader>a<* "fya</\<<c-r>f\><cr>
nnoremap <leader>a>* "fya>/\<<c-r>f\><cr>
nnoremap <leader>a(* "fya(/\<<c-r>f\><cr>
nnoremap <leader>a)* "fya)/\<<c-r>f\><cr>
nnoremap <leader>ab* "fyab/\<<c-r>f\><cr>
nnoremap <leader>aB* "fyaB/\<<c-r>f\><cr>
nnoremap <leader>a[* "fya[/\<<c-r>f\><cr>
nnoremap <leader>a]* "fya]/\<<c-r>f\><cr>
nnoremap <leader>a{* "fya{/\<<c-r>f\><cr>
nnoremap <leader>a}* "fya}/\<<c-r>f\><cr>
nnoremap <leader>i"* "fyi"/\<<c-r>f\><cr>
nnoremap <leader>i'* "fyi'/\<<c-r>f\><cr>
nnoremap <leader>i<* "fyi</\<<c-r>f\><cr>
nnoremap <leader>i>* "fyi>/\<<c-r>f\><cr>
nnoremap <leader>i(* "fyi(/\<<c-r>f\><cr>
nnoremap <leader>i)* "fyi)/\<<c-r>f\><cr>
nnoremap <leader>ib* "fyib/\<<c-r>f\><cr>
nnoremap <leader>iB* "fyiB/\<<c-r>f\><cr>
nnoremap <leader>i[* "fyi[/\<<c-r>f\><cr>
nnoremap <leader>i]* "fyi]/\<<c-r>f\><cr>
nnoremap <leader>i{* "fyi{/\<<c-r>f\><cr>
nnoremap <leader>i}* "fyi}/\<<c-r>f\><cr>
nnoremap <leader>W* "fyW/\<<c-r>f\><cr>
nnoremap <leader>iW* "fyiW/\<<c-r>f\><cr>
nnoremap <leader>b* "fyb/\<<c-r>f\><cr>
nnoremap <leader>B* "fyB/\<<c-r>f\><cr>
nnoremap <leader>e* "fye/\<<c-r>f\><cr>
nnoremap <leader>E* "fyE/\<<c-r>f\><cr>

" Exact matches backwards
nnoremap <leader>a"# "fya"?\<<c-r>f\><cr>
nnoremap <leader>a'# "fya'?\<<c-r>f\><cr>
nnoremap <leader>a<# "fya<?\<<c-r>f\><cr>
nnoremap <leader>a># "fya>?\<<c-r>f\><cr>
nnoremap <leader>a(# "fya(?\<<c-r>f\><cr>
nnoremap <leader>a)# "fya)?\<<c-r>f\><cr>
nnoremap <leader>ab# "fyab?\<<c-r>f\><cr>
nnoremap <leader>aB# "fyaB?\<<c-r>f\><cr>
nnoremap <leader>a[# "fya[?\<<c-r>f\><cr>
nnoremap <leader>a]# "fya]?\<<c-r>f\><cr>
nnoremap <leader>a{# "fya{?\<<c-r>f\><cr>
nnoremap <leader>a}# "fya}?\<<c-r>f\><cr>
nnoremap <leader>i"# "fyi"?\<<c-r>f\><cr>
nnoremap <leader>i'# "fyi'?\<<c-r>f\><cr>
nnoremap <leader>i<# "fyi<?\<<c-r>f\><cr>
nnoremap <leader>i># "fyi>?\<<c-r>f\><cr>
nnoremap <leader>i(# "fyi(?\<<c-r>f\><cr>
nnoremap <leader>i)# "fyi)?\<<c-r>f\><cr>
nnoremap <leader>ib# "fyib?\<<c-r>f\><cr>
nnoremap <leader>iB# "fyiB?\<<c-r>f\><cr>
nnoremap <leader>i[# "fyi[?\<<c-r>f\><cr>
nnoremap <leader>i]# "fyi]?\<<c-r>f\><cr>
nnoremap <leader>i{# "fyi{?\<<c-r>f\><cr>
nnoremap <leader>i}# "fyi}?\<<c-r>f\><cr>
nnoremap <leader>W# "fyW?\<<c-r>f\><cr>
nnoremap <leader>iW# "fyiW?\<<c-r>f\><cr>
nnoremap <leader>b# "fyb/?<<c-r>f\><cr>
nnoremap <leader>B# "fyB/?<<c-r>f\><cr>
nnoremap <leader>e# "fye/?<<c-r>f\><cr>
nnoremap <leader>E# "fyE/?<<c-r>f\><cr>

" Shortcut to find conflict markers...
nnoremap <leader>C :ConflictMarkers<cr>

" Find function mappings
function FindFunctionPattern()
  return '\(\([\[(]\| \|.\n\|\n\)[a-zA-Z_.]\+(\| (.*) =>\)'
endfunc

function Executer(execution)
  " Set a local count var
  let s:count = 1
  if v:count
    let s:count = v:count
  endif

  " Run the execution 
  while s:count > 0
    exe a:execution
    let s:count = s:count - 1
  endwhile
endfunc

" JS Function movements...
onoremap ix :<c-u>silent! call Executer("norm! /" . FindFunctionPattern() . "/s+1\r/(\rvib")<cr>
onoremap iX :<c-u>silent! call Executer("norm! ?" . FindFunctionPattern() . "?s+1\r/(\rvib")<cr>
onoremap x :<c-u>silent! call Executer("norm! /" . FindFunctionPattern() . "/s+1\r")<cr>
onoremap X :<c-u>silent! call Executer("norm! ?" . FindFunctionPattern() . "?s+1\r")<cr>
nnoremap ]x :<c-u>silent! call Executer("norm! /" . FindFunctionPattern() . "/s+1\r")<cr>
nnoremap [x :<c-u>silent! call Executer("norm! ?" . FindFunctionPattern() . "?s+1\r")<cr>
vnoremap ]x :<c-u>silent! call Executer("norm! \egv/" . FindFunctionPattern() . "/s+1\r")<cr>
vnoremap [x :<c-u>silent! call Executer("norm! \egv?" . FindFunctionPattern() . "?s+1\r")<cr>

" Return movements...
onoremap r :<c-u>silent! call Executer("norm! /return\r")<cr>
onoremap R :<c-u>silent! call Executer("norm! ?return\r")<cr>
nnoremap ]r :<c-u>silent! call Executer("norm! /return\r")<cr>
nnoremap [r :<c-u>silent! call Executer("norm! ?return\r")<cr>
vnoremap ]r :<c-u>silent! call Executer("norm! \egv/return\r")<cr>
vnoremap [r :<c-u>silent! call Executer("norm! \egv?return\r")<cr>

" If movements...
onoremap ih :<c-u>silent! call Executer("norm! /if (/e\rvib")<cr>
onoremap iH :<c-u>silent! call Executer("norm! ?if (?e\rvib")<cr>
onoremap h :<c-u>silent! call Executer("norm! /if (/e\r")<cr>
onoremap H :<c-u>silent! call Executer("norm! ?if (?e\r")<cr>
nnoremap ]h :<c-u>silent! call Executer("norm! /if (/e\r")<cr>
nnoremap [h :<c-u>silent! call Executer("norm! ?if (?e\r")<cr>
vnoremap ]h :<c-u>silent! call Executer("norm! \egv/if (/e\r")<cr>
vnoremap [h :<c-u>silent! call Executer("norm! \egv?if (?e\r")<cr>

" -----------------------------------------------------------------------------------------  Foldeasy  ---------------------------------------------------------------------------------------------------

let g:foldeasy_on = 0

func! FoldEasyOff()
    let g:foldeasy_on = 0
    silent! unmap k
    silent! unmap j
    silent! unmap <c-d>
    silent! unmap <c-u>
    silent! unmap gg
    silent! unmap G
    silent! unmap <esc>
    echo 'Fold mode off'
endfunc

func! FoldEasyDown()
    let g:foldeasy_on = 1
    silent! nnoremap k :silent! call Executer("norm! zd")<cr>
    nnoremap j :call Executer("norm! zfj<c-e>")<cr>
    silent! nnoremap <c-u> :silent! call Executer("norm! zd")<cr>
    nnoremap <c-d> :call Executer("norm! 37zfj37<c-e>")<cr>
    nnoremap <esc> :call FoldEasyOff()<cr>
    echo 'Fold mode on (down)'
endfunc

func! FoldEasyUp()
    let g:foldeasy_on = 1
    nnoremap k :call Executer("norm! zfk<c-y>")<cr>
    silent! nnoremap j :silent! call Executer("norm! zdj<c-e>")<cr>
    nnoremap <c-u> :call Executer("norm! 37zfk37<c-y>")<cr>
    silent! nnoremap <c-d> :silent! call Executer("norm! zd")<cr>
    nnoremap <esc> :call FoldEasyOff()<cr>
    echo 'Fold mode on (up)'
endfunc

nnoremap <leader>zk :call FoldEasyUp()<cr>
nnoremap <leader>zj :call FoldEasyDown()<cr>

" -----------------------------------------------------------------------------------------  GOTO  -------------------------------------------------------------------------------------------------

" A smarter goto file command...
function GotoFileSpecial()
  let l:filepath = expand("<cfile>")

  let l:homepath     = l:filepath[0] == '~'
  let l:varpath      = l:filepath[0] == '$'
  let l:rootpath     = l:filepath[0] == '/'
  let l:relativepath = l:filepath[0] == '.'
  let l:atpath       = l:filepath[0] == '@'

  try
    if l:homepath
      exe v:count 'find ' . getcwd() . '/' . l:filepath[1:] . '*'
    elseif l:varpath
      exe v:count 'find ' . l:filepath . '*'
    elseif l:rootpath
      exe v:count 'find ' . getcwd() . l:filepath . '*'

    elseif l:relativepath
      try
        " Sometimes this causes a too many filenames error
        " because of the '*'...
        exe v:count 'find %:h/' . l:filepath . '*'
      catch
        exe v:count 'find %:h/' . l:filepath
      endtry
      return
    else
      try
        try
          exe v:count 'find node_modules/' . l:filepath
        catch
          " An '@' path could be home (in vue) or a modules folder,
          " but l:atpath doesn't work because <cfile> ignores @ signs :(
          " Add the @ sign in...
          exe v:count 'find node_modules/' . '@' . l:filepath
        endtry

      catch
        exe v:count 'find ' . trim(getcwd() . '/' . substitute(l:filepath, '^\/', '', 'g')) . '*'

      endtry
    endif
  catch
    echo "Find error, are you sure you're cd'd into the right dir?"
  endtry
endfunction

function GotoFile()
  try
    exe v:count 'find <cfile>'
  catch
    call GotoFileSpecial()
  endtry
endfunction
noremap gf :call GotoFile()<cr>

" -----------------------------------------------------------------------------------------  NINTER  ------------------------------------------------------------------------------------

function Ninter()
  let l:suggestions = systemlist('node $HOME/.vim/scripts/ninter/index.js')
  call complete(col('.'), l:suggestions)
  return ''
endfunction

" What would work best, would be if node was running on a server and was being
" fed the file you're currently working on using an autocmd.
"
" That would keep vim's workload super light, then all it needs to do is send
" a request (via curl or wget) with the position of the cursor, then the
" server could respond with the list of words.
"
" So the first request sends a filepath from an autocmd. This updates the server to loop over
" that file.
"
" Then a second or subsequent request would send the position, returning the
" suggestions.
"
" Later on the first request could check for imported modules, it'll ask the
" user if they want to include them which would cause the server to install
" that module and allow it to include that module's API.
"
