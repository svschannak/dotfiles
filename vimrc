set nocompatible
set showmode
set nowrap
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set shiftround
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set showmatch
set ignorecase
set smartcase
set hlsearch
set incsearch
set vb t_vb=
syntax enable

" allow project specific settings by
" placing .vimrc files in a directory
set exrc
set secure

" Vundle-Plugin Manager
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Conque-Shell'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'pboehm/snipmate-snippets'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-rails.git'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'godlygeek/tabular'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'sophacles/vim-bundle-sparkup'
Bundle 'tComment'
Bundle 'briandoll/change-inside-surroundings.vim'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'gregsexton/MatchTag'
Bundle 'Raimondi/delimitMate'
Bundle 'vim-scripts/vim-json-bundle'

filetype plugin indent on     " required!

" Mappings
let mapleader = ","
map <silent> <leader>y :NERDTreeToggle<CR>
map <silent> <c-c> :q<CR>
map <silent> <c-s> :w<CR>

" move between splittings
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" move between tabs
nmap <silent> <C-Left> :tabp<CR>
nmap <silent> <C-Right> :tabn<CR>

map - <C-W>-
map + <C-W>+
map # <C-W><
map ´ <C-W>>

map Q gq


"T-Comment
map <leader>c <c-_><c-_>

" Hide search highlighting
map <Leader>h :set invhls <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" No Help, please
nmap <F1> <Esc>

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

filetype plugin on

" autocmd's
autocmd BufWritePre *.rb :%s/\s\+$//e
autocmd BufRead,BufNewFile *.html.erb setlocal filetype=html.eruby
autocmd BufRead,BufNewFile *.less setlocal filetype=css

" Enable soft-wrapping for text files
autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

" Command that set up vim to break text
command! -nargs=* Wrap set wrap linebreak nolist
command! -nargs=* Sn tabedit ~/.vim/bundle/snipmate-snippets/snippets
