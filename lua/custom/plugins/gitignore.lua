return {
  'wintermute-cell/gitignore.nvim',
  config = function()
    local gitignore = require 'gitignore'
    require('which-key').register {
      ['<leader>g'] = { name = '[G]enerate g[I]tignore', _ = 'which_key_ignore' },
      ['<leader>gi'] = { name = '[G]enerate g[I]tignore', _ = 'which_key_ignore' },
    }
    vim.keymap.set('n', '<leader>gi', gitignore.generate)
  end,
}
