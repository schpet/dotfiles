call plug#begin()
call plug#end()

" space as leader
let mapleader=" "

" use system clipboard
set clipboard+=unnamedplus

" smart case sensitive search
set ignorecase
set smartcase

" reselect block after indentation
vnoremap < <gv
vnoremap > >gv

" vscode commenting
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" vscode built in commands
nmap <Leader>t <Cmd>call VSCodeCall('editor.action.wordHighlight.next')<CR>
nmap <Leader>p <Cmd>call VSCodeCall('editor.action.formatDocument')<CR>
nnoremap <Leader>f <Cmd>call VSCodeCall('copyRelativeFilePath')<CR>

" vscode tromp extension
nmap <Leader>r <Cmd>call VSCodeCall('tromp.runPreviousCommand')<CR>
nmap <Leader>s <Cmd>call VSCodeCall('tromp.runCommandWithNearest')<CR>
nmap <Leader>t <Cmd>call VSCodeCall('tromp.runCommandWithFile')<CR>
nmap <Leader>a <Cmd>call VSCodeCall('tromp.runCommand')<CR>

" switch between code and tests (maybe switch to https://github.com/tpope/vim-projectionist ?)
nmap <Leader>. <Cmd>call VSCodeCall('alternate.alternateFile')<CR>
