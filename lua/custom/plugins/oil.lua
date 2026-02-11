return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
  lazy = false,

  keys = {
    {
      '<leader>o',
      function()
        require('oil').open()
      end,
      desc = 'Open Oil file explorer',
    },
  },
}
