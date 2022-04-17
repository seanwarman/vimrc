
" -----------------------------------------------------------------------------------------  PLUGINS  --------------------------------------------------------------------------------------------------

" Uses the :Man builtin plugin
runtime ftplugin/man.vim

call plug#begin('~/.local/share/vim/plugged')
  " These colorschemes break the term vim's colours
  " so only load them in the gui version...
  if has("gui_macvim")
    Plug 'flazz/vim-colorschemes'
  endif

  " Syntax
  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'mattn/emmet-vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'leafgarland/typescript-vim'
  Plug 'chrisbra/csv.vim'
  Plug 'posva/vim-vue'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug '1995eaton/vim-better-javascript-completion'

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

  " Startup splash screen and workspaces
  Plug 'mhinz/vim-startify'

  " Every editor needs multi cursors
  Plug 'mg979/vim-visual-multi'

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

" -----------------------------------------------------------------------------------------  SETTINGS  -------------------------------------------------------------------------------------------------

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

set nowrap

" Maintain undo
set undofile 
set undodir=~/.vim/undodir

" Set's yank to use the normal clipboard
set clipboard=unnamed

" Don't ask to [L]oad the file just load it...
set autoread

set previewheight=30

set diffopt+=vertical

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

map <leader>G :Startify<cr>

" --------------------------------------------------------------------------------------  EASYMOTION  ----------------------------------------------------------------------------------------------------

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

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

map <leader><leader>s :SaveSesh<cr>

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

if has("gui_macvim")
  colo Monokai
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

" Make the fold colour more subtle
hi Folded term=standout ctermfg=248 ctermbg=236 guifg=grey49 guibg=black

" autocmd TerminalOpen,TermChanged,TerminalWinOpen,Syntax * silent! call SetAnsiTermColours()

" -----------------------------------------------------------------------------------------  COC  -------------------------------------------------------------------------------------------------

map ]e <plug>(coc-diagnostic-next)
map [e <plug>(coc-diagnostic-prev)
map <leader>ef <plug>(coc-fix-current)
map <leader>ed :CocDisable<cr>
map <leader>ee :CocEnable<cr>

" Hide the gutter background colour
hi SignColumn ctermbg=NONE

" -----------------------------------------------------------------------------------------  ALE  -------------------------------------------------------------------------------------------------

" " This is best set after the colourscheme because of the highlight settings
" " for the sign column.

" map ]e :ALENext<cr>
" map [e :ALEPrevious<cr>
" map <leader>ef :ALEFix<cr>
" map <leader>ee :ALEToggle<cr>

" " let g:ale_change_sign_column_color = 1
" set signcolumn=number
" hi SignColumn ctermbg=NONE

" let g:ale_sign_error = '✗'
" let g:ale_sign_warning = '❱'
" let g:ale_completion_enabled = 1

" " Make the gutter colour background more subtle
" " hi SignColumn ctermbg=NONE
" let g:ale_fixers = {'vue': ['eslint'], 'typescript': ['prettier', 'eslint'] }

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
map <leader><leader>t :call ToggleStatusLine()<cr>

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
set statusline=%#MatchParen#\ %{fnamemodify(getcwd(),':t')}\ %*%#StatusLineTerm#\ %{StatusLineGitBranch()}\ %*\ %t:%p%%:%c\ %#ErrorMsg#%m%*%=%{ListArgsOrBuffers()}\ 

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
    exe 'bd! ' ListEmptyBufNums()
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
    exe 'argdelete' a:path
  else
    exe 'argadd' a:path
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
    exe 'bd!' join(ListAllBufsNotInArgv())
  endif
  call DeleteEmptyBuffers()
endfunction

function DeleteAllButThisBuf()
  exe 'sil! bd! ' ListAllBufNums(bufnr())
  call DeleteEmptyBuffers()
endfunction

" Buffer mappings
map <leader>bp :bp<cr>
map <leader>bn :bn<cr>
map <leader>bdd :Bclose!<cr>
map <leader>bd<tab> q:bd! <tab>
" Select buffer from completion menu...
map <leader>b<tab> q:ib <tab>
map <leader>bd* :sil! call DeleteAllBufsNotInArgv()<cr>
map <leader>bdD :sil! call DeleteAllButThisBuf()<cr>
map <leader>bde :call DeleteEmptyBuffers()<cr>
map <leader><leader>n :new \| wincmd p \| close!<cr>

" Args list mappings
map <leader>an :n<cr>
map <leader>ap :N<cr>
map <leader>aa :call ArgAddOrRemoveFile(expand('%'))<cr>
" Add all open buffers to the args list...
map <leader>aA :exe 'argadd' join(ListAllBufNames())<cr>
map <leader>al :sall<cr>
map <leader>adD :argdelete *<cr>
command! -nargs=* -complete=arglist Args argedit <args>
" Select buffer from completion menu...
map <leader>a<tab> q:iArgs <tab>

" -----------------------------------------------------------------------------------------  AUTOCOMPLETION  -------------------------------------------------------------------------------------------------

set completeopt=menuone
set complete=.,w,b,u,t,i

set omnifunc=syntaxcomplete#Complete
function CompleteOmni()
  if !pumvisible()
    call feedkeys("\<c-x>\<c-o>")
  else
    call feedkeys("\<c-n>")
  endif
  return ''
endfunction

" This works but it's actually not as useful as c-n
" imap <tab> <c-r>=CompleteOmni()<cr>
imap <tab> <c-n>
imap <s-tab> <c-p>


function CountCols()
  let l:n = 1
  let l:total = 0
  let l:curline = getcharpos('.')[1]
  while l:n < l:curline
    let l:total += col([l:n, '$'])
    let l:n += 1
  endwhile
  " col() adds a 1 for every line so minus off the number of lines...
  let l:total += (col('.') - l:curline)
  return 'total is: ' . l:total
endfunction





function CompleteNode()
  call setcursorcharpos('.', col('.') -1)
  let l:word = expand('<cWORD>')
  call setcursorcharpos('.', col('.') +1)


  " call complete(col('.'), [ 'constructor', '__defineGetter__', '__defineSetter__', 'hasOwnProperty', '__lookupGetter__', '__lookupSetter__', 'isPrototypeOf', 'propertyIsEnumerable', 'toString', 'valueOf', '__proto__', 'toLocaleString' ])
  return l:word
endfunction

" -------------------------------------------------------------------------------------------  FZF  ---------------------------------------------------------------------------------------------------

let g:fzf_layout = { 'down': '35%' }

map <leader>pp :Files<cr>
map <leader>ff :Ag<cr>
map <leader>fw :Ag <c-r><c-w><cr>

" -----------------------------------------------------------------------------------------  NETRW  ----------------------------------------------------------------------------------------------------

" " " Go back to netrw at some point, I'm just not ready yet
map <leader>. :set previewwindow\|Vexplore\|2<cr>
let g:netrw_bufsettings = 'nu'
let g:netrw_preview = 1
let g:netrw_errorlvl = 2
let g:netrw_winsize = 30
let g:netrw_list_hide = ''
let g:netrw_liststyle = 3
let g:netrw_banner = 0

" function NetrwMappings()
" 	" map <buffer> l <Plug>NetrwLocalBrowseCheck<cr>
"   " nnoremap <buffer> k k:call PeditFileAtLine()<cr>
"   " nnoremap <buffer> j j:call PeditFileAtLine()<cr>
"   " map <buffer> h <Plug>NetrwBrowseUpDir
"   map <buffer> j jp
"   map <buffer> k kp
"   map <buffer> h -
"   map <buffer> l <cr>
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
" Allows case sensitivity only when capitals are used
" set ignorecase
" set smartcase
" I've switched these off becuase they effect autocomplete

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

" -----------------------------------------------------------------------------------------  COMMANDS  -------------------------------------------------------------------------------------------------

" Kind of works...
function TerminalBufCmd()
  let l:line = line('.')
  call term_sendkeys(4, getline(l:line) . "\r")
  1,$ d _
  return "\r" . join(getbufline(4, 1, 1000), "\r") . "\r"
endfunction

au FileType bufterm.sh sil! imap <buffer> <cr> <c-r>=TerminalBufCmd()<cr>

command BufTerm new | set filetype=bufterm.sh | norm i

command DelEmptyLines exe 'g/^\([\s\t]\)*$/d'

" -----------------------------------------------------------------------------------------  COMMANDS  -------------------------------------------------------------------------------------------------

" Goes to my vimrc
command! Vimrc e ~/.vim/vimrc
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
au OptionSet,BufEnter *.ejs set filetype=html

" -----------------------------------------------------------------------------------------  QUICKFIX  -------------------------------------------------------------------------------------------------

" Search for a search term in the given directory ':F searchterm folder'
command! -nargs=+ -complete=dir F :silent grep! -RHn --exclude-dir node_modules <args> | copen | norm <c-w>L40<c-w><

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

command! -nargs=* MDN call MdnSplit('<args>')
map <leader>mdn :MDN 

" ------------------------------------------------------------------------------------------  LUNDO  ---------------------------------------------------------------------------------------------------

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

" Lundo!
map <leader>ld :call LundoDiff()<cr>

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
map <silent> <c-]> :<c-u>call TryTagOrSaveJtag()<cr>

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

" type any word then press ctrl-z in insert mode to console log it
" with an id string...
inoremap <C-a> <esc>v'.cconsole.log('@FILTER <c-r>": ', <c-r>")
inoremap <c-f> <esc>v'.cconsole.log('@FILTER <c-r>"')

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
inoremap {`<cr> {`<cr>`}<c-d><esc>O<c-t>
inoremap [`<cr> [`<cr>`]<c-d><esc>O<c-t>
inoremap (`<cr> (`<cr>`)<c-d><esc>O<c-t>
inoremap ({`<cr> ({`<cr>`})<c-d><esc>O<c-t>
inoremap ([`<cr> ([`<cr>`])<c-d><esc>O<c-t>
" TODO make a function that detects if this is the second quote or not
" inoremap ' ''<Left>
" inoremap " ""<Left>

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

map <leader>> :diffput<cr>
map <leader>< :diffget<cr>

" Split a jsx component's props onto multi lines
map <leader>t= 0f<f v/\/>\\|><cr>hc<cr><c-r>"<cr><esc>kA<bs><esc>0dwv$:s/ /\r/g<cr>='[:noh<cr>
map <leader>t- ?<<cr>v/\/>\\|><cr>J<esc>:noh<cr>
" Go to the styles from a style.<name> for RN
map gs <c-w>v"syiwbbgdf'gf/<c-r>s<cr>

" Running node scripts
map <leader><leader>r :w! \| silent pedit! +setfiletype\ javascript\|0read!node\ . console<cr>

" Show marks before jumping to mark position...
map <leader>' :marks<cr>:'

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
map gf :call GotoFile()<cr>

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
