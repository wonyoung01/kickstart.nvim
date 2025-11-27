local function buf_build_xelatex(client, bufnr)
  local uri = vim.uri_from_bufnr(bufnr)
  local params = {
    textDocument = { uri = uri },
    options = {
      executable = 'xelatex',
      args = { '-synctex=1', '-interaction=nonstopmode', '-file-line-error', vim.api.nvim_buf_get_name(bufnr) },
    },
  }
  client:request('textDocument/build', params, function(err, result)
    if err then
      vim.notify('Build error: ' .. tostring(err), vim.log.levels.ERROR)
      return
    end
    local texlab_build_status = {
      [0] = 'Success',
      [1] = 'Error',
      [2] = 'Failure',
      [3] = 'Cancelled',
    }
    vim.notify('XeLaTeX build ' .. texlab_build_status[result.status], vim.log.levels.INFO)
  end, bufnr)
end

return {
  -- vim.api.nvim_create_user_command('TexBuildXe', function()
  --   local client = vim.lsp.get_active_clients({ name = 'texlab' })[1]
  --   if client then
  --     buf_build_xelatex(client, vim.api.nvim_get_current_buf())
  --   else
  --     vim.notify('No texlab client attached', vim.log.levels.WARN)
  --   end
  vim.api.nvim_create_user_command('TexBuildXe', function()
    local fname = vim.api.nvim_buf_get_name(0)
    vim.fn.jobstart({ 'latexmk', '-xelatex', '-synctex=1', '-interaction=nonstopmode', '-file-line-error', fname }, {
      stdout_buffered = true,
      stderr_buffered = true,
      on_exit = function(_, code)
        if code == 0 then
          vim.notify('XeLaTeX build succeeded', vim.log.levels.INFO)
        else
          vim.notify('XeLaTeX build failed (exit ' .. code .. ')', vim.log.levels.ERROR)
        end
      end,
    })
  end, { desc = 'Build with latexmk -xelatex' }), -- end, { desc = 'Build current TeX file with XeLaTeX' }),
}
