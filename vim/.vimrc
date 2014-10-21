""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
set t_Co=256

set ttyfast
set lazyredraw

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

filetype plugin indent on

"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Bundles
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
Bundle 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\.git/\|node_modules\|bower_components'
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'

" Vim fugitive
Bundle 'tpope/vim-fugitive'

Bundle 'quanganhdo/grb256'
color grb256
set background=dark

" solarized colorscheme
"Bundle 'altercation/vim-colors-solarized'
"color solarized
"set background=light

" less syntax highlightning
Bundle 'groenewege/vim-less'

" less files
au BufNewFile,BufRead *.less set filetype=less

" coffee script syntax highlightning
Bundle 'kchmck/vim-coffee-script'

" coffee script files
au BufNewFile,BufRead *.coffee set filetype=coffee

" Add SnipMate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"

" Improved javascript mode
Bundle "pangloss/vim-javascript"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlightning customizations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" knockout.js templates
au BufNewFile,BufRead *.ko set filetype=html

" eco templates
au BufNewFile,BufRead *.eco set filetype=html

" disable underline between a opening and end tags.
let html_no_rendering=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do not mind vi
set nocompatible

" History length
set history=100

" Update time:
"set updatetime=750

" Enable filetype plugins
filetype plugin on
filetype indent on

set tabstop=4
set shiftwidth=4
set expandtab

" Auto read when a file is changed from outside of vim
set autoread

set hidden

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gVim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
    set guioptions+=LlRrb " Add all scrollbars
    set guioptions-=LlRrb " Remove all scrollbars
    set guioptions-=M     " Remove Menu
    set guioptions-=T     " Remove Toolbar
    set guioptions-=t     " Remove tearoffmenus
    set guifont=Monaco\ 10
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
map <c-i> <Esc>

" Map <Space> to / (search) 
map <space> /
map <leader>n :noh<cr>

"Use æ for :
map æ :

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Open new tab
map <c-t> :tabe<cr>:<backspace><esc>

map <leader>e :Ex<cr>
map <leader>r :b#<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set screen offset - ensures x lines of visiblity above and below cursor
set so=5

" Show ruler
set ruler

" Set height of command bar
set cmdheight=1

" hide a buffer if its abandoned
set hid

" ignore case when searching
set ignorecase

" be smart about casing when searching (uppercase matters)
set smartcase

" highlight search results
"set hlsearch
set nohlsearch

" Make search act like search in browsers
set incsearch

set showmatch " show matching brackets

" turn off sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" enable syntax highlighting
syntax enable

" Use utf8 as default encoding
set encoding=utf8

" Use unix as standard file type
set ffs=unix,dos,mac

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" show linenumbers
set number

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ %{fugitive#statusline()}

