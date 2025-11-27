-- Custom commands for s/regex/regex/ things

return {
  vim.api.nvim_create_user_command('RemoveFloats', [[:<line1>,<line2>s/\v[-+]?\d*\.?\d+([eE][-+]?\d+)?//g]], { range = true }),
}
