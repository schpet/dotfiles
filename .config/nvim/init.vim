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

" vscode fly thru refs
nmap <Leader>t <Cmd>call VSCodeCall('editor.action.wordHighlight.next')<CR>

" vscode run prettier or whatever formatter
nmap <Leader>p <Cmd>call VSCodeCall('editor.action.formatDocument')<CR>

" vscode tromp
nmap <Leader>r <Cmd>call VSCodeCall('tromp.runPreviousCommand')<CR>
nmap <Leader>s <Cmd>call VSCodeCall('tromp.runCommandWithNearest')<CR>
nmap <Leader>t <Cmd>call VSCodeCall('tromp.runCommandWithFile')<CR>
nmap <Leader>a <Cmd>call VSCodeCall('tromp.runCommand')<CR>

" vscode other
nnoremap <Leader>p <Cmd>call VSCodeCall('editor.action.formatDocument')<CR>
nnoremap <Leader>f <Cmd>call VSCodeCall('copyRelativeFilePath')<CR>



nmap <Leader>. <Cmd>call VSCodeCall('alternate.alternateFile')<CR>
