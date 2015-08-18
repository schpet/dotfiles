" mostly copied from
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
" https://github.com/tpope/tpope/blob/master/.vimrc 
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

set t_Co=256 " 256 colors
set background=light


let mapleader = " "

map Y y$
map Q <Nop> 

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

cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev E e

" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e

" TODO fix the bin/rspec garb
let g:rspec_command = 'call Send_to_Tmux("bin/rspec {spec}\n")'

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:syntastic_check_on_wq = 0
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_html_checkers = []
let g:syntastic_ruby_checkers = ['rubocop']

nnoremap <leader>o :OverCommandLine<cr>

" SELECTA (<leader>f)

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

let g:selecta_command = 'find * ' .
                      \ '-type f ' .
                      \ '-not -wholename "*node_modules*" ' .
                      \ '-not -wholename "*vendor*" ' .
                      \ '-not -wholename "*tmp*" '


" Find all files in all non-dot directories starting in the working directory.
" " Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand(g:selecta_command, "", ":e")<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1 || match(current_file, '\<services\>') != -1 || match(current_file, '\<presenters\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

