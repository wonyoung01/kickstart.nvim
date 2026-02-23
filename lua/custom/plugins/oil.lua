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

  config = function()
    local oil = require 'oil'

    -- Toggle state
    local detailed = false

    local function setup_oil()
      oil.setup {
        columns = detailed and {
          'permissions',
          'mtime',
          'size',
          'icon',
        } or {
          'icon',
        },
      }
    end

    -- Initial setup (default: icon only)
    setup_oil()

    -- Expose toggle function
    _G.OilToggleColumns = function()
      detailed = not detailed
      setup_oil()
      vim.notify('Oil columns: ' .. (detailed and 'detailed' or 'minimal'))
      -- Refresh buffer if open
      if vim.bo.filetype == 'oil' then
        vim.cmd.edit { bang = true }
      end
    end

    oil.setup {
      keymaps = {
        ['gd'] = _G.OilToggleColumns,
        ['<leader>ff'] = {
          function()
            require('telescope.builtin').find_files {
              cwd = require('oil').get_current_dir(),
            }
          end,
          mode = 'n',
          nowait = true,
          desc = 'Find files in the current directory',
        },
        ['<leader>:'] = {
          'actions.open_cmdline',
          opts = {
            shorten_path = true,
            modify = ':h',
          },
          desc = 'Open the command line with the current directory as an argument',
        },
      },
    }
  end,
}
