return {
  'nvim-mini/mini.diff',
  -- Just setup with defaults
  config = function()
    require('mini.diff').setup()
  end,
}
-- return {
--   'nvim-mini/mini.diff',
--   opts = {
--     view = {
--       style = 'sign',
--       signs = {
--         add = '▎',
--         change = '▎',
--         delete = '',
--       },
--     },
--   },
--   config = function(_, opts)
--     local diff = require 'mini.diff'
--     diff.setup(opts)
--     diff.enable() -- ← turns it on by default
--   end,
--   keys = {
--     {
--       '<leader>go',
--       function()
--         require('mini.diff').toggle_overlay(0)
--       end,
--       desc = 'Toggle mini.diff overlay',
--     },
--   },
-- }
