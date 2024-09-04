return {
  -- Alternate between files, such as foo.go and foo_test.go
  {
    "rgroli/other.nvim",
  keys = {
    { '<leader>.', '<cmd>Other<CR>', desc = 'Alternate file' },
  },
    config = function ()
      require("other-nvim").setup({
        mappings = {
          "rails", --builtin mapping
	      },
      })

      vim.api.nvim_create_user_command('A',   function(opts)
        require('other-nvim').open(opts.fargs[1])
      end, {nargs = '*'})

      vim.api.nvim_create_user_command('AV',   function(opts)
        require('other-nvim').openVSplit(opts.fargs[1])
      end, {nargs = '*'})

      vim.api.nvim_create_user_command('AS',   function(opts)
        require('other-nvim').openSplit(opts.fargs[1])
      end, {nargs = '*'})
    end,
  },
}
