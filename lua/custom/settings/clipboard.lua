local is_tmux = vim.env.TMUX ~= nil

if not is_tmux then
  return {}
end

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

return {}
