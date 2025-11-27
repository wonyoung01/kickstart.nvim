-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = 'v2.15', -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_method = 'latexmk'
      -- Force latexmk to use XeLaTeX
      -- Do not use it but add
      -- % !TeX program = xelatex
      -- vim.g.vimtex_compiler_latexmk_engines = {
      --   _ = '-xelatex',
      -- }
      -- No automatic quickfix for warning
      vim.g.vimtex_quickfix_open_on_warning = 0
    end,
  },
}
