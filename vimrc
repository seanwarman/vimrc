source $HOME/.vim/custom/functions.vim
source $HOME/.vim/custom/snippets.vim

call plug#begin('~/.local/share/vim/plugged')

  " Syntax
  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'peitalin/vim-jsx-typescript'

  " CSS
  Plug 'KabbAmine/vCoolor.vim'
  Plug 'ap/vim-css-color'

  " Fuzzy Finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

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
  Plug 'rbgrouleff/bclose.vim'
  Plug 'MattesGroeger/vim-bookmarks'
  Plug 'mattn/emmet-vim'

  " Manual page lookup (don't need but really nice to have)
  Plug 'vim-utils/vim-man'
call plug#end()
command! PluginBaby PlugClean | PlugInstall

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

" Custom Config -------------------------------------------

" Remaps the spacebar as leader
nnoremap <space> <Nop>
let mapleader = " "

colo slate

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

function FilePathToBufName(path)
  return len(a:path) > 0 ? fnamemodify(a:path, ":t") : '[No Name]'
endfunction

function ListBuffers()
  return join(map(getbufinfo({'buflisted':1}), { key, val -> val.bufnr == bufnr() ? FilePathToBufName(val.name) . '*' : FilePathToBufName(val.name) }), ' • ')
endfunction

" A custom highlight group for the first item in the statusline...
" hi ProjectStatus ctermfg=0 ctermbg=6 guifg=#000000 guibg=#00CED1
set statusline=%#MatchParen#\ %{fnamemodify(getcwd(),':t')}\ %*%#StatusLineTerm#\ %{FugitiveHead()}\ %*\ %t:%p%%\ %#ErrorMsg#%m%*%=%{ListBuffers()}\ 
" Always show the statusline
set laststatus=2

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

" Dirvish config...
let g:dirvish_relative_paths = 0
let g:custom_dirvish_split_width = 30
function PreviewOrClosePreview()
  if &filetype != 'dirvish'
    pc
  else
    norm p
  endif
endfunction
function DirvishPreviewMode(onOff)
  augroup dirvish_config
    if a:onOff == 1
      augroup dirvish_config
        autocmd!
        autocmd FileType dirvish silent! map <buffer> j jp
        autocmd FileType dirvish silent! map <buffer> k kp
        autocmd FileType dirvish silent! map <buffer> <cr> :call dirvish#open("edit", 0)<CR> \| :call PreviewOrClosePreview()<cr>
        autocmd FileType dirvish silent! map <buffer> - <Plug>(dirvish_up) p
      augroup END
    elseif a:onOff == 0
      augroup dirvish_config
        autocmd!
        autocmd FileType dirvish silent! unmap <buffer> j
        autocmd FileType dirvish silent! unmap <buffer> k
        autocmd FileType dirvish silent! map <buffer> <cr> :call dirvish#open("edit", 0)<CR>
        autocmd FileType dirvish silent! map <buffer> - <Plug>(dirvish_up)
      augroup END
    endif
  augroup END
endfunction
command! -nargs=* DirvishPreviewModeOn call DirvishPreviewMode(1) | pclose | pedit | Dirvish <args> | exe 'norm <c-w>H' g:custom_dirvish_split_width '<c-w><'
command! -nargs=* DirvishPreviewModeOff call DirvishPreviewMode(0) | Dirvish <args>
map <leader><leader>. :DirvishPreviewModeOn %:h<tab><cr>
map <leader>. :DirvishPreviewModeOff %:h<tab><cr>

" Causes search to highlight while entering it...
set hlsearch
" Custom colour for search highlighting...
hi Search term=standout ctermfg=0 ctermbg=11 guifg=Blue guibg=Yellow
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

" Runs projects tests and prints results to a buffer...
function Test()
  new
  set filetype=sh
  file tests
  silent let @t = system("yarn test")
  norm "tPggdj
endfunction
command! Test call Test()

" Runs eslint and prints results to a buffer...
function Lint(dir)
  silent! bd! {linter}
  echo 'Linting...'
  exe 'silent! pedit +setfiletype\ sh\|0read!npx\ npx\ eslint\ --ext\ .js,.vue,.ts,.tsx,.jsx\ --ignore-path\ .gitignore\ ' . a:dir . ' linter'
endfunction
command! -nargs=* -complete=dir Lint call Lint(expand("<args>"))
" Run linting on the current file...
map <leader>l% :Lint %<cr>
" Run linting on the cwd...
map <leader>l. :Lint .<cr>
" Open the linter buffer in a preview window...
map <leader>ll :pedit +b{linter}<cr>

function FixLint(dir)
  echo 'Fixing...'
  call system('npx eslint --fix --ext .js,.vue,.ts,.tsx,.jsx --ignore-path .gitignore ' . a:dir)
  e!
  echo 'Done!'
endfunction
command! -nargs=* -complete=dir FixLint call FixLint(expand("<args>"))
" Autofix all found problems...
map <leader>lf. :FixLint .<cr>
" Auto fix the problems in the current file...
map <leader>lf% :FixLint %<cr>

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
nnoremap <silent> <leader>pp :Files<cr>
nnoremap <silent> <leader>h :Ag<CR>
nmap <silent> <leader>] "ayiw:Ag <c-r>a<cr>
nmap <silent> <leader>gc :execute "Ag " ToConst()<cr>
nmap <Nop> <Plug>Sneak_s

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
map <silent> <c-]> :call TryTagOrSaveJtag()<cr>

" vim-sneak Mappings
" Remaps f and t to work over multi lines
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

map n nzz
map N Nzz

" type any word then press ctrl-z in insert mode to console log it
" with an id string...
inoremap <C-a> <esc>v'.cconsole.log('<c-r>": ', <c-r>")
inoremap <c-f> <esc>v'.cconsole.log('<c-r>"')

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

" Buffer maps
function ListEmptyBufNums()
  return join(map(getbufinfo({'buflisted':1}), { key, val -> len(val.name) == 0 ? val.bufnr : ''}))
endfunction
function ListAllBufNums(missbuf)
  return join(map(getbufinfo({'buflisted':1}), { key, val -> val.bufnr == a:missbuf ? '' : val.bufnr }))
endfunction
map <leader>bp :bp<cr>
map <leader>bn :bn<cr>
map <leader>b<tab> q:ib <tab>
map <leader>bdd :exe 'Bclose! ' bufnr()<cr>
" Delete all empty buffers
function DeleteEmptyBuffers()
  let l:bufnums = ListEmptyBufNums()
  if len(l:bufnums) > 1
    exe 'bd! ' ListEmptyBufNums()
  else 
    echo 'No empty buffers'
  endif
endfunction
map <leader>bde :call DeleteEmptyBuffers()<cr>
" Delete all buffers but this one
map <leader>bdD :exe 'bd! ' ListAllBufNums(bufnr())<cr>

" Lundo!
map <leader>ld :call LundoDiff()<cr>

map <leader>> :diffput<cr>
map <leader>< :diffget<cr>

map [[ F{
map ]] f}
map [] F}
map ][ f{

" Split a jsx component's props onto multi lines
map <leader>t= 0f<f v/\/>\\|><cr>hc<cr><c-r>"<cr><esc>kA<bs><esc>0dwv$:s/ /\r/g<cr>='[:noh<cr>
map <leader>t- ?<<cr>v/\/>\\|><cr>J<esc>:noh<cr>
" Go to the styles from a style.<name> for RN
map gs <c-w>v"syiwbbgdf'gf/<c-r>s<cr>

" A smarter goto file command...
function GotoFileSpecial()
  let l:filepath = expand("<cfile>")
  let l:homepath1 = l:filepath[0] == '~' || l:filepath[0] == '@'
  let l:homepath2 = l:filepath[0] == '/'
  let l:relativepath = l:filepath[0] == '.'

  if l:homepath1
    exe v:count 'find ' . trim(substitute(l:filepath, '\~|\@', getcwd(), 'g')) . '*'
  elseif l:homepath2
    exe v:count 'find ' . getcwd() . l:filepath . '*'
  elseif l:relativepath
    exe v:count 'find %:h/' . l:filepath . '*'
  else
    exe v:count 'find node_modules/' . l:filepath
  endif
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

" List all dirs excluding the given arg (usually node_modules)...
function LsDirsFromCwdExcluding(exclude)
  return substitute(join(split(system('ls -d */'), '\n'), ','), a:exclude . '/,', '', 'g')
endfunction
" " This is no good because "path" only accepts directories, even if I add the
" " files to it, it'll ignore them when expanding the glob...
" map <c-p> :let &path=LsDirsFromCwdExcluding('node_modules')<cr>q:ifind **/

" Quick way to cd into current dir for <c-x><c-f> file completions
map <leader>cd :cd %:h<cr>
map <leader>c- :cd -<cr>
" Jumps to the file for the vue component under the cursor...
map <leader>f :let &path=LsDirsFromCwdExcluding('node_modules') \| find ./**/<cword>*<cr>

" Vim's file type group...
augroup filetypedetect
  " Set .vue files to html...
  autocmd! BufNewFile,BufRead *.vue setfiletype html
augroup END
