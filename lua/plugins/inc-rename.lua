return {
  'smjonas/inc-rename.nvim',
  keys = {
    { '<leader>rn', desc = 'Rename' },
  },
  config = function()
    require('inc_rename').setup()
    vim.keymap.set('n', '<leader>rn', ':IncRename ', { desc = 'Rename' })
  end,
}
