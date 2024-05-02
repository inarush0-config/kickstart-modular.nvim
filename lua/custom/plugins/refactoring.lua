return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('refactoring').setup()
    vim.keymap.set('x', '<leader>re', ':Refactor extract ')
    vim.keymap.set('x', '<leader>rv', ':Refactor extract_var ')
    vim.keymap.set('n', '<leader>rb', ':Refactor extract_block')
  end,
}
