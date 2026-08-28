local is_tmux = vim.env.TMUX ~= nil

if is_tmux then
  vim.g.clipboard = {
    name = 'tmux',
    copy = {
      ['+'] = 'tmux load-buffer -w -',
      ['*'] = 'tmux load-buffer -w -',
    },
    paste = {
      ['+'] = 'tmux save-buffer -',
      ['*'] = 'tmux save-buffer -',
    },
    cache_enabled = 0,
  }
else
  vim.g.clipboard = 'osc52'
end

return {}
