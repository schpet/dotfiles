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
