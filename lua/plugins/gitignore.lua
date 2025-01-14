return {
  'wintermute-cell/gitignore.nvim',
  cmd = 'Gitignore',
  config = function()
    local gitignore = require 'gitignore'
    vim.keymap.set('n', '<leader>gi', gitignore.generate)
  end,
}
