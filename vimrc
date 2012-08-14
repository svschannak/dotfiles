"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My custom vim configuration with a set of installed plugins "
" through Vundle-Plugin-Manager                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" common options
set nocompatible
set showmode
set nowrap
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
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
set visualbell
set noerrorbells visualbell t_vb=

" allow project specific settings by placing .vimrc files in a directory
set exrc
set secure

syntax enable

""""""""""""""""""""""""
" Gui specific options "
""""""""""""""""""""""""
if has('gui_running')
    set cursorline

    colorscheme railscasts

    " highlight 80th column
    if exists('+colorcolumn')
        set colorcolumn=80
    endif

    highlight ColorColumn guibg=#333435
endif

""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Management: List of installed plugins "
""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Snipmate plugin with a set of snippets and two dependencies
Bundle 'garbas/vim-snipmate'
Bundle 'honza/snipmate-snippets'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'

" NerdTree file explorer
Bundle 'scrooloose/nerdtree'

" THE rails gem
Bundle 'tpope/vim-rails.git'

" surround or change surrounding of text
Bundle 'tpope/vim-surround'

" Git integration
Bundle 'tpope/vim-fugitive'
let g:fugitive_git_executable="LC_ALL=en_US.UTF-8 git"

" provides function that aligns text in form of a table
" :Tabularize /regex/
Bundle 'godlygeek/tabular'

" provides custom movement, Type <leader><leader> + w/b
" this marks the first character of every word
Bundle 'Lokaltog/vim-easymotion'

" Easy creation of HTML structure through CTRL-e
" div#test => <div id="test"></div>
Bundle 'sophacles/vim-bundle-sparkup'

" providex commenting function
Bundle 'tComment'

" preview markdown in browser
Bundle 'waylan/vim-markdown-extra-preview'
let g:VMEPhtmlreader="google-chrome"

" Change inside something through <leader>ci
Bundle 'briandoll/change-inside-surroundings.vim'

" Remove Trailing Whitespace
Bundle 'bronson/vim-trailing-whitespace'

" highlights matching html tags on hover
Bundle 'gregsexton/MatchTag'

" closes "'... automatically
Bundle 'Raimondi/delimitMate'
Bundle 'vim-scripts/vim-json-bundle'

" bar that holds variables/functions
Bundle 'majutsushi/tagbar'

" verbose status bar
if has('gui_running')
    Bundle 'Lokaltog/vim-powerline'
    set laststatus=2
endif

" better grep
Bundle 'mileszs/ack.vim'

" fuzzy finder on CTRL+P
Bundle 'kien/ctrlp.vim'
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*build/*

" send commands to tmux
" LEADER+s to select session, LEADER+sx for a command prompt
Bundle "westoque/muxmate"

filetype plugin indent on     " required!

""""""""""""
" Mappings "
""""""""""""
let mapleader = ","

map <silent> <leader>y :NERDTreeToggle<CR>
map <silent> <Leader>g :Gstatus<CR>
map <silent> <leader>t :TagbarToggle<CR>
map <leader>c <c-_><c-_> "TComment

" paste from clipboard
nmap <silent> <leader>v "+gP

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

" pane resizing
map - <C-W>-
map + <C-W>+
map # <C-W><
map ´ <C-W>>

" reformat block of text to fit in 80 chars
map Q gq

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

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
autocmd! bufwritepost .vimrc source % "reload config on save
autocmd GUIEnter * set visualbell t_vb=
autocmd BufWritePre *.rb :%s/\s\+$//e
autocmd BufRead,BufNewFile *.html.erb setlocal filetype=html.eruby
autocmd BufRead,BufNewFile *.less setlocal filetype=css
autocmd BufRead,BufNewFile *.rb setlocal sw=2 ts=2 softtabstop=2

" Enable soft-wrapping for text files
autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

" Command that set up vim to break text
command! -nargs=* Wrap set wrap linebreak nolist
command! -nargs=* Sn tabedit ~/.vim/bundle/snipmate-snippets/snippets
