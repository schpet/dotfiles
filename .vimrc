" mostly copied from
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
" https://github.com/tpope/tpope/blob/master/.vimrc

syntax on

filetype plugin indent on

set nocompatible
set hidden
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase
set nobackup
set nowritebackup
set noswapfile
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set undofile
set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set splitbelow
set splitright
set clipboard=unnamed
set autoread
set showcmd
set backspace=indent,eol,start
au CursorHold * checktime

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu

set t_Co=256 " 256 colors
set background=light
" set background=dark

let mapleader=" "

map Y y$
"noremap Q <Nop> deleteme

" pane movement
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <silent> k gk
nnoremap <silent> j gj

" reselect block after indentation
vnoremap < <gv
vnoremap > >gv

" allow inadvertant shift holding
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev E e

" weird file extensions
autocmd BufNewFile,BufRead *.md setlocal textwidth=80 syn=off
autocmd BufNewFile,BufRead *.inky set syntax=haml

autocmd FileType gitcommit set tw=72
autocmd BufNewFile,BufRead .gitconfig setlocal noexpandtab
autocmd FileType gitcommit  setl ts=2

" make ctrl-p overwrite the default register with the last *yanked* text, and
" paste it.
nnoremap <C-p> :let @*=@0<CR>p

" test runners (rspec, etc)
nnoremap <silent> <leader>t :TestFile<CR>
nnoremap <silent> <leader>s :TestNearest<CR>
nnoremap <silent> <leader>r :TestLast<CR>
nnoremap <silent> <leader>a :TestSuite<CR>
let g:test#javascript#tap#reporters = ['faucet']

" for updating jest snapshots
nnoremap <leader>u :TestNearest -u<cr>

let test#ruby#rspec#executable = 'rrspec'
" let test#ruby#minitest#file_pattern = '_spec\.rb' " the default is '_test\.rb'

" expand %% to the directory of the current file
cnoremap <expr> %% expand('%:h').'/'

" fuzzy searching
set rtp+=/usr/local/opt/fzf
nnoremap <leader>f :FZF<cr>

inoremap \fn <C-R>=expand("%:t:r")<CR>

" Use ag over grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

let g:prettier#config#semi = 'false'
let g:prettier#config#trailing_comma = 'es5'
let g:prettier#config#single_quote = 'false'
