source $HOME/.vim/functions/functions.vim

call plug#begin('~/.local/share/vim/plugged')
  Plug 'junegunn/vim-plug'

  " Auto-completion and linting (necessary evils)
  Plug 'honza/vim-snippets'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neomake/neomake'

  " Best plugin ever
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Best git plugin ever
  Plug 'tpope/vim-fugitive'

  " Second best plugin ever
  Plug 'francoiscabrol/ranger.vim'

  " General utils
  Plug 'kshenoy/vim-signature'
  Plug 'itchyny/vim-cursorword'
  Plug 'adelarsq/vim-matchit'

  " Lord Tim pope's plugs
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'

  Plug 'justinmk/vim-sneak'
  Plug 'seanwarman/vim-startify'
  Plug 'easymotion/vim-easymotion'
  Plug 'airblade/vim-gitgutter'

  " Really useful, super simple (how :bd should work)
  Plug 'rbgrouleff/bclose.vim'

  " Manual page lookup (don't need but really nice to have)
  Plug 'vim-utils/vim-man'

  " Syntax and colours
  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'jparise/vim-graphql'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'KabbAmine/vCoolor.vim'
  Plug 'lilydjwg/colorizer'

  Plug 'sainnhe/sonokai'
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }

call plug#end()
call neomake#configure#automake('nrwi', 500)

let g:startify_custom_art = [
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

command! PluginBaby :PlugClean | PlugInstall 

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
command! Light :colorscheme material | let g:material_theme_style = 'lighter' | set background=light
command! Dark :colorscheme sonokai | set background=dark
" Set default to Dark...
Dark


" Nicer diff colours
" hi DiffAdd cterm=reverse ctermfg=35 ctermbg=235 guibg=DarkBlue
" hi DiffChange cterm=reverse ctermfg=76 ctermbg=235 guibg=DarkMagenta
" hi DiffDelete cterm=reverse ctermfg=166 ctermbg=235 gui=bold guifg=Blue guibg=DarkCyan
" hi DiffText cterm=reverse ctermfg=37 ctermbg=235 gui=bold guibg=Red


set smartcase

" Sets statusline to [buffer-number -- filename [-/+] -- filetype]
set statusline=\ %n\ %t\ %m%=%y\ 
set laststatus=2
set autoindent
set smartindent
set breakindent
set nowrap
set wildmenu
set incsearch
set hlsearch
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
set nocursorcolumn

" stop showing the swap file error
set shortmess+=A
set noswapfile
" Put .swp files into here...
set dir=$HOME/.vim/tmp

" Maintain undo
set undofile 
set undodir=~/.vim/undodir

set mouse=a

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100


" Persist folds
" TODO: add `if expand("%")` to this...
" augroup AutoSaveFolds
"   if expand("%")
"     autocmd!
"     autocmd BufWinLeave * mkview
"     autocmd BufWinEnter * silent loadview
"   endif
" augroup END

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


" General Settings

" Easymotion
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
map <Leader> <Plug>(easymotion-prefix)

" Colorizer is really slow on large files (for anything in :help for example)
" Set it to off by default, you can toggle it with <leader>tc
let g:colorizer_startup = 0

" fzf Settings
let g:fzf_layout = { 'down': '40%' }

" Ranger Settings
"
let g:ranger_replace_netrw = 1 " open ranger when vim open a directory
let g:ranger_map_keys = 0
nnoremap <silent> <leader>. :RangerCurrentFile<cr>

" Custom Commands...
"


" Buffers
" command! Buffers call AnyList("ls", "sh", "0e")


" Mdn Lookup
command! -nargs=+ MDN call MdnSplit("<args>")



" Search for a search term in the given directory ':F term folder'
command! -nargs=+ -complete=dir F :silent grep! -RHn <args> | copen | norm <c-w>L40<c-w><

" Goes to my vimrc
command! Vimrc e ~/.vim/vimrc

" sources my vimrc
command! So so ~/.vimrc
command! W :w | so ~/.vimrc

" Saves a session
command! Sesh mksession! ../sesh
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


" Custom mappings

" fzf Mappings
"
nnoremap <silent> <c-p> :GFiles<CR>
nnoremap <silent> <c-h> :Ag<CR>
nnoremap <silent> <c-l> :Buffers<cr>
" Quick search sexp in project
nmap <silent> <leader>] "ayiw:Ag <c-r>a<cr>


" coc Mappings
"
" Use `[g` and `]g` to navigate between errors
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Expand a snippet suggestion with CTRL-e
imap <expr> <c-e> pumvisible() ? "<Plug>(coc-snippets-expand)" : "<CR>"
nmap ga <Plug>(coc-codeaction)
vmap ga <Plug>(coc-codeaction-selected)
nmap <leader>ce :CocEnable<cr>
nmap <leader>cd :CocDisable<cr>
nmap <leader>cg :CocDiagnostics<cr>
nmap <leader>cc <Plug>(coc-fix-current)
nmap <leader>ch <Plug>(coc-float-hide)
nmap <leader>cf <Plug>(coc-definition)
nmap <leader>ct <Plug>(coc-type-definition)


" Fugitive mappings
"
" Add a commit or branch name to the "d" register then you can use
" it to diff any file from the current branch...
map <leader>pd :Gdiff <c-r>d<cr>
nnoremap <silent> <leader>gg :G<cr>
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <silent> <leader>gr :Gread<cr>

" Jtags mappings

" This seems to work with normal help tags as well, which is lucky!
map <silent> <c-]> :<C-U>call Jtags()<cr>
map <leader><c-]> :<C-U>call JtagsSearchless()<cr>

" vim-sneak Mappings
" Remaps f and t to work over multi lines
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T


" General Mappings

" type any word then press ctrl-z in insert mode to console log it
" with an id string...
inoremap <C-z> <esc>v'.cconsole.log('<c-r>": ', <c-r>")
inoremap <C-a> <esc>v'.cconsole.log('@SEAN <c-r>": ', <c-r>")
inoremap <C-l> <esc>v'.cconsole.log(<c-r>")

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
map <silent> <leader>- /[}\])]<cr>v%J<esc>:s/,\([ ]\?}\)/\1/g<cr>

" Adds an import to the file if the current variable or function is missing
" map <silent> <leader>if yiw:let @f = taglist('<c-r><c-w>')[0].filename \| echo @f<cr>

" grep the word under the cursor
map <leader>* :F <cword> * <CR>

" JSX Element commenting, relies on vim commentary ('S')
vmap K S{%i*/<Esc>l%a/*<Esc>

nnoremap ]] ]M
nnoremap [[ [m
nnoremap ][ ]m
nnoremap [] [M

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

map <leader>b<tab> q:ib <tab>
map <leader>bp :bp<cr>
map <leader>bn :bn<cr>
map <leader>bd :Bclose!<cr>
" delete all buffers but this one.
nnoremap <silent> <leader>bD :bd! <c-a><cr><c-o>:bn<cr>:bd<cr>

" Terminal buffer
nnoremap <silent> <leader>ts <c-w><c-n><c-w>J12<c-w>-:terminal<cr>i
nnoremap <silent> <leader>tn :te <cr>i
nnoremap <silent> <leader>to :b {term:}<cr>


" Put the word under the cursor into the search, like * but without jumping
nnoremap <silent> <leader>/w yiw:let @/ = <c-r><cr>
nnoremap <silent> <leader>/W yiw:let @/ = <c-r><cr>

nnoremap <silent> <leader>"% :let @" = @%<cr>
nnoremap <silent> <leader>+% :let @+ = @%<cr>



" These settings have to go last...

set rtp+=~/.fzf

" transparent background (this doesn't have to go last but it's keeping
" SignColumn company)
" hi Normal guibg=NONE ctermbg=NONE
" Transparent signcolumn (left hand padding)
" hi SignColumn guibg=NONE ctermbg=NONE


" " Tmux commands and options from here on.

if len(system("echo $TMUX")) > 1
  command! Tmuxrc e ~/.vim/tmux.conf
  autocm BufWritePost ~/.vim/tmux.conf call system('tmux source-file ~/.vim/tmux.conf')
endif


" " Mobo Settings

command! Rn silent! silent! call system(join([TmuxSplit("50%", GomoCd("rn"))]))
command! Wdio silent! silent! call system(join([TmuxSplit("50%", GomoCd("wdio"))]))
command! Appium silent! silent! call system(join([TmuxSplit("50%", GomoCd("appium"))]))
command! -nargs=+ GomoCd silent! silent! call system(join([TmuxSplit("50%", GomoCd(<args>))]))
command! -nargs=* GomoRun silent! silent! call system(join([TmuxSplit("50%", GomoRun(<args>))]))


function! GomoLoginRaw()
  silent execute "!gomo cd wdio; thing"
  redraw!
endfunc

command! MobLogin silent! call system(join([TmuxSplit("50%", GomoCd("wdio")), TmuxKeyPress("Enter"), TmuxSend(WdioMobileLogin()), TmuxKeyPress("Enter", "Escape")], ';'))
map <leader>ml :MobLogin<cr>

command! LaunchApp silent! call system(join([TmuxSplit("50%", GomoCd("wdio")), TmuxKeyPress("Enter"), TmuxSend(WdioMobileLaunchApp()), TmuxKeyPress("Enter", "Escape")], ';'))
map <leader>la :LaunchApp<cr>

" TODO: make a command that does importing

command! LundoDiff :call LundoDiff()
map <leader>ld :LundoDiff<cr>
