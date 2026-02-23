local M = {}

M.is_tmux = function()
  return vim.env.TMUX ~= nil
end

M.is_kitty = function()
  return vim.env.TERM == 'xterm-kitty'
end

return {
  '3rd/image.nvim',
  cond = not M.is_tmux() and M.is_kitty(),
  event = 'VeryLazy',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = { 'markdown' },
          highlight = { enable = true },
        }
      end,
    },
  },
  opts = {
    backend = 'kitty',
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
      },
      neorg = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { 'norg' },
      },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 70,
    kitty_method = 'normal',
  },
}
