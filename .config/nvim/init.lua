require("config.lazy")

-- space as leader
vim.g.mapleader = " "

-- use system clipboard
vim.opt.clipboard:append("unnamedplus")

-- smart case sensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- reselect block after indentation
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-- vscode commenting
vim.api.nvim_set_keymap('x', 'gc', '<Plug>VSCodeCommentary', { noremap = false })
vim.api.nvim_set_keymap('n', 'gc', '<Plug>VSCodeCommentary', { noremap = false })
vim.api.nvim_set_keymap('o', 'gc', '<Plug>VSCodeCommentary', { noremap = false })
vim.api.nvim_set_keymap('n', 'gcc', '<Plug>VSCodeCommentaryLine', { noremap = false })

-- vscode built in commands
vim.api.nvim_set_keymap('n', '<Leader>t', '<Cmd>call VSCodeCall("editor.action.wordHighlight.next")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>p', '<Cmd>call VSCodeCall("editor.action.formatDocument")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f', '<Cmd>call VSCodeCall("copyRelativeFilePath")<CR>', { noremap = true, silent = true })

-- aider: write '/add <current relative file path>' into the vscode terminal
vim.api.nvim_set_keymap('n', '<Leader>i', "<Cmd>call VSCodeCall('workbench.action.terminal.sendSequence', { 'text': '/add ' . expand('%:p:.'). \"\\n\" })<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>o', "<Cmd>call VSCodeCall('workbench.action.terminal.sendSequence', { 'text': '/read ' . expand('%:p:.'). \"\\n\" })<CR>", { noremap = true, silent = true })


-- vscode tromp extension
vim.api.nvim_set_keymap('n', '<Leader>r', '<Cmd>call VSCodeCall("tromp.runPreviousCommand")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>s', '<Cmd>call VSCodeCall("tromp.runCommandWithNearest")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>t', '<Cmd>call VSCodeCall("tromp.runCommandWithFile")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>a', '<Cmd>call VSCodeCall("tromp.runCommand")<CR>', { noremap = true, silent = true })

-- open new aider session with current file
vim.api.nvim_set_keymap('n', '<Leader>u', "<Cmd>call VSCodeCall('workbench.action.terminal.sendSequence', { 'text': 'aider ' .. vim.fn.expand('%:p') .. \"\\n\" })<CR>", { noremap = true, silent = true })

-- switch between code and tests (maybe switch to https://github.com/tpope/vim-projectionist ?)
-- vim.api.nvim_set_keymap('n', '<Leader>.', '<Cmd>call VSCodeCall("alternate.alternateFile")<CR>', { noremap = true, silent = true })


require('solarized').set()
