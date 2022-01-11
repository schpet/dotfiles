call plug#begin()
call plug#end()

" space as leader
let mapleader=" "

" use system clipboard
set clipboard+=unnamedplus

" smart case sensitive search
set ignorecase
set smartcase

" vscode commenting
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" vscode fly thru refs
nmap <Leader>t <Cmd>call VSCodeCall('editor.action.wordHighlight.next')<CR>
nmap <Leader>p <Cmd>call VSCodeCall('editor.action.formatDocument')<CR>

" vscode formatting
nnoremap <Leader>p <Cmd>call VSCodeCall('editor.action.formatDocument')<CR>

" reselect block after indentation
vnoremap < <gv
vnoremap > >gv