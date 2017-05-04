" mostly copied from
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
" https://github.com/tpope/tpope/blob/master/.vimrc
"
" see also:
" .vim/after/plugin/tabular_patterns.vim
"
execute pathogen#infect()

syntax on

set background=light
colorscheme pencil

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
au CursorHold * checktime

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

" allow inadvertant shift holding
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev E e

" highlight 80th column, and 100+
let &colorcolumn="80,".join(range(100,999),",")

" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e
"

" WEIRD FILE EXTENSIONS
" ---------------------

au BufNewFile,BufRead *.es6 set filetype=javascript
au BufNewFile,BufRead *.haml.deface set filetype=haml
au BufRead,BufNewFile *.md setlocal textwidth=80
au FileType gitcommit set tw=72

" SHORTCUTS
" ---------
"

" i18n shortcuts from https://github.com/stefanoverna/vim-i18n
map <Leader>z :call I18nTranslateString()<CR>
map <Leader>dt :call I18nDisplayTranslation()<CR>

" define_method shortcut
map <Leader>g :s/^\s*\w*\s*\(.*\)/  define_method \1 do\r  end\r/<CR>:noh<CR>

" turn a word into a ruby symbol, followed by a comma
map <Leader>, :s/\(\w\+\)/:\1,/<CR>:noh<CR>

" refresh syntax
map <Leader>r <Esc>:syntax sync fromstart<CR>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" make ctrl-p overwrite the default register with the last yanked text, and
" paste it.
nnoremap <C-p> :let @*=@0<CR>p


" vim-rspec mappings: https://github.com/thoughtbot/vim-rspec
" let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>


let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
" let g:syntastic_check_on_wq = 0
let g:syntastic_css_checkers = ['stylelint']
" let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_scss_checkers = []
let g:syntastic_html_checkers = []
" let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['rubocop']

" :SyntasticCheck
map <Leader>l :SyntasticToggleMode<CR>:SyntasticCheck<CR>


" jsx plugin
let g:jsx_ext_required = 0

nnoremap <leader>o :OverCommandLine<cr>


" CUSTOM FUNCTION TRASH
" ---------------------

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


" switch between app/spec
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc#L289
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  " consider changing this to detect app
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1 || match(current_file, '\<presenters\>') != -1 || match(current_file, '\<services\>') != -1
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


" Silver searcher hell ya
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


function Inc(...)
  let result = g:i
  let g:i += a:0 > 0 ? a:1 : 1
  return result
endfunction
