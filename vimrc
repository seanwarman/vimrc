if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
    Plug 'junegunn/vim-plug'

    " Auto-completion and linting
    Plug 'honza/vim-snippets'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neomake/neomake'

    " Fuzzy finder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Git and dir browsing
    Plug 'tpope/vim-fugitive'
    Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim'

    " General utils
    Plug 'kshenoy/vim-signature'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    Plug 'mg979/vim-visual-multi'
    Plug 'easymotion/vim-easymotion'

    " Airline
    " Plug 'vim-airline/vim-airline-themes'
    " Plug 'vim-airline/vim-airline'

    " Syntax and colours
    Plug 'hardcoreplayers/gruvbox9'
    Plug 'yuezk/vim-js'
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'jparise/vim-graphql'
    Plug 'maxmellon/vim-jsx-pretty'
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'KabbAmine/vCoolor.vim'
    Plug 'lilydjwg/colorizer'

    " Markdown preview from Browser
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

  call plug#end()
  call neomake#configure#automake('nrwi', 500)
endif

command! PluginBaby :so ~/.vimrc | PlugClean | PlugInstall 

set nocompatible

" Remaps the spacebar as leader
nnoremap <space> <Nop>
let mapleader = " "

syntax on
filetype plugin indent on
colorscheme gruvbox9
hi Search cterm=NONE ctermfg=NONE ctermbg=Black
" Stops vim error highlighting the second }} in JSX files.
hi Error NONE
" vim-jsx-pretty
let g:vim_jsx_pretty_colorful_config = 1

" diff colours
hi DiffAdd cterm=reverse ctermfg=35 ctermbg=235 guibg=DarkBlue
hi DiffChange cterm=reverse ctermfg=76 ctermbg=235 guibg=DarkMagenta
hi DiffDelete cterm=reverse ctermfg=166 ctermbg=235 gui=bold guifg=Blue guibg=DarkCyan
hi DiffText cterm=reverse ctermfg=37 ctermbg=235 gui=bold guibg=Red

set smartcase

set statusline=\ %n%=%t\ %m%=%y\ 
set laststatus=2
set autoindent
set smartindent
set breakindent
set nowrap
set guicursor+=a:blinkon1

" Set tabs to indent 2 spaces
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

" set breakindent
" set breakindentopt=sbr
" I use a unicode curly array with a <backslash><space>
" set showbreak=↪>\

" This amazing setting allows buffers to stay unsaved in the background
" vim will prompt you if you want to quit to save them.
set hidden

" Allows me to "gf" a node import without ".js" on the end.
set suffixesadd=.js,.ts,.tsx

" iterm does the line for us, and indent line plugin does the columns.
set nocursorline
set nocursorcolumn

" stop showing the swap file error
set shortmess+=A

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




" Airline settings:

" let g:airline_theme='lucius'

" Easymotion settings
map <Leader> <Plug>(easymotion-prefix)

" General Settings

" coc Settings
" Use `[g` and `]g` to navigate between errors
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> ga :CocAction<cr>

" Expand a snippet suggestion with CTRL-e
imap <expr> <c-e> pumvisible() ? "<Plug>(coc-snippets-expand)" : "<CR>"

" My syntax highlighting only works properly for the javascript filetype
" so we have to set various typescript and react filetypes to javascript
" here...
autocmd BufNewFile,BufRead *.jsx set filetype=javascript
autocmd BufNewFile,BufRead *.tsx set filetype=javascript
autocmd BufNewFile,BufRead *.ts set filetype=javascript

" Makes syntax highlighting in the terminal (no ohmyzsh!)
autocmd TermOpen,TermEnter zsh set filetype=sh 

"  ...then so the linting works I'm setting the coc to recognise javascript
"  as typescriptreact
let g:coc_filetype_map = {
\ 'javascript': 'typescriptreact'
\ }


" ranger Settings (Find mappings further down)
let g:ranger_replace_netrw = 1 " open ranger when vim open a directory
let g:ranger_map_keys = 0

" Fugitive mappings
"
" Add a commit or branch name to the "d" register then you can use
" it to diff any file from the current branch...
map <leader>pd :Gdiff <c-r>d<cr>
nnoremap <silent> <leader>gg :G<cr>
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <silent> <leader>gr :Gread<cr>


" Custom Commands...
"
" Search for a search term in the given directory ':F term folder'
command! -nargs=+ F :silent grep! -RHn <args> | copen | norm <c-w>L40<c-w><

" Redirects any message output to the " register
command! -nargs=+ Redir :redir => o | silent <args> | redir END | let @" = o

" Goes to my vimrc
command! Vimrc e ~/.vim/vimrc

" sources my vimrc
command! So so ~/.vimrc

" Another command to quickly delete the current buffer
command! B bd!

" Saves a session
command! Sesh mksession! ../sesh
map <leader>se :mksession! ../sesh<cr>
command! Gsesh :execute "mksession! ~/code/vimsessions/" . substitute(substitute(FugitiveHead(), "/", "-", "g"), " ", "", "g")

" Clears my terminal history
command! Clear set scrollback=1 | sleep 100m | set scrollback=10000

" Creates a ctags file, with ignoring defaults
command! Ctags silent !ctags -R --exclude=__tests__ --exclude=ios --exclude=android --exclude=firebase_environments --exclude=coverage --exclude=.github --exclude=.jest --exclude=.circleci --exclude=node_modules
map <silent> <leader>ct :silent !ctags -R --exclude=__tests__ --exclude=ios --exclude=android --exclude=firebase_environments --exclude=coverage --exclude=.github --exclude=.jest --exclude=.circleci --exclude=node_modules<cr>

" Adds any command output to the quickfix buffer
command! -nargs=+ Cex :silent redir => o | silent execute '<args>' | silent redir END | silent cex split(o, '\n') | copen
" Allows any simple of list of files to be selectable
set errorformat+=%f

" Maps some useful lists to the quickfix buffer
command! Cls :silent call setqflist(map(getbufinfo({'buflisted':1}), { key, val -> {"bufnr": val.bufnr, "lnum": val.lnum}})) | copen
command! Cjumps :silent call setqflist(getjumplist()[0]) | copen
command! Cchanges :silent call setqflist(map(getchangelist(bufnr())[0], {key, val -> {"bufnr": bufnr(), "col": val.col, "lnum": val.lnum}})) | copen
command! Ctagstack :silent call setqflist(gettagstack().items) | copen



" Terminal mode mappings
"
" Use CTRL-Space to escape term mode
tnoremap <expr> <c-space> '<c-\><c-n>'

" emulates <c-r> like insert mode for terminal mode
tnoremap <expr> <c-r> '<c-\><c-n>"'.nr2char(getchar()).'pi'
" Switch buffers in terminal mode
tnoremap <expr> <c-^> '<c-\><c-n><c-^>'
" Remaps CTRL-W in terminal mode
" (see below I've also remapped "delete-word" to match the macos delete word ALT-BS)
" tnoremap <expr> <c-w> '<c-\><c-n><c-w>'
" Lets me use all my file and buffer shortcuts from term mode
tnoremap <expr> <c-b> '<c-\><c-n>:Buffers<cr>'
tnoremap <expr> <c-p> '<c-\><c-n>:GFiles<cr>'
tnoremap <expr> <c-s> '<c-\><c-n>:Ag<cr>'



" Custom mappings
"
" hover over any word and press leader twice to console log it
" with a string to id it as well...
" nnoremap <leader><leader> yiWoconsole.log('<c-r>" : ', <c-r>")<esc>

" type any word then press ctrl-z in insert mode to console log it
" with an id string...
inoremap <C-z> <esc>ciWconsole.log('<c-r>": ', <c-r>");
inoremap <C-a> <esc>ciWconsole.log('@SEAN <c-r>": ', <c-r>");
inoremap <C-l> <esc>$v^cconsole.log(");

" Toggle numbers...
nnoremap <leader>rn :set relativenumber!<cr>


" Quick mapping for doing yarn tests
map <leader>yt <c-w>n<c-w>o:term<cr>iyarn test -u --watch<cr>

" re-maps capital Yank to yank till the end of the line
map Y y$

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

" Moving lines up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Maps Fuzzy Finder to ctrl+p
nnoremap <silent> <c-p> :GFiles<CR>
nnoremap <silent> <c-s> :Ag<CR>
nnoremap <silent> <c-b> :Buffers<CR>
" Quick search sexp in project
nmap <silent> <leader>] yiw:Ag<cr><esc>pi

" Quick switching registers
nnoremap <silent> <leader>r :echo 'Choose registers by key: 1st <- 2nd' \| let regvar = nr2char(getchar()) \| call setreg(nr2char(getchar()), getreg(regvar))<cr>

nnoremap <silent> <leader>. :RangerCurrentFile<cr>

" Tabs
map <c-w>gn :tabnew<CR>

" Buffers
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



" Defaults only for markdown files
autocmd filetype markdown set tw=73
autocmd filetype markdown set spell

" These settings have to go last...

set rtp+=~/.fzf

" transparent background (this doesn't have to go last but it's keeping
" SignColumn company)
hi Normal guibg=NONE ctermbg=NONE
" Transparent signcolumn (left hand padding)
hi SignColumn guibg=NONE ctermbg=NONE

