-- lua/config/folding.lua

-- Short aliases
local o = vim.o

-- Basic folding behavior
o.foldmethod = 'expr' -- or "indent", "marker", etc.
o.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- if using treesitter
o.foldenable = true
o.foldlevel = 99 -- keep folds open by default
o.foldlevelstart = 99

-- Window-local options (set globally so new windows inherit it too)
o.foldcolumn = '1' -- show a fold column on the left

-- Optional: some mappings for folding
vim.keymap.set('n', 'zf', 'za', { desc = 'Toggle fold' })
-- Open/close all folds (might be redundant with default mappings)
-- vim.keymap.set('n', 'zO', 'zR', { desc = 'Open all folds' })
-- vim.keymap.set('n', 'zC', 'zM', { desc = 'Close all folds' })

return {}
