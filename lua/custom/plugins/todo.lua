-- https://github.com/folke/todo-comments.nvim

return {
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      keywords = {
        PERF = { alt = { 'DONE' } },
      },
      highlight = {
        comments_only = false, -- <-- allow matches outside comments (needed for markdown)
      },
    },
  },
}
