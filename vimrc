if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
    Plug 'junegunn/vim-plug'

    " Auto-completion and linting
    Plug 'honza/vim-snippets'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neomake/neomake'

    " Fuzzy finder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    " My own fork of fzf vim by junegunn (adds changes and jumps)
    Plug 'seanwarman/fzf.vim'

    " Airline
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-airline/vim-airline'

    " Git and dir browsing
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tpope/vim-fugitive'


    " General utils
    Plug 'Yggdroot/indentLine'
    Plug 'kshenoy/vim-signature'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    Plug 'mg979/vim-visual-multi'
    Plug 'chrisbra/improvedft'

    " Ctags
    Plug 'bfredl/nvim-miniyank'

    " Syntax and colours
    Plug 'hardcoreplayers/gruvbox9'
    Plug 'yuezk/vim-js'
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'jparise/vim-graphql'
    Plug 'maxmellon/vim-jsx-pretty'
    Plug 'peitalin/vim-jsx-typescript'

    " Markdown preview from Browser
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

  call plug#end()
  call neomake#configure#automake('nrwi', 500)
endif

func RemoveNumbers()
  set nonumber
  set norelativenumber
  set nocursorline
  set nocursorcolumn
endfunc

set nocompatible

" coc Settings
" Use `[g` and `]g` to navigate between errors
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> ga :CocAction<cr>

" Expand a snippet suggestion with CTRL-l
imap <C-l> <Plug>(coc-snippets-expand)

" Remaps the spacebar as leader
nnoremap <space> <Nop>
let mapleader = " "

" Styling and colors

" transparent background
hi Normal guibg=NONE ctermbg=NONE

syntax on
filetype plugin indent on
colorscheme gruvbox9
hi Search cterm=NONE ctermfg=NONE ctermbg=Black
" Stops vim error highlighting the second }} in JSX files.
hi Error NONE
" vim-jsx-pretty
let g:vim_jsx_pretty_colorful_config = 1
" Gets rid of Vim's builtin mode status because we're using Lightline
set noshowmode
set nu
set relativenumber
set smartcase
set laststatus=2
set autoindent
set smartindent
set breakindent
set nowrap
set guicursor+=a:blinkon1
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

" Set tabs to indent 2 spaces
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

" Maintain undo
set undofile 
set undodir=~/.vim/undodir

set mouse=a


" Airline settings:

let g:airline_theme='lucius'


" General Settings

" My syntax highlighting only works properly for the javascript filetype
" so we have to set various typescript and react filetypes to javascript
" here...
autocmd BufNewFile,BufRead *.jsx set filetype=javascript
autocmd BufNewFile,BufRead *.tsx set filetype=javascript
autocmd BufNewFile,BufRead *.ts set filetype=javascript

"  ...then so the linting works I'm setting the coc to recognise javascript
"  as typescriptreact
let g:coc_filetype_map = {
\ 'javascript': 'typescriptreact'
\ }


" coc settings

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



" NERDTree Settings (Find mappings further down)
let NERDTreeChDirMode = 1

" Custom Commands...
"
" hover over any word and press leader twice to console log it
" with a string to id it as well...
" nnoremap <leader><leader> yiWoconsole.log('<c-r>" : ', <c-r>")<esc>

" type any word then press ctrl-z in insert mode to console log it
" with an id string...
inoremap <C-z> <esc>ciWconsole.log('<c-r>": ', <c-r>")

" Closes a whole tab including all splits. 
map <silent> <c-w>C :tabclose<cr>

" inserts a console.dir ':CD myVariable'
command! -nargs=+ CD :norm! oconsole.dir(<args>, { depth: null })

" Search for a search term in the given directory ':F term folder'
command! -nargs=+ F :norm :set wildignore+=node_modules/**/*,./node_modules/**/*,package-lock.json<CR>:vim <args>/**/* <CR>:copen<CR><C-w>L:set nowrap<CR>40<C-w><:set wildignore-=node_modules/**/*,./node_modules/**/*,package-lock.json<CR>




" COOLDUDE3000 COMMAND BOOKMARKS
"
" Write a list of commands (eg "F thing src" or "vim thing src/**/* | copen") 
" to a file.bmk, hover over the command and press Enter to execute the command in a new tab.
"
" Creates a filetype for any file ending '.bkm'...
autocmd BufNewFile,BufRead *.bkm set filetype=vimbookmarks syntax=vim

" Maps a command to enter when using that file (note <buffer> only applies
" the map to the current buffer...
autocmd FileType vimbookmarks map <buffer> <silent> <cr> yy:tabnew<cr>:<c-r>"<cr>

" There's a .bkm file saved in .vim/bookmarks/. Open that whenever I press <leader>b
" map <leader>b <c-w>n<c-w>J:e ~/.vim/bookmarks/bookmarks.bkm<cr>
map <F3> <c-w>n:e ~/.vim/bookmarks/bookmarks.bkm<cr>
map <F4> :tabnew ~/.vim/bookmarks/bookmarks.bkm<cr>



" Experiment with my own CHANGE BUFFER shortcut...
" I've replaced this with fuzzy finder's :Buffers command
" func GetBuffer()
"   let g:gbff = input('Enter buffer: ')
"   call inputrestore()
"   execute ':b' . g:gbff
" endfunc

" Do CTRL-b to open the list of available buffers
" nnoremap <c-b> :ls<cr>:call GetBuffer()<cr>



" Custom mappings

" JSX Element commenting, relies on vim commentary ('S')
vmap K S{%i*/<Esc>l%a/*<Esc>

nnoremap ]] ]M
nnoremap [[ [m
nnoremap ][ ]m
nnoremap [] [M

" Goto MDN definition of the variable under the cursor
map <silent> <c-h>mdn yiW:!open "https://developer.mozilla.org/en-US/search?q=<C-r>"&topic=js"<CR>

" Creates a react functional comp using the name of the current file
" map <silent> <leader>q iimport React from 'react'function <c-r>%<BS><BS><BS>bbvBdyeA() {return (div<BS><BS><BS><div id="""></div>Goexport default "?id="vi"ugg:w

" Adds connect to a react functional comp
" map <silent> <leader>w oimport { connect} from 'react-reduxGwwiconnect()vevbS)F)istate => ({?functionf)i{gg:w

" Creates a React Native Fn Comp
" map <silent> <leader>r  iimport React from 'react';import { View, Text} from 'react-native';const %bbDbbvBdyeA = () => {return (<View><Text>"</Text></View>jA;jA;oexport default ";{{:w

" converts REDUX_CONSTANTS to reduxConstants
" map <silent> <leader>U ve:s/_\(.\)/\L\1/ggv~

" nnoremap <silent> <leader>gt <c-w><c-n><c-w>T:terminal<cr>:call RemoveNumbers()<cr>i

" nnoremap <silent> <leader>my <c-w><c-n><c-w>T:terminal<cr>:call RemoveNumbers()<cr>:set filetype=sql<cr>imycli mysql://admin@bigg-internal.cfhob3uc9nfn.eu-west-1.rds.amazonaws.com:3306 -p tb3wuP9uAeTmrMT3x6WXkeZyB<cr><C-l><F4>show databases<cr>

" Sets escape to go to normal mode from terminal mode.
" Note: this breaks escaping the fuzzy.vim escaping but just use c-q instead
tnoremap <esc> <c-\><c-n>

nnoremap <silent> rnr :tabnew<cr>:term<cr>:call RemoveNumbers()<cr>irnr<cr> 

" select last pasted text
nnoremap gp `[v`]

" Moving lines up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" inoremap <C-j> <Esc>:m .+1<CR>==gi
" inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Maps Fuzzy Finder to ctrl+p
nnoremap <silent> <c-p> :GFiles<CR>
nnoremap <silent> <leader><leader>p :GFiles<CR>
nnoremap <silent> <c-b> :Buffers<CR>
nnoremap <silent> <leader><leader>b :Buffers<CR>
nnoremap <silent> <c-s> :Ag<CR>
nnoremap <silent> <leader><leader>s :Ag<CR>
nnoremap <silent> <c-m> :Marks<cr>
nnoremap <silent> <leader><leader>m :Marks<cr>

nnoremap <silent> <leader><leader>/ :History/<cr>

nnoremap <silent> <leader><leader>; :Changes<CR>
nnoremap <silent> <leader><leader>o :Jumps<CR>

nnoremap <silent> <C-t> :NERDTreeToggle<CR>:vert res 30<cr>

nnoremap <silent> <leader><leader>t :Tags<cr>

" Reveal this file in nerdtree
map <silent> <leader>f :NERDTreeFind<CR>

" Tabs
map <c-w>gn :tabnew<CR>
map [t :tabp<cr>
map ]t :tabn<cr>

" Buffers
map <leader>bp :bp<cr>
map <leader>bn :bn<cr>
map <leader>bd :bd!<cr>
map ]b :bn<cr>
map [b :bp<cr>

" Terminal buffer
nnoremap <silent> <leader>tn <c-w><c-n><c-w>J12<c-w>-:terminal<cr>:call RemoveNumbers()<cr>i
nnoremap <silent> <leader>to :b {term:}<cr>i


" delete all buffers but this one.
nnoremap <silent> <leader>bD :bd! <c-a><cr><c-o>:bn<cr>:bd<cr>




" Put the word under the cursor into the search, like * but without jumping
nnoremap <silent> <leader>/w yiw:let @/ = @"<cr>
nnoremap <silent> <leader>/W yiW:let @/ = @"<cr>


set rtp+=~/.fzf

" Defaults only for markdown files
autocmd filetype markdown set tw=73
autocmd filetype markdown set spell
