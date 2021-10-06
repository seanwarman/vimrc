source $HOME/.vim/custom/functions.vim
source $HOME/.vim/custom/snippets.vim

" -----------------------------------------------------------------------------------------  PLUGINS  --------------------------------------------------------------------------------------------------

call plug#begin('~/.local/share/vim/plugged')
  " These colorschemes break the term vim's colours
  " so only load them in the gui version...
  if has("gui_macvim")
    Plug 'flazz/vim-colorschemes'
  endif

  " Syntax
  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'posva/vim-vue'

  " CSS
  Plug 'KabbAmine/vCoolor.vim'
  Plug 'ap/vim-css-color'

  " Dirvish, amaze...
  Plug 'justinmk/vim-dirvish'

  " Best git plugin ever
  Plug 'tpope/vim-fugitive'
  Plug 'tommcdo/vim-fugitive-blame-ext'

  " General utils
  Plug 'itchyny/vim-cursorword'
  Plug 'adelarsq/vim-matchit'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-abolish'
  Plug 'justinmk/vim-sneak'
  Plug 'mhinz/vim-startify'
  Plug 'MattesGroeger/vim-bookmarks'
  Plug 'mattn/emmet-vim'

  " Nice extras
  Plug 'vim-utils/vim-man'
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
map Q gq

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

" -----------------------------------------------------------------------------------------  PLUGCONF  -------------------------------------------------------------------------------------------------

" Remaps the spacebar as leader
nnoremap <space> <Nop>
let mapleader = " "

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
      \ $HOME . "/code/mobileapp-react-two/active.env.js",
\]

let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'files',     'header': ['   Recent Files']   },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]

let g:vue_pre_processors = ['scss']

" -----------------------------------------------------------------------------------------  SESSIONS  -------------------------------------------------------------------------------------------------

function SaveSesh(name)
  exe 'SSave ' . a:name
endfunction

map <leader>ss :call SaveSesh(fnamemodify(getcwd(), ':t') . '-' . FugitiveHead())<cr>

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
        \ 'whitebox'
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

command! -nargs=* Dark :exe 'colo' DarkColours()[<args>]
command! -nargs=* Light :exe 'colo' LightColours()[<args>]

" colo slate
if has("gui_macvim")
  Dark 1
else
  colo slate
endif

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

autocmd TerminalOpen,TermChanged,TerminalWinOpen,Syntax * silent! call SetAnsiTermColours()

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
map <leader><leader>a :let g:args_or_buffers = 'args'<cr>
map <leader><leader>b :let g:args_or_buffers = 'buffers'<cr>

function ListArgsOrBuffers()
  if g:args_or_buffers == 'args'
    return ListArgs()
  elseif g:args_or_buffers == 'buffers'
    return ListBuffers()
  else
    return ''
  endif
endfunction

" Status line that shows the args or the bufs list
set statusline=%#MatchParen#\ %{fnamemodify(getcwd(),':t')}\ %*%#StatusLineTerm#\ %{FugitiveHead()}\ %*\ %t:%p%%\ %#ErrorMsg#%m%*%=%{ListArgsOrBuffers()}\ 

" Always show the statusline
set laststatus=2

" -----------------------------------------------------------------------------------------  BUFFERS/ARGS  ---------------------------------------------------------------------------------------------

" Buffer maps
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
    exe 'bd! ' ListEmptyBufNums()
  else 
    echo 'No empty buffers'
  endif
endfunction
map <leader>bde :call DeleteEmptyBuffers()<cr>
map <leader>bd* :exe 'bd! ' ListAllBufNums(-1)<cr>

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
  echo l:paths
  if len(l:paths)
    exe 'bd!' join(ListAllBufsNotInArgv())
  endif
  call DeleteEmptyBuffers()
endfunction

" Buffer mappings
map <leader>bp :bp<cr>
map <leader>bn :bn<cr>
map <leader>bdd :bd!<cr>
" Select buffer from completion menu...
map <leader>b<tab> q:ib <tab>
map <leader>bdD :sil! call DeleteAllBufsNotInArgv()<cr>

" Args list mappings
map <leader>an :n<cr>
map <leader>ap :N<cr>
map <leader>aa :argadd %<cr>
" Add all open buffers to the args list...
map <leader>aA :exe 'argadd' join(ListAllBufNames())<cr>
map <leader>add :argdelete %<cr>
map <leader>al :sall<cr>
map <leader>adD :argdelete *<cr>

" -----------------------------------------------------------------------------------------  SETTINGS  -------------------------------------------------------------------------------------------------

set relativenumber
set nu

set mouse=a

" Set tabs to indent 2 spaces
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

" Allows buffers to stay unsaved in the background
" vim will prompt you if you want to quit to save them.
set hidden

" Allows me to "gf" a node import without ".js" on the end.
" TODO prob don't need this because of GotoFileSpecial below.
set suffixesadd=.js,.ts,.tsx

" stop showing the swap file error
set shortmess+=A
set noswapfile
" Put .swp files into here...
set dir=$HOME/.vim/tmp

set nowrap

" Maintain undo
set undofile 
set undodir=~/.vim/undodir

" <c-x><c-o> completions...
set omnifunc=syntaxcomplete#Complete

" -----------------------------------------------------------------------------------------  DIRVISH  --------------------------------------------------------------------------------------------------

" Settings

let g:dirvish_relative_paths = 0
let g:custom_dirvish_split_width = 60

function DirvishPreviewTreeMaps()
  augroup dirvish_config
    autocmd!
    autocmd FileType dirvish silent! nmap <buffer> l :call dirvish#open("edit", 0)<CR> \| :call PreviewOrClosePreview('feedkeys("p")')<cr>
    autocmd FileType dirvish silent! nmap <buffer> k k:call feedkeys("p")<CR>
    autocmd FileType dirvish silent! nmap <buffer> j j:call feedkeys("p")<CR>
    autocmd FileType dirvish silent! nmap <buffer> h <Plug>(dirvish_up):call feedkeys("p")<CR>
    autocmd FileType dirvish silent! nmap <buffer> gq <Plug>(dirvish_quit):pc<cr>
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
map <leader>. :DirvishPreviewTree<cr>

function DirvishPositionLeft(width)
  exe "norm \<c-w>H" a:width "\<c-w><"
endfunction

function PreviewOrClosePreview(prevcmd)
  if &filetype != 'dirvish'
    pc
    " Do I want to add the file to args automatically?
    " argadd %
  else
    exe 'call' a:prevcmd
  endif
endfunction

function DirvishFindMatchAtCursor()
  let l:bits = split(expand('<cWORD>'), ':')
  exe 'pedit +' . l:bits[1] '' l:bits[0]
endfunction

function DirvishHereOrCwd(dir)
  if len(expand(a:dir))
    exe 'Dirvish ' . a:dir
  else
    exe 'Dirvish .'
  endif
endfunction

" -----------------------------------------------------------------------------------------  SEARCHER  ----------------------------------------------------------------------------------------------------

let g:searcher_split_height = 30

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

function ReadCommandToBuf(cmd)
  silent! bw! searcher
  new
  only
  set nopreviewwindow
  file searcher
  sil! unmap <buffer> <cr>
  sil! unmap <buffer> l
  sil! unmap <buffer> k
  sil! unmap <buffer> j
  sil! unmap <buffer> gq
  nmap <silent> <buffer> <cr> :pc!<cr>gF
  nmap <silent> <buffer> l :pc!<cr>gF
  nmap <silent> <buffer> k k:call PeditFileAtLine()<cr>
  nmap <silent> <buffer> j j:call PeditFileAtLine()<cr>
  nmap <silent> <buffer> gq :sil! pc \| e #<cr>
  silent! pedit
  exe '0read!' a:cmd 
endfunction

function FindFile(path)
  try
    exe 'find ' . a:path
  catch
    silent! call ReadCommandToBuf('ag -g ' . a:path . ' ' . getcwd())
    call PositionTop(g:searcher_split_height)
    call PeditFileAtLine()
  endtry
endfunction
command! -nargs=* -complete=file_in_path FindFile call FindFile(expand("<args>"))
nmap <leader>pp :let &path=LsDirsFromCwdExcluding('node_modules')<cr>q:iFindFile 
nmap <leader>fp :let &path=LsDirsFromCwdExcluding('node_modules')<cr>:FindFile <c-r><c-w><c-f><tab><cr>

function Search(term)
  call ReadCommandToBuf('ag ' . a:term . ' .')
  call PositionTop(g:searcher_split_height)
  call PeditFileAtLine()
endfunction
command! -nargs=* Search silent! call Search(expand("<args>"))
map <leader>ff :Search 
map <leader>pf :Search <c-r><c-w><cr>

function PositionTop(height)
  exe "norm \<c-w>K" a:height "\<c-w>-"
endfunction

function LsDirsFromCwdExcluding(exclude)
  return substitute(join(split(system('ls'), '\n'), ','), a:exclude . ',', '', 'g')
endfunction

" -----------------------------------------------------------------------------------------  NETRW  ----------------------------------------------------------------------------------------------------

" " Go back to netrw at some point, I'm just not ready yet
" map <leader>. :set previewwindow\|Lexplore\|2<cr>
" let g:netrw_bufsettings = 'nu'
" let g:netrw_preview = 1
" let g:netrw_errorlvl = 2
" let g:netrw_winsize = 30
" let g:netrw_list_hide = '^\.\.\=/\=$'
" let g:netrw_liststyle = 3
" let g:netrw_banner = 0

" function AddToArgsIfFile()
"   if &filetype != 'netrw'
"     pc
"     argadd %
"   endif
" endfunction
" function NetrwMappings()
" 	" map <buffer> l <Plug>NetrwLocalBrowseCheck :call AddToArgsIfFile()<cr>
"   " nnoremap <buffer> k k:call feedkeys("p")<cr>
"   " nnoremap <buffer> j j:call feedkeys("p")<cr>
"   " map <buffer> h <Plug>NetrwBrowseUpDir
"   nnoremap <buffer> gq :pc! \| bd!<cr>
"   set nu
"   set relativenumber
" endfunction

" augroup netrw_mappings
"   autocmd!
"     autocmd FileType netrw silent! call NetrwMappings()
" augroup END

" -----------------------------------------------------------------------------------------  SEARCHING  ------------------------------------------------------------------------------------------------

" Causes search to highlight while entering it...
set hlsearch
set ignorecase
" Custom colour for search highlighting...
" hi Search term=standout ctermfg=0 ctermbg=11 guifg=Blue guibg=Yellow
" Clears the hlsearch on most movements...
nmap <silent> h h:noh<cr>
nmap <silent> j j:noh<cr>
nmap <silent> k k:noh<cr>
nmap <silent> l l:noh<cr>
nmap <silent> l l:noh<cr>
nmap <silent> b b:noh<cr>
nmap <silent> w w:noh<cr>
nmap <silent> W W:noh<cr>
nmap <silent> B B:noh<cr>
nmap <silent> E E:noh<cr>
nmap <silent> e e:noh<cr>

" vim-sneak Mappings
" Remaps f and t to work over multi lines
nmap <Nop> <Plug>Sneak_s
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" map n nzt
" map N Nzt

" -----------------------------------------------------------------------------------------  COMMANDS  -------------------------------------------------------------------------------------------------

" Goes to my vimrc
command! Vimrc e ~/.vim/vimrc
" Writes and reloads the vimrc...
command! W :w | so ~/.vimrc
" Goes to my tags file...
command! Tags e ~/.vim/tags
" Goes to the jtags script...
command! Jtags e ~/.vim/scripts/jtags
" Finds all merge conflicts inside the app/ dir...
command! Fix :F '<<<' app
" Creates an actions creator, with types...
command! AC call ActionCreator()
" Runs anything and prints it in a preview window...
command! -nargs=* Log silent! pedit! +setfiletype\ javascript\|0read<args> log

" Runs projects tests and prints results to a buffer...
function Test()
  new
  set filetype=sh
  file tests
  silent let @t = system("yarn test")
  norm "tPggdj
endfunction
command! Test call Test()

" -----------------------------------------------------------------------------------------  QUICKFIX  -------------------------------------------------------------------------------------------------

" Set the make program to eslint in the project's node modules...
set makeprg=./node_modules/.bin/eslint
" Set the error format to understand eslint's unix output...
set errorformat=%A%f:%l:%c:%m,%-G%.%#

command! -nargs=* MakeLint silent make --ext .js,.vue,.ts,.tsx,.jsx --ignore-path .gitignore -f unix <args>
command! -nargs=* LMakeLint silent lmake --ext .js,.vue,.ts,.tsx,.jsx --ignore-path .gitignore -f unix <args>
command! -nargs=* LMakeLintFix lmake --fix --ext .js,.vue,.ts,.tsx,.jsx --ignore-path .gitignore -f unix <args>

" Run linting on the current file...
map <leader>l% :LMakeLint % \| lopen<cr>
" Run linting on the cwd...
map <leader>l. :MakeLint . \| copen<cr>
" Fix problems in current file...
map <leader>lf :LMakeLintFix %<cr>

map <leader>lo :lopen<cr>
map <leader>ln :lne<cr>
map <leader>lp :lp<cr>

map <leader>co :copen<cr>
map <leader>cn :cn<cr>
map <leader>cp :cp<cr>

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

" -----------------------------------------------------------------------------------------  MAPPINGS  -------------------------------------------------------------------------------------------------

" Fugitive mappings
"
" Add a commit or branch name to the "d" register then you can use
" it to diff any file from the current branch...
map <leader>pd :Gdiff <c-r>d<cr>
nnoremap <silent> <leader>gg :G<cr>
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <silent> <leader>gr :Gread<cr>
nnoremap <silent> <leader>gb :Gblame<cr>
nnoremap <leader>gpu :G push<cr>
" Note, this always refers to the cwd git repo...
nnoremap <leader>fch :!git checkout $(git branch \| fzf)<cr>

" fzf Mappings
"
" nnoremap <silent> <leader>pp :Files<cr>
" nnoremap <silent> <leader>h :Ag<CR>
" nmap <silent> <leader>] "ayiw:Ag <c-r>a<cr>
" nmap <silent> <leader>gc :execute "Ag " ToConst()<cr>

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
map <silent> <c-]> :<c-u>call TryTagOrSaveJtag()<cr>

" type any word then press ctrl-z in insert mode to console log it
" with an id string...
inoremap <C-a> <esc>v'.cconsole.log('@FILTER <c-r>": ', <c-r>")
inoremap <c-f> <esc>v'.cconsole.log('@FILTER <c-r>"')

inoremap {<Space> {  }<Left><Left>
inoremap {{<Space> {{  }}<Left><Left><Left>
inoremap (<Space> ()<Left>
inoremap [<Space> []<Left>
inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O

" re-maps capital Yank to yank till the end of the line
map Y y$

" Attempts to put a single line of properties (eg: {1,2,3}) onto multiple lines
map <silent> <leader>= :silent! s/\([{\[(]\)\(.\{-}\)\([}\])]\)/\1\r\2\r\3/ \| silent! -1s/ //g \| silent! s/,/,\r/g \| silent! s/$/,/<cr>j=%
map <silent> <leader>- /[}\])]<cr>v%J<esc>:s/,\([ ]\?}\)/\1/g<cr>gv:s/:/: /g<cr>

" select last pasted text
nnoremap gp `[v`]

" Moving lines up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" New tab
map <c-w>gn :tabnew<CR>

" Lundo!
map <leader>ld :call LundoDiff()<cr>

map <leader>> :diffput<cr>
map <leader>< :diffget<cr>

" This get overwritten by a plugin (emmet, I think) and I
" don't really need them that much...
" map [[ F{
" map ]] f}
" map [] F}
" map ][ f{

" Split a jsx component's props onto multi lines
map <leader>t= 0f<f v/\/>\\|><cr>hc<cr><c-r>"<cr><esc>kA<bs><esc>0dwv$:s/ /\r/g<cr>='[:noh<cr>
map <leader>t- ?<<cr>v/\/>\\|><cr>J<esc>:noh<cr>
" Go to the styles from a style.<name> for RN
map gs <c-w>v"syiwbbgdf'gf/<c-r>s<cr>

" A smarter goto file command...
function GotoFileSpecial()
  let l:filepath = expand("<cfile>")

  let l:homepath     = l:filepath[0] == '~'
  let l:rootpath     = l:filepath[0] == '/'
  let l:relativepath = l:filepath[0] == '.'
  let l:atpath       = l:filepath[0] == '@'

  try
    if l:homepath
      exe v:count 'find ' . getcwd() . '/' . l:filepath[1:] . '*'

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
map gf :call GotoFile()<cr>

" Preview files without opening them...
function BatPreview()
  exe '!clear; bat ' . expand("<cWORD>")
endfunction
map <leader><leader>p :call BatPreview()<cr>

" Running node scripts
map <leader><leader>r :silent pedit! +setfiletype\ javascript\|0read!node\ . console<cr>
