source $HOME/.vim/custom/functions.vim
source $HOME/.vim/custom/snippets.vim

call plug#begin('~/.local/share/vim/plugged')

  Plug 'junegunn/vim-plug'

  " Syntax
  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'jparise/vim-graphql'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'peitalin/vim-jsx-typescript'

  " Colorschemes
  Plug 'sainnhe/sonokai'
  Plug 'habamax/vim-polar'

  " CSS
  Plug 'KabbAmine/vCoolor.vim'
  Plug 'ap/vim-css-color'

  " Auto-completion and linting (necessary evils)
  Plug 'honza/vim-snippets'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neomake/neomake'

  " Best plugin ever
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
  Plug 'airblade/vim-gitgutter'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'MattesGroeger/vim-bookmarks'

  " Manual page lookup (don't need but really nice to have)
  Plug 'vim-utils/vim-man'

  Plug 'vim-scripts/Txtfmt-The-Vim-Highlighter'
call plug#end()
call neomake#configure#automake('nrwi', 500)

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

set nocompatible

" Remaps the spacebar as leader
nnoremap <space> <Nop>
let mapleader = " "

au! BufEnter * syntax on
filetype plugin indent on
" hi Search cterm=NONE ctermfg=NONE ctermbg=Black
" Stops vim error highlighting the second }} in JSX files.
" hi Error NONE

" Get rid of weird commment colours
if has('termguicolors')
    set termguicolors
endif
if has('gui_running')
    set background=light
else
    set background=dark
endif
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Colours
let g:vim_jsx_pretty_colorful_config = 1
let g:sonokai_enable_italic = 1
let g:sonokai_current_word = 'underline'
let g:sonokai_disable_italic_comment = 1

command! HiContrast :colorscheme polar | set background=light
command! Dark :colorscheme sonokai | set background=dark
" Default colorscheme...
Dark

function InitialiseCustomColours()
  if trim(execute('colo')) == 'polar'
    hi StatusSaveState guifg=#d70000 guibg=#cacbcc
  else
    hi StatusSaveState guifg=#d70000 guibg=#3b3e48
  endif

  return ''
endfunction

function FilePathToBufName(path)
  return len(a:path) > 0 ? fnamemodify(a:path, ":t") : '[No Name]'
endfunction

function ListBuffers()
  return join(map(getbufinfo({'buflisted':1}), { key, val -> val.bufnr == bufnr() ? FilePathToBufName(val.name) . '*' : FilePathToBufName(val.name) }), ' • ')
endfunction

set statusline=%{InitialiseCustomColours()}\ %#InfoFloat#%{fnamemodify(getcwd(),':t')}%*\ •\ %#ClapFuzzyMatches#%{FugitiveHead()}%*\ •\ %f:%p%%\ %#StatusSaveState#%m%*%=%{ListBuffers()}\ 

" Makes escape work instantly (turn off if you ever want to use esc perfixed shortcuts
set noesckeys
set foldcolumn=1
set laststatus=2
set autoindent
set smartindent
set ignorecase
set smartcase
set breakindent
set nowrap
set wildmenu
set incsearch
set hlsearch
set autoread
set relativenumber
set nu
let g:dirvish_relative_paths = 0
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" Clears the hlsearch on most movements
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

" Allows the backspace to work in insert mode
set backspace=indent,eol,start

" Set tabs to indent 2 spaces
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

" Allows buffers to stay unsaved in the background
" vim will prompt you if you want to quit to save them.
set hidden

" Allows me to "gf" a node import without ".js" on the end.
set suffixesadd=.js,.ts,.tsx

set cursorline
" set nocursorcolumn

" stop showing the swap file error
set shortmess+=A
set noswapfile
" Put .swp files into here...
set dir=$HOME/.vim/tmp

" Maintain undo
set undofile 
set undodir=~/.vim/undodir

set mouse=a

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100



" Transparent signcolumn (left hand padding)
" hi SignColumn guibg=NONE ctermbg=NONE
" let g:gitgutter_set_sign_backgrounds = 1
let g:gitgutter_close_preview_on_escape = 1

" Replace grep with ag for searching commands...
" if executable("ag")
"     set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
"     set grepformat=%f:%l:%c:%m,%f:%l:%m
" endif

" Auto commands
"
" My syntax highlighting only works properly for the javascript filetype
" so we have to set various typescript and react filetypes to javascript
" here...
autocmd BufNewFile,BufRead,BufEnter *.jsx set filetype=javascript
autocmd BufNewFile,BufRead,BufEnter *.tsx set filetype=javascript
autocmd BufNewFile,BufRead,BufEnter *.ts set filetype=javascript

" Defaults only for markdown files
autocmd BufNewFile,BufEnter *.md set tw=73
autocmd BufNewFile,BufEnter *.md set spell
autocmd BufLeave *.md set spell&
autocmd BufLeave *.md set tw&

" Makes syntax highlighting in the terminal (no ohmyzsh!)
" autocmd TermOpen,TermEnter zsh set filetype=posix

"  ...then so the linting works I'm setting the coc to recognise javascript
"  as typescriptreact
let g:coc_filetype_map = {
\ 'javascript': 'typescriptreact'
\ }

" Rather than calling CocInstall, add extensions here...
let g:coc_global_extensions = [
      \'coc-snippets',
      \'coc-eslint',
      \'coc-prettier',
      \'coc-vetur',
      \'coc-json'
\]

" My work project uses an older node version so this points coc to a more
" recent one...
" let g:coc_node_path = '~/.nvm/versions/node/v14.10.1/bin/node'

" General Settings

" fzf Settings
let g:fzf_layout = { 'down': '40%' }

" Dirvish
map <silent> <leader>. :Dirvish <c-r>%<cr>

" Ranger Settings
"
" let g:ranger_replace_netrw = 1 " open ranger when vim open a directory
" let g:ranger_map_keys = 0
" nnoremap <silent> <leader>. :RangerCurrentFile<cr>
" Until I figure out hiow to stop it this is a shortcut to put the filetype
" back to js after ranger's opened a file...
" map <leader>ftj :set filetype=javascript<cr>

" Custom Commands...
"


" Buffers
" command! Buffers call AnyList("ls", "sh", "0e")

" Shortcut to clean and install new plugins
command! PluginBaby :PlugClean | PlugInstall 

" Mdn Lookup
command! -nargs=+ MDN call MdnSplit("<args>")

function ToConst()
  return toupper(substitute(expand('<cword>'), '\(\u\)', '_\1', 'g'))
endfunction
function ToCamel()
  return substitute(tolower(expand('<cword>')), '_\(\w\)', '\U\1', 'g')
endfunction
command! ConstFromActionCreator let @+ = toupper(substitute(expand('<cword>'), '\(\u\)', '_\1', 'g'))
" Search for a search term in the given directory ':F term folder'
command! -nargs=+ -complete=dir F :silent grep! -RHn <args> | copen | norm <c-w>L40<c-w><
" To do a fuzzy pattern wrap each seperate word in the following: '\(word1\)\@=\|\(word2\)\@='

" Do the same as above but convert the c-word into a constant (for searching
" for constants from action creators)...
nmap <silent> <leader>g* :silent let @f = ToConst()<cr>:silent grep! -RHn <c-r>f app \| copen \| norm <c-w>L40<c-w><cr>
nmap <silent> <leader>g£ :silent let @f = ToCamel()<cr>:silent grep! -RHn <c-r>f app \| copen \| norm <c-w>L40<c-w><cr>

" Goes to my vimrc
command! Vimrc e ~/.vim/vimrc

" sources my vimrc
command! So so ~/.vimrc
command! W :w | so ~/.vimrc

" Saves a session
" command! Sesh mksession! ../sesh
command! Gsesh :execute "mksession! ~/code/vimsessions/" . substitute(substitute(FugitiveHead(), "/", "-", "g"), " ", "", "g")

" Adds any command output to the quickfix buffer
command! -nargs=+ -complete=function Cex :silent redir => o | silent execute '<args>' | silent redir END | silent cex split(o, '\n') | copen
" Allows any simple of list of files to be selectable
set errorformat+=%f

" Maps some useful lists to the quickfix buffer
command! Cls :silent call setqflist(map(getbufinfo({'buflisted':1}), { key, val -> {"bufnr": val.bufnr, "lnum": val.lnum}})) | copen
command! Cjumps :silent call setqflist(getjumplist()[0]) | copen
command! Cchanges :silent call setqflist(map(getchangelist(bufnr())[0], {key, val -> {"bufnr": bufnr(), "col": val.col, "lnum": val.lnum}})) | copen
command! Ctagstack :silent call setqflist(gettagstack().items) | copen

function Test()
  new
  set filetype=sh
  file tests
  silent let @t = system("yarn test")
  norm "tPggdj
endfunction

command! Test :call Test()

command! Fix :F '<<<' app


" Custom mappings

" fzf Mappings
"
nnoremap <silent> <c-p> :GFiles<CR>
nnoremap <silent> <c-h> :Ag<CR>
nnoremap <silent> <c-l> :Buffers<cr>
" Quick search sexp in project
nmap <silent> <leader>] "ayiw:Ag <c-r>a<cr>
nmap <silent> <leader>gc :execute "Ag " ToConst()<cr>


" coc Mappings
"
" Use `[g` and `]g` to navigate between errors
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Expand a snippet suggestion with enter
let g:coc_snippet_next = '<c-n>'
let g:coc_snippet_prev = '<c-p>'
nmap ga <Plug>(coc-codeaction)
vmap ga <Plug>(coc-codeaction-selected)
nmap <leader>ce :CocEnable<cr>
nmap <leader>cd :CocDisable<cr>
nmap <leader>cg :CocDiagnostics<cr>
nmap <leader>cr :CocRestart<cr>
nmap <leader>cc <Plug>(coc-fix-current)
nmap <leader>ch <Plug>(coc-float-hide)
nmap <leader>cf <Plug>(coc-definition)
nmap <leader>ct <Plug>(coc-type-definition)
" Make <tab> used for trigger completion, completion confirm, snippet expand and jump...
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" ImportJS Mappings

map <leader>iw :ImportJSWord<cr>
map <leader>if :ImportJSFix<cr>
map <leader>ig :ImportJSGoto<cr>

" Fugitive mappings
"
" Add a commit or branch name to the "d" register then you can use
" it to diff any file from the current branch...
map <leader>pd :Gdiff <c-r>d<cr>
nnoremap <silent> <leader>gg :G<cr>
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <silent> <leader>gr :Gread<cr>
nnoremap <silent> <leader>gb :Gblame<cr>
nnoremap <leader>gpu :echo execute("G push -u origin " . FugitiveHead())<cr>
" Note, this always refers to the cwd git repo...
nnoremap <leader>fch :!git checkout $(git branch \| fzf)<cr>
nnoremap <leader>gu :GitGutterUndoHunk<cr>

" Jtags mappings

" This seems to work with normal help tags as well, which is lucky!
map <silent> <c-]> :<C-U>call Jtags()<cr>
" map <leader><c-]> :<C-U>call JtagsSearchless()<cr>

" vim-sneak Mappings
" Remaps f and t to work over multi lines
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" General Mappings

" F key shortcuts
map <F1> :Startify<cr>
map <F2> :Test<cr>
map <F3> :Fix<cr>
map <F4> :reg<cr>
map <F5> :Light<cr>
map <F6> :Dark<cr>

map <leader>rr :reg<cr>
map <leader>jj :jumps<cr>G

" Jump preview
map <leader>* <c-w>s15<c-w>-*zz
map <leader># <c-w>s15<c-w>-#zz
map <leader>£ <c-w>s15<c-w>-£zz
map n nzz
map N Nzz

" Jump to RN style definition
map <leader>sf yiwbbgdf'gf/<c-r>"<cr>

" type any word then press ctrl-z in insert mode to console log it
" with an id string...
inoremap <C-z> <esc>v'.cconsole.log('<c-r>": ', <c-r>")
inoremap <C-a> <esc>v'.cconsole.log('@SEAN <c-r>": ', <c-r>")
" inoremap <C-l> <esc>v'.cconsole.log(<c-r>")
inoremap <c-f> <esc>v'.cconsole.log('@SEAN <c-r>"')



inoremap {<Space> {}<Left>
inoremap (<Space> ()<Left>
inoremap [<Space> []<Left>
inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O

" Toggle numbers...
nnoremap <leader>rn :set relativenumber! \| set nu!<cr>

" Toggle cursor line
nnoremap <leader>cl :set cursorline!<cr>

" Reformat the autom import from coc
map <leader>im gdcs{{f'wcw

" Quick mapping for doing yarn tests
map <leader>yt <c-w>n<c-w>o:term<cr>iyarn test -u --watch<cr>

" re-maps capital Yank to yank till the end of the line
map Y y$

map <leader>S: :%s/
map <leader>s: :s/

" Closes a whole tab including all splits. 
map <silent> <c-w>C :tabclose<cr>

" Attempts to put a single line of properties (eg: {1,2,3}) onto multiple lines
map <silent> <leader>= :silent! s/\([{\[(]\)\(.\{-}\)\([}\])]\)/\1\r\2\r\3/ \| silent! -1s/ //g \| silent! s/,/,\r/g \| silent! s/$/,/<cr>j=%
map <silent> <leader>- /[}\])]<cr>v%J<esc>:s/,\([ ]\?}\)/\1/g<cr>gv:s/:/: /g<cr>

" Adds an import to the file if the current variable or function is missing
" map <leader>if <c-]><c-o>yiw:let @f = taglist(expand('<cword>'))[0].filename<cr>gg}Oimport {  <c-r>" <esc>A from '<c-r>f';<esc>

" grep the word under the cursor
map <leader><leader>* :F <cword> app <CR>

" JSX Element commenting, relies on vim commentary ('S')
vmap K S{%i*/<Esc>l%a/*<Esc>

" select last pasted text
nnoremap gp `[v`]
" paste with auto indent
nnoremap <leader>p p`[v`]=

" Moving lines up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Quick switching registers
nnoremap <silent> <leader>r :echo 'Choose registers by key: 1st <- 2nd' \| let regvar = nr2char(getchar()) \| call setreg(nr2char(getchar()), getreg(regvar))<cr>

" Tabs
map <c-w>gn :tabnew<CR>

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

" Terminal buffer
nnoremap <silent> <leader>ts <c-w><c-n><c-w>J12<c-w>-:terminal<cr>i
nnoremap <silent> <leader>tn :te <cr>i
" nnoremap <silent> <leader>to :b {term:}<cr>


" Put the word under the cursor into the search, like * but without jumping
nnoremap <silent> <leader>/w yiw:let @/ = <c-r><cr>
nnoremap <silent> <leader>/W yiw:let @/ = <c-r><cr>

nnoremap <silent> <leader>"% :let @" = @%<cr>
nnoremap <silent> <leader>+% :let @+ = @%<cr>

" These settings have to go last...
set rtp+=~/.fzf


" " Tmux commands and options from here on.

if len(system("echo $TMUX")) > 1
  command! Tmuxrc e ~/.vim/tmux.conf
  autocm BufWritePost ~/.vim/tmux.conf call system('tmux source-file ~/.vim/tmux.conf')
endif

" TODO: make a command that does importing

command! LundoDiff :call LundoDiff()
map <leader>ld :LundoDiff<cr>


" These both do the same except FuzDo adds the file to copen which makes it a bit slower
command! FuzdCo :silent! exe "!$HOME/.vim/scripts/./fuzd4vim " expand("%:p:h") | cf $HOME/.vim/.vimfile | cdo e | redraw! 
" command! Fuzd :silent! exe "!$HOME/.vim/scripts/./fuzd4vim " expand("%:p:h") | let fuzd_filename = system("cat $HOME/.vim/.vimfile") | if len(fuzd_filename) > 1 | exe "e " fuzd_filename | endif | redraw!

" map <leader>. :Browse<cr>

" augroup ReplaceNetrwByFzfBrowser
"   autocmd VimEnter * silent! autocmd! Browse
"   autocmd BufEnter * if isdirectory(expand("%")) | call fzf#vim#browse(expand("%:p:h")) | endif
" augroup END

noremap <leader>ac <esc>:call ActionCreator()<cr>
command! AC call ActionCreator()

command! Sesh exec 'SSave ' FugitiveHead()

command! -nargs=* PlainAC :call PlainAC(<f-args>)

function AndroidEnterKeyEvent(...)
  for event in a:000
    call system('adb shell input keyevent ' . l:event)
  endfor
endfunction
command! -nargs=* AndroidEnterKeyEvent call AndroidEnterKeyEvent(<args>)
function AndroidEnterText(...)
  for text in a:000
    call system('adb shell input text "' . l:text . '"; adb shell input keyevent 66')
  endfor
endfunction
command! -nargs=* AndroidEnterText call AndroidEnterText(<args>)
command! IgnoreLogs execute("norm :e app/App.tsx<cr>/react-native<cr>F{a LogBox,<esc>G?return<cr>[{OLogBox.ignoreAllLogs();<cr><esc>:w \| bd!")
command! IgnoreLogsNo execute("norm :e app/App.tsx<cr>/LogBox<cr>dWGNdk:w | bd!<cr>")
command! TODO e ~/Documents/Careplanner\ Mob\ App/TODO | set filetype=markdown
map <silent><leader>to :split \| TODO<cr>:map <buffer> gq :Bclose!<lt>cr>:silent! close<lt>cr><cr>:norm Gzz<cr>
map <leader>cpt :AndroidEnterText ""<Left>
map <leader>cpe :AndroidEnterKeyEvent 

command! CarePlannerRefresh call system('adb shell input swipe 360 500 360 1000')
map <leader>cpj :CarePlannerRefresh<cr>
command! CarePlannerEnter call system('adb shell input keyevent 66')
map <leader>cp<cr> :CarePlannerEnter<cr>
command! CarePlannerPasscode call system('adb shell input text "11111111"; adb shell input keyevent 66')
map <leader>cpp :CarePlannerPasscode<cr>
command! AndroidReload call system('adb shell input text "RR"')
map <leader>cpr :AndroidReload<cr>
command! CarePlannerHandoverNote call system('adb shell input text "mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm"')
map <leader>cph :CarePlannerHandoverNote<cr>
command! AndroidDevMenu call system('adb shell input keyevent 82')
map <leader>cpm :AndroidDevMenu<cr>
command! AndroidDebugToggle call system('adb shell input keyevent 82; adb shell input keyevent 61; adb shell input keyevent 61; adb shell input keyevent 66')
map <leader>cpd :AndroidDebugToggle<cr>

map <leader>> :diffput<cr>
map <leader>< :diffget<cr>
map [[ F{
map ]] f}
map [] F}
map ][ f{
map <leader>o O<esc>

" Split a jsx component's props onto multi lines
map <leader>t= 0f<f v/\/>\\|><cr>hc<cr><c-r>"<cr><esc>kA<bs><esc>0dwv$:s/ /\r/g<cr>='[:noh<cr>
map <leader>t- ?<<cr>v/\/>\\|><cr>J<esc>:noh<cr>
map gs <c-w>v"syiwbbgdf'gf/<c-r>s<cr>

imap <c-l> <esc>v'."tdi<<c-r>t<esc>F<w"tyEA></<c-r>t><esc>F<i
imap <c-g><c-l> <esc>v'."tdi<<c-r>t<esc>F<w"tyEA><cr></<c-r>t><esc>O
" imap <c-g><c-l> <esc>v'."tdi<<c-r>t><return></<c-r>t><esc>F<f dt>O


" This sets the completion list for <c-x><c-o> to my registers contents...
set completefunc=Registers
map <leader>fco :F '@SEAN' app<cr>
map <leader>s/ :%s/

" Quick fix while gf is broken
function GotoFile()
  let l:filepath = expand("<cfile>")
  let l:homepath1 = l:filepath[0] == '~'
  let l:homepath2 = l:filepath[0] == '/'
  let l:relativepath = l:filepath[0] == '.'

  if l:homepath1
    exe 'find ' . trim(substitute(l:filepath, '\~', getcwd(), 'g')) . '*'
  elseif l:homepath2
    exe 'find ' . getcwd() . l:filepath . '*'
  elseif l:relativepath
    exe 'find %:h/' . l:filepath . '*'
  else
    exe 'find node_modules' . l:filepath . '*'
  endif
endfunction

map gf :call GotoFile()<cr>

function BatPreview()
  exe '!clear; bat ' . expand("<cWORD>")
endfunction

map <leader><leader>p :call BatPreview()<cr>

map <Space><Space>go   /let<CR>cwfunction<Esc>f:ci'changed!<Esc>
map <Space><Space>r :silent w \| echo 'Running...' \| echo system("npm start")<cr>
