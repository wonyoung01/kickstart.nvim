local fn = vim.fn

local map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  event = 'VeryLazy',
  opts = {
    open_mapping = [[<c-\>]],
    direction = 'horizontal',

    -- valid toggleterm options
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = false,
    persist_size = true,

    highlights = {
      FloatBorder = { link = 'FloatBorder' },
      NormalFloat = { link = 'NormalFloat' },
    },

    float_opts = {
      border = 'rounded', -- change to "single" / "double" / "shadow" / "none"
      winblend = 3,
    },

    size = function(term)
      if term.direction == 'horizontal' then
        return math.floor(vim.o.lines * 0.3)
      elseif term.direction == 'vertical' then
        return math.floor(vim.o.columns * 0.4)
      end
      return 15
    end,
  },

  config = function(_, opts)
    require('toggleterm').setup(opts)

    --------------------------------------------------------------------
    -- ✅ Terminal Keymaps (your requested mappings)
    --------------------------------------------------------------------
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }

      -- window navigation inside terminal
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

      -- allow <C-w> commands
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    -- Automatically apply mappings when entering any terminal
    vim.cmd [[autocmd! TermOpen term://* lua set_terminal_keymaps()]]

    -- Optional: If you want autochdir behavior, it's a Vim option (not ToggleTerm)
    -- vim.o.autochdir = true

    local float_handler = function(term)
      -- If you have a terminal-mode mapping "jk" defined elsewhere, remove it for this terminal buffer
      if fn.mapcheck('jk', 't') ~= '' then
        pcall(vim.keymap.del, 't', 'jk', { buffer = term.bufnr })
      end
      -- If you mapped <Esc> in terminal-mode elsewhere, remove it too
      if fn.mapcheck('<esc>', 't') ~= '' then
        pcall(vim.keymap.del, 't', '<esc>', { buffer = term.bufnr })
      end
    end

    local Terminal = require('toggleterm.terminal').Terminal

    local lazygit = Terminal:new {
      cmd = 'lazygit',
      dir = 'git_dir',
      hidden = true,
      direction = 'float',
      on_open = float_handler,
    }

    local lazydocker = Terminal:new {
      cmd = 'lazydocker',
      dir = 'git_dir',
      hidden = true,
      direction = 'float',
      on_open = float_handler,
    }

    local btop = Terminal:new {
      cmd = 'btop',
      hidden = true,
      direction = 'float',
      on_open = float_handler,
      highlights = {
        FloatBorder = { guibg = 'Black', guifg = 'DarkGray' },
        NormalFloat = { guibg = 'Black' },
      },
    }

    local htop = Terminal:new {
      cmd = 'htop',
      hidden = true,
      direction = 'float',
      on_open = float_handler,
    }
    local nvitop = Terminal:new {
      cmd = 'nvitop',
      hidden = true,
      direction = 'float',
      on_open = float_handler,
    }

    local gh_dash = Terminal:new {
      cmd = 'gh dash',
      hidden = true,
      direction = 'float',
      on_open = float_handler,
      float_opts = {
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        width = function()
          return math.floor(vim.o.columns * 0.95)
        end,
      },
    }

    map('n', '<leader>lh', function()
      gh_dash:toggle()
    end, { desc = 'toggleterm: toggle gh dash' })
    map('n', '<leader>lg', function()
      lazygit:toggle()
    end, { desc = 'toggleterm: toggle lazygit' })
    map('n', '<leader>ld', function()
      lazydocker:toggle()
    end, { desc = 'toggleterm: toggle lazydocker' })

    vim.api.nvim_create_user_command('Btop', function()
      btop:toggle()
    end, {})
    vim.api.nvim_create_user_command('Htop', function()
      htop:toggle()
    end, {})
    vim.api.nvim_create_user_command('Nvitop', function()
      nvitop:toggle()
    end, {})
  end,
}
