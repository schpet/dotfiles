" mostly copied from
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
" https://github.com/tpope/tpope/blob/master/.vimrc
"
" see also:
" .vim/after/plugin/tabular_patterns.vim
"
execute pathogen#infect()

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

" highlight 80th column
let &colorcolumn="80,100"

" weird file extensions
autocmd BufNewFile,BufRead *.md setlocal textwidth=80 syn=off
autocmd BufNewFile,BufRead *.inky set syntax=haml

autocmd FileType gitcommit set tw=72

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

" turn ruby assignments into rspec let
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
command! PromoteToLet :call PromoteToLet()
nnoremap <leader>o :PromoteToLet<cr>

" turn string into exported constant (redux)
nnoremap <leader>h :s/\s*\"\(\w\+\)\".*/export const \1 = "\1"/<cr>

" ~/.vimrc
"
" allows <leader>v to swap from this:
"
"     it "runs a test", :vcr do ...
"
" to this:
"
"     it "runs a test", vcr: { record: :all } do ...
"
function! RecordWithVcr()
  normal! yy

  if @" =~# '.*:vcr.*'
    :.s/:vcr/vcr: { record: :all }/
  endif

  if @" =~# '.*vcr: { record: :all }.*'
    :.s/vcr: { record: :all }/:vcr/
  endif
endfunction
command! RecordWithVcr :call RecordWithVcr()
nnoremap <leader>v :RecordWithVcr<cr>

" todo: replace this with ale?
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
" let g:syntastic_check_on_wq = 0
let g:syntastic_css_checkers = ['stylelint']
" let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_scss_checkers = []
let g:syntastic_html_checkers = []
" let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_always_populate_loc_list = 1


" :SyntasticCheck
" nnoremap <Leader>l :SyntasticToggleMode<CR>:SyntasticCheck<CR>

" jsx plugin
let g:jsx_ext_required = 0

" fuzzy searching
nnoremap <leader>f :FZF<cr>

function! OpenTestAlternate()
  let current_file = expand("%")
  let new_file = system("test-alternative " . current_file)
  exec ':e ' . new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

function! OpenStyleAlternate()
  if (expand("%:e") == "js")
    exec ':e ' . expand("%:r") . ".css"
  else
    exec ':e ' . expand("%:r") . ".js"
  endif
endfunction
nnoremap <leader>, :call OpenStyleAlternate()<cr>

" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

inoremap \fn <C-R>=expand("%:t:r")<CR>

" Use ag over grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif


let g:prettier#config#semi = 'false'
let g:prettier#config#trailing_comma = 'es5'
let g:prettier#config#single_quote = 'false'
